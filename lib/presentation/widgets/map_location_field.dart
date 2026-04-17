import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapLocationData {
  final double latitude;
  final double longitude;
  final double radious;

  const MapLocationData({
    required this.latitude,
    required this.longitude,
    required this.radious,
  });
}

class MapLocationFormField extends FormField<MapLocationData> {
  MapLocationFormField({
    super.key,
    super.onSaved,
    super.validator,
    super.initialValue,
    bool isEnabled = true,
  }) : super(
          builder: (state) => _MapLocationField(
            state: state,
            isEnabled: isEnabled,
          ),
        );
}

class _MapLocationField extends StatefulWidget {
  final FormFieldState<MapLocationData> state;
  final bool isEnabled;

  const _MapLocationField({required this.state, required this.isEnabled});

  @override
  State<_MapLocationField> createState() => _MapLocationFieldState();
}

class _MapLocationFieldState extends State<_MapLocationField> {
  late final TextEditingController _coordsController;
  //late final TextEditingController _radiusController;
  late String _radiusTextValue;

  @override
  void initState() {
    super.initState();
    final v = widget.state.value;
    _coordsController = TextEditingController(
      text: v != null ? '${v.latitude.toStringAsFixed(6)}, ${v.longitude.toStringAsFixed(6)}' : '',
    );
    _radiusTextValue = v != null ? 'Radio (m): ${v.radious.toStringAsFixed(0)}' : '';
  }

  @override
  void dispose() {
    _coordsController.dispose();
    super.dispose();
  }

  Future<void> _openMapDialog() async {
    final current = widget.state.value;
    final result = await showDialog<MapLocationData>(
      context: context,
      builder: (_) => _MapDialog(initial: current),
    );
    if (result == null) return;

    _coordsController.text =
        '${result.latitude.toStringAsFixed(6)}, ${result.longitude.toStringAsFixed(6)}';
    _radiusTextValue = 'Radio (m): ${result.radious.toStringAsFixed(0)}';
    widget.state.didChange(result);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _coordsController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Coordenadas (lat, lng)',
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 130,
                child: Text(
                  textAlign: TextAlign.start,
                  _radiusTextValue
                ),
              ),
            ],
          ),
        ),
        ElevatedButton.icon(
              onPressed: widget.isEnabled ? _openMapDialog : null,
              icon: const Icon(Icons.map_outlined),
              label: const Text('Mapa'),
            ),
        if (widget.state.hasError)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 12),
            child: Text(
              widget.state.errorText!,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.error, fontSize: 12),
            ),
          ),
      ],
    );
  }
}

// ── Dialog con el mapa ───────────────────────────────────────────────────────

class _MapDialog extends StatefulWidget {
  final MapLocationData? initial;
  const _MapDialog({this.initial});

  @override
  State<_MapDialog> createState() => _MapDialogState();
}

class _MapDialogState extends State<_MapDialog> {
  static const _defaultCenter = LatLng(4.7110, -74.0721); // Bogotá
  static const _defaultRadius = 500.0;

  late LatLng _marker;
  late double _radius;
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _marker = widget.initial != null
        ? LatLng(widget.initial!.latitude, widget.initial!.longitude)
        : _defaultCenter;
    _radius = widget.initial?.radious ?? _defaultRadius;
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: SizedBox(
        width: 700,
        height: 560,
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Seleccionar ubicación',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Mapa
            Expanded(
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _marker,
                  initialZoom: 13,
                  onTap: (_, point) => setState(() => _marker = point),
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.delivery.app',
                  ),
                  CircleLayer(circles: [
                    CircleMarker(
                      point: _marker,
                      radius: _radius,
                      useRadiusInMeter: true,
                      color: Colors.blue.withValues(alpha: 0.2),
                      borderColor: Colors.blue,
                      borderStrokeWidth: 2,
                    ),
                  ]),
                  MarkerLayer(markers: [
                    Marker(
                      point: _marker,
                      child: const Icon(Icons.location_pin,
                          color: Colors.red, size: 36),
                    ),
                  ]),
                ],
              ),
            ),

            // Control de radio
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Row(
                children: [
                  const Icon(Icons.radar, size: 18),
                  const SizedBox(width: 8),
                  Text('Radio: ${_radius.toStringAsFixed(0)} m',
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                  Expanded(
                    child: Slider(
                      value: _radius,
                      min: 10,
                      max: 1000,
                      divisions: 99,
                      onChanged: (v) => setState(() => _radius = v),
                    ),
                  ),
                ],
              ),
            ),

            // Coordenadas y botón confirmar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Lat: ${_marker.latitude.toStringAsFixed(6)}  '
                      'Lng: ${_marker.longitude.toStringAsFixed(6)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(
                      context,
                      MapLocationData(
                        latitude: _marker.latitude,
                        longitude: _marker.longitude,
                        radious: _radius,
                      ),
                    ),
                    child: const Text('Confirmar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
