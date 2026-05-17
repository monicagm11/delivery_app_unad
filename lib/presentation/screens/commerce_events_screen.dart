import 'package:delivery_app/domain/entities/local_event.dart';
import 'package:delivery_app/domain/usecases/event/get_all_events_usecase.dart';
import 'package:delivery_app/presentation/notifier/cart/cart_notifier.dart';
import 'package:delivery_app/presentation/notifier/session/session_notifier.dart';
import 'package:delivery_app/presentation/screens/event_products_screen.dart';
import 'package:delivery_app/presentation/screens/events_available_screen.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:delivery_app/presentation/utils/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommerceEventsScreen extends ConsumerStatefulWidget {
  const CommerceEventsScreen({super.key});

  @override
  ConsumerState<CommerceEventsScreen> createState() =>
      _CommerceEventsScreenState();
}

class _CommerceEventsScreenState extends ConsumerState<CommerceEventsScreen> {
  bool _showStarted = false;

  @override
  Widget build(BuildContext context) {
    final commerceId = ref.watch(sessionNotifierProvider).commerceId ?? '';
    final eventsAsync = ref.watch(localEventsByCommerceProvider(commerceId));

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Eventos del comercio',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Chips de filtro
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                EventFilterChip(
                  label: 'Próximamente',
                  selected: !_showStarted,
                  onTap: () => setState(() => _showStarted = false),
                ),
                const SizedBox(width: 8),
                EventFilterChip(
                  label: 'Iniciados',
                  selected: _showStarted,
                  onTap: () => setState(() => _showStarted = true),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Lista
          Expanded(
            child: eventsAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (events) {
                final targetStatus = _showStarted
                    ? Constants.startedStatus
                    : Constants.programmedStatus;

                final filtered = events
                    .where((e) => e.status == targetStatus)
                    .toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.event_busy,
                            size: 64, color: Colors.grey.shade300),
                        const SizedBox(height: 12),
                        Text(
                          'No hay eventos disponibles',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, i) {
                    final event = filtered[i];
                    return EventCard(
                      event: EventItem.fromLocal(event),
                      onTap: () => _navigateToProducts(event),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _navigateToProducts(LocalEvent event) async {
    final newLocation = await context.showTextFieldDialog(
      event.locationClientType == 'numberedChair'
          ? 'Digite el número de su silla'
          : 'Digite el número de su mesa',
    );
    if (newLocation == null) return;
    ref.read(cartNotifierProvider.notifier).updateLocation(newLocation);
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EventProductsScreen(
          event: event,
          commerceId: event.commerce,
        ),
      ),
    );
  }
}
