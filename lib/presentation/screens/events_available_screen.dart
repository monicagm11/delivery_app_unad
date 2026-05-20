import 'package:delivery_app/domain/entities/event_item.dart';
import 'package:delivery_app/domain/entities/local_event.dart';
import 'package:delivery_app/domain/usecases/event/get_all_events_usecase.dart';
import 'package:delivery_app/presentation/notifier/cart/cart_notifier.dart';
import 'package:delivery_app/presentation/notifier/events_available/events_available_notifier.dart';
import 'package:delivery_app/presentation/screens/city_selector_template.dart';
import 'package:delivery_app/presentation/screens/event_products_screen.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:delivery_app/presentation/utils/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Mapa de id -> LocalEvent para navegación
final _localEventsMapProvider =
    FutureProvider<Map<String, LocalEvent>>((ref) async {
  final events = await ref.read(getAllLocalEventsUseCaseProvider).call();
  return {for (final e in events) e.id: e};
});

// ── Screen ───────────────────────────────────────────────────────────────────

class EventsAvailableScreen extends ConsumerStatefulWidget {
  /// Si se pasa, muestra solo eventos locales con este idGlobalEvent
  final String? globalEventId;
  final String? globalEventName;

  const EventsAvailableScreen({
    super.key,
    this.globalEventId,
    this.globalEventName,
  });

  @override
  ConsumerState<EventsAvailableScreen> createState() =>
      _EventsAvailableScreenState();
}

class _EventsAvailableScreenState
    extends ConsumerState<EventsAvailableScreen> {

  @override
  void initState() {
    super.initState();
    ref.read(eventsAvailableNotifierProvider.notifier).init(widget.globalEventId);
  }

  Future<void> _openCitySelector() async {
    await showDialog(
      context: context,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.all(24),
        child: SizedBox(
          width: 480,
          child: CitySelectorTemplate(
            onSaved: () {
              Navigator.pop(context);
              ref.read(eventsAvailableNotifierProvider.notifier).loadAll();
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSubScreen = widget.globalEventId != null;
    final state = ref.watch(eventsAvailableNotifierProvider);
    final filtered = state.filteredEventItems;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título
          Row(
            children: [
              if (isSubScreen)
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              if (isSubScreen) const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.globalEventName ?? 'Eventos disponibles',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Subtítulo ciudad (solo en pantalla principal)
          if (!isSubScreen)
            Row(
                children: [
                  Expanded(
                    child: Text(
                      state.city.isNotEmpty
                          ? '${state.city}, ${state.department}'
                          : 'Sin ciudad seleccionada',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                    ),
                  ),
                  TextButton(
                    onPressed: _openCitySelector,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text('Cambiar'),
                  ),
                ],
              ),
          const SizedBox(height: 16),

          // Chips de filtro
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 8,
              children: [
                EventFilterChip(
                  label: 'Iniciados',
                  selected: state.currentStateSelected == Constants.startedStatus,
                  onTap: () {
                    ref.read(eventsAvailableNotifierProvider.notifier).updateStateSelected(Constants.startedStatus);
                  },
                ),
                EventFilterChip(
                  label: 'Próximamente',
                  selected: state.currentStateSelected == Constants.programmedStatus,
                  onTap: () {
                    ref.read(eventsAvailableNotifierProvider.notifier).updateStateSelected(Constants.programmedStatus);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Lista
          Expanded(
            child: (state.filteredEventItems.isEmpty) ?
                  Center(
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
                  ) :
              
                ListView.separated(
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, i) {
                    final event = filtered[i];
                    return EventCard(
                      event: event,
                      onTap: event.isGlobal && !isSubScreen
                          ? () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EventsAvailableScreen(
                                    globalEventId: event.id,
                                    globalEventName: event.name,
                                  ),
                                ),
                              )
                          : !event.isGlobal && event.commerceId != null
                              ? () async {
                                  final localEvent = ref
                                      .read(_localEventsMapProvider)
                                      .valueOrNull?[event.id];
                                  if (localEvent == null) return;
                                  final newLocation =
                                      await context.showTextFieldDialog(
                                          localEvent.locationClientType ==
                                                  'numberedChair'
                                              ? 'Digite el número de su silla'
                                              : 'Digite el número de su mesa');
                                  if (newLocation == null) return;
                                  ref
                                      .read(cartNotifierProvider.notifier)
                                      .updateLocation(newLocation);
                                  if (!context.mounted) return;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => EventProductsScreen(
                                        event: localEvent,
                                        commerceId: event.commerceId!,
                                      ),
                                    ),
                                  );
                                }
                              : null,
                    );
                  },
                )

          ),
        ],
      ),
    );
  }
}

// ── Componentes ──────────────────────────────────────────────────────────────

class EventFilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const EventFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.grey.shade700,
            fontWeight:
                selected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final EventItem event;
  final VoidCallback? onTap;

  const EventCard({super.key, required this.event, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: event.isGlobal
                      ? Colors.blue.shade50
                      : Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  event.isGlobal
                      ? Icons.public
                      : Icons.place_outlined,
                  color:
                      event.isGlobal ? Colors.blue : Colors.orange,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            event.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        EventStatusBadge(status: event.status),
                        if (onTap != null)
                          const Icon(Icons.chevron_right,
                              color: Colors.grey),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      event.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.grey.shade600, fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.calendar_today_outlined,
                                size: 13, color: Colors.grey.shade500),
                            const SizedBox(width: 4),
                            Text(
                              event.status == Constants.startedStatus
                                  ? 'Inicio: ${event.startDate}'
                                  : 'Programado: ${event.scheduleDate}',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.location_on_outlined,
                                size: 13, color: Colors.grey.shade500),
                            const SizedBox(width: 4),
                            Text(
                              event.city,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventStatusBadge extends StatelessWidget {
  final String status;
  const EventStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final isStarted = status == Constants.startedStatus;
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isStarted ? Colors.green.shade50 : Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isStarted
              ? Colors.green.shade200
              : Colors.blue.shade200,
        ),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: isStarted
              ? Colors.green.shade700
              : Colors.blue.shade700,
        ),
      ),
    );
  }
}
