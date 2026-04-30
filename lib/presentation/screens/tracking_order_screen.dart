import 'package:delivery_app/presentation/notifier/tracking_order/tracking_order_notifier.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:delivery_app/presentation/utils/context_extensions.dart';
import 'package:delivery_app/presentation/widgets/tracking_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrackingOrderScreen extends ConsumerStatefulWidget {
  const TrackingOrderScreen({super.key, required this.orderId, required this.isFinalUser});
  final String orderId;
  final bool isFinalUser;
  @override
  ConsumerState<TrackingOrderScreen> createState() => _TrackingOrderScreenState();
}

class _TrackingOrderScreenState extends ConsumerState<TrackingOrderScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        ref.read(trackingOrderRealtimeProvider.notifier).init(widget.orderId));
  }
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(trackingOrderRealtimeProvider);
    final order = state.item;
    final currentStatus = order?.stageList.last;
    return Scaffold(
      appBar: AppBar(
        title: Text('Rastreo pedido'),
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,),
        body: Column(
          children: [
            Expanded(
              child: TrackingOrderWidget(
                stages: order?.stageList ?? [],
                items: order?.checkoutItems ?? [],
                status: currentStatus?.name ?? '',
              ),
            ),
            ElevatedButton(
            onPressed: state.isLoading ? null : () async {
              bool confirmation = await context.showConfirmationDialog('¿Estás seguro que deseas realizar esta acción?') ?? false;
              if (confirmation) ref.read(trackingOrderRealtimeProvider.notifier).updateStatus(widget.isFinalUser ? Constants.canceledStatus : Constants.orderDoneStatus);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  widget.isFinalUser ? Colors.red : const Color(0xFF1565C0),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: state.isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                : Text(widget.isFinalUser ? 'CANCELAR' : 'ENTREGAR',
                    style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ],
        ),
        );
  }

}