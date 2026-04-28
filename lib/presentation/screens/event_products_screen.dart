import 'package:delivery_app/domain/entities/category.dart';
import 'package:delivery_app/domain/entities/local_event.dart';
import 'package:delivery_app/domain/entities/product.dart';
import 'package:delivery_app/presentation/notifier/event_products/event_products_notifier.dart';
import 'package:delivery_app/presentation/notifier/event_products/event_products_state.dart';
import 'package:delivery_app/presentation/screens/product_detail_screen.dart';
import 'package:delivery_app/presentation/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventProductsScreen extends ConsumerStatefulWidget {
  final LocalEvent event;
  final String commerceId;

  const EventProductsScreen({
    super.key,
    required this.event,
    required this.commerceId,
  });

  @override
  ConsumerState<EventProductsScreen> createState() =>
      _EventProductsScreenState();
}

class _EventProductsScreenState extends ConsumerState<EventProductsScreen> {
  String? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(eventProductNotifierProvider.notifier).init(widget.commerceId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(eventProductNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.name),
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
      ),
      body:  _buildBody(state)
    ,
    );
  }

  Widget _buildBody(EventProductsState state) {
    if (state.isLoading) return const Center(child: CircularProgressIndicator());

    if (state.errorMessage != null) {
      return Center(child: ErrorIconWidget(errorMessage: state.errorMessage!,));
    }
    return _bodyEventProducts(state);
  }

  Widget _bodyEventProducts(EventProductsState state) {
      return Column(
        children: [
          _CategoryChips(
            categories: state.categories,
            selectedId: _selectedCategoryId,
            onSelected: (id) {
              setState(() => _selectedCategoryId = id);
               ref.read(eventProductNotifierProvider.notifier).updateFilterList(id);
            }) ,
        const Divider(height: 1),
          Expanded(
            child: (state.filteredProducts.isEmpty) ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.inventory_2_outlined,
                            size: 64, color: Colors.grey.shade300),
                        const SizedBox(height: 12),
                        Text('No hay productos en esta categoría',
                            style: TextStyle(color: Colors.grey.shade500)),
                      ],
                    ),
                  ) : ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: state.filteredProducts.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (_, i) => _ProductCard(
                      product: state.filteredProducts[i],
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailScreen(
                            product: state.filteredProducts[i],
                            eventId: widget.event.id,
                            eventName: widget.event.name,
                            commerceId: widget.commerceId,
                          ),
                        ),
                      ),
                    ),
                    )
            ),
        ],
      );
  }
}

class _CategoryChips extends StatelessWidget {
  final List<Category> categories;
  final String? selectedId;
  final ValueChanged<String?> onSelected;

  const _CategoryChips({
    required this.categories,
    required this.selectedId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: const Text('Todos'),
              selected: selectedId == null,
              onSelected: (_) => onSelected(null),
            ),
          ),
          ...categories.map(
            (c) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(c.name),
                selected: selectedId == c.id,
                onSelected: (_) =>
                    onSelected(selectedId == c.id ? null : c.id),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;
  final String? categoryName;
  final VoidCallback? onTap;

  const _ProductCard({required this.product, this.categoryName, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(12)),
              child: product.urlImage != null && product.urlImage!.isNotEmpty
                  ? Image.network(
                      product.urlImage!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _placeholder(),
                    )
                  : _placeholder(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(product.name,
                              style: const TextStyle( fontWeight: 
                     FontWeight.bold, fontSize: 15)),
                        ),
                        if (categoryName != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              categoryName!,
                              style: TextStyle(
                                fontSize: 11,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                              ),
                            ),
                          ),
                      ],
                    ),
                    if (product.description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        product.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 13, color: Colors.grey.shade600),
                      ),
                    ],
                    const SizedBox(height: 8),
                    Text(
                      '\$${product.totalPrice.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() => Container(
        width: 100,
        height: 100,
        color: Colors.grey.shade100,
        child:
            Icon(Icons.image_outlined, color: Colors.grey.shade400, size: 32),
      );
}
