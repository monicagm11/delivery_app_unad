
import 'package:delivery_app/domain/entities/cart_item.dart';
import 'package:delivery_app/domain/entities/payment_method.dart';
import 'package:delivery_app/presentation/notifier/cart/cart_notifier.dart';
import 'package:delivery_app/presentation/notifier/checkout/checkout_notifier.dart';
import 'package:delivery_app/presentation/notifier/checkout/checkout_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';




class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _notesCtrl = TextEditingController();
  final _changeCtrl = TextEditingController();
  PaymentMethod _paymentMethod = PaymentMethod.cash;

  // Comprobante de transferencia
  String? _voucherPath;
  Uint8List? _voucherBytes;

  @override
  void initState() {
    super.initState();
    final cart = ref.read(cartNotifierProvider);
    Future.microtask(() => ref
        .read(checkoutNotifierProvider.notifier)
        .init(cart.eventId ?? '', cart.items));
  }

  @override
  void dispose() {
    _notesCtrl.dispose();
    _changeCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickVoucher() async {
    final file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (file == null) return;
    if (kIsWeb) {
      final bytes = await file.readAsBytes();
      setState(() {
        _voucherBytes = bytes;
        _voucherPath = file.name;
      });
    } else {
      setState(() => _voucherPath = file.path);
    }
  }

  void _removeVoucher() => setState(() {
        _voucherPath = null;
        _voucherBytes = null;
      });

  void _showQrSheet(String qrUrl) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Container(
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('QR para transferencias',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            qrUrl.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(qrUrl,
                        height: 240, fit: BoxFit.contain),
                  )
                : Container(
                    height: 320,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text('QR no disponible',
                          style:
                              TextStyle(color: Colors.grey.shade500)),
                    ),
                  ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<CheckoutState>(checkoutNotifierProvider, (_, state) {
      if (state.isCheckoutCompleted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pedido confirmado'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      }
    });
    final state = ref.watch(checkoutNotifierProvider);
    final cart = ref.watch(cartNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Finalizar compra'),
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // ── Resumen del carrito ──────────────────────────
                  _SectionTitle(title: 'Resumen del pedido'),
                  _CartSummary(items: cart.items, total: cart.total),
                  const SizedBox(height: 24),

                  // ── Observaciones ────────────────────────────────
                  _SectionTitle(title: 'Observaciones'),
                  TextFormField(
                    controller: _notesCtrl,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Instrucciones especiales, alergias...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── Método de pago ───────────────────────────────
                  _SectionTitle(title: 'Método de pago'),
                  _PaymentOption(
                    value: PaymentMethod.cash,
                    groupValue: _paymentMethod,
                    label: 'Pago en efectivo',
                    onChanged: (v) =>
                        setState(() => _paymentMethod = v!),
                  ),
                  if (_paymentMethod == PaymentMethod.cash)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                      child: TextFormField(
                        controller: _changeCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Cambio para:',
                          prefixText: '\$ ',
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) {
                          if (_paymentMethod != PaymentMethod.cash) {
                            return null;
                          }
                          if (v == null || v.isEmpty) return null;
                          if (double.tryParse(v) == null) {
                            return 'Ingresa un valor válido';
                          }
                          return null;
                        },
                      ),
                    ),
                  _PaymentOption(
                    value: PaymentMethod.transfer,
                    groupValue: _paymentMethod,
                    label: 'Pago por transferencia',
                    onChanged: (v) =>
                        setState(() => _paymentMethod = v!),
                  ),
                  if (_paymentMethod == PaymentMethod.transfer)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Ver QR
                          if (state.commerce?.urlImageQR.isNotEmpty == true)
                            TextButton.icon(
                              onPressed: () =>
                                  _showQrSheet(state.commerce!.urlImageQR),
                              icon: const Icon(Icons.qr_code),
                              label: const Text('Ver QR para transferencias'),
                            ),
                          const SizedBox(height: 8),
                          // Uploader de comprobante
                          _VoucherPicker(
                            path: _voucherPath,
                            bytes: _voucherBytes,
                            onPick: _pickVoucher,
                            onRemove: _removeVoucher,
                          ),
                          if (_paymentMethod == PaymentMethod.transfer &&
                              _voucherPath == null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4, left: 4),
                              child: Text(
                                'Adjunta el comprobante de transferencia',
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12),
                              ),
                            ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 32),

                  // ── Botón confirmar ──────────────────────────────
                  SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _canConfirm() ? _confirm : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1565C0),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Confirmar pedido  •  \$${cart.total.toStringAsFixed(0)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
    );
  }

  bool _canConfirm() {
    return !(_paymentMethod == PaymentMethod.transfer &&
        _voucherPath == null);
  }

  void _confirm() {
    if (!_formKey.currentState!.validate()) return;
    final cart = ref.read(cartNotifierProvider);
    ref.read(checkoutNotifierProvider.notifier).createOrder({
      'comments' : _notesCtrl.text,
      'paymentMethod' : _paymentMethod,
      'change': _changeCtrl.text,
      'imageBytes': _voucherBytes,
      'cartItems': cart.items,
      'eventId': cart.eventId,
      'commerce': cart.commerce,
      'total': cart.total
    });
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold)),
    );
  }
}

class _PaymentOption extends StatelessWidget {
  final PaymentMethod value;
  final PaymentMethod groupValue;
  final String label;
  final ValueChanged<PaymentMethod?> onChanged;

  const _PaymentOption({
    required this.value,
    required this.groupValue,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<PaymentMethod>(
      value: value,
      groupValue: groupValue,
      title: Text(label),
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
    );
  }
}

class _CartSummary extends StatelessWidget {
  final List<CartItem> items;
  final double total;

  const _CartSummary({required this.items, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          ...items.map(
            (item) => ListTile(
              dense: true,
              title: Text(item.product.name),
              subtitle: Text(
                  '\$${item.product.totalPrice.toStringAsFixed(0)} × ${item.quantity}'),
              trailing: Text(
                '\$${item.subtotal.toStringAsFixed(0)}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  '\$${total.toStringAsFixed(0)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF1565C0)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Uploader de comprobante (sin preview) ────────────────────────────────────

class _VoucherPicker extends StatelessWidget {
  final String? path;
  final Uint8List? bytes;
  final VoidCallback onPick;
  final VoidCallback onRemove;

  const _VoucherPicker({
    required this.path,
    required this.bytes,
    required this.onPick,
    required this.onRemove,
  });

  bool get _hasFile => path != null;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: _hasFile ? Colors.green : Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(8),
        color: _hasFile ? Colors.green.shade50 : Colors.grey.shade50,
      ),
      child: Row(
        children: [
          Icon(
            _hasFile
                ? Icons.check_circle_outline
                : Icons.upload_file_outlined,
            color: _hasFile ? Colors.green : Colors.grey.shade500,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _hasFile
                  ? (kIsWeb ? path! : path!.split('/').last)
                  : 'Adjuntar comprobante',
              style: TextStyle(
                color: _hasFile ? Colors.green.shade700 : Colors.grey.shade600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (_hasFile)
            IconButton(
              icon: const Icon(Icons.close, size: 18),
              color: Colors.red,
              onPressed: onRemove,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            )
          else
            TextButton(
              onPressed: onPick,
              child: const Text('Seleccionar'),
            ),
        ],
      ),
    );
  }
}
