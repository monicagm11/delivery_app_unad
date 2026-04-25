import 'package:delivery_app/domain/entities/city_data.dart';
import 'package:delivery_app/domain/entities/department.dart';
import 'package:delivery_app/domain/usecases/get_departments_usecase.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:delivery_app/presentation/widgets/city_selector_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';



class CitySelectorTemplate extends ConsumerStatefulWidget {
  final VoidCallback onSaved;

  const CitySelectorTemplate({super.key, required this.onSaved});

  @override
  ConsumerState<CitySelectorTemplate> createState() =>
      _CitySelectorTemplateState();
}

class _CitySelectorTemplateState extends ConsumerState<CitySelectorTemplate> {
  CityData? _selection;
  bool _loading = false;

  bool get _isValid =>
      _selection != null &&
      _selection!.department.isNotEmpty &&
      _selection!.city.isNotEmpty;

  Future<void> _save() async {
    if (!_isValid) return;
    setState(() => _loading = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(Constants.keyDepartment, _selection!.department);
      await prefs.setString(Constants.keyCity, _selection!.city);
      widget.onSaved();
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final departmentsAsync = ref.watch(_departmentsProvider);

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: departmentsAsync.when(
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => Text('Error cargando departamentos: $e'),
              data: (departments) => _buildContent(departments),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(List<Department> departments) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Selecciona tu ciudad',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Elige el departamento y la ciudad donde deseas recibir tus pedidos.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        CitySelectorFormField(
          departments: departments,
          onSaved: (value) => _selection = value,
          onChanged: (value) => setState(() => _selection = value),
          validator: (value) {
            if (value == null ||
                value.department.isEmpty ||
                value.city.isEmpty) {
              return 'Selecciona un departamento y una ciudad';
            }
            return null;
          },
          initialValue: _selection,
        ),
        const SizedBox(height: 32),
        SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: _isValid && !_loading ? _save : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1565C0),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: _loading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                : const Text('Confirmar',
                    style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}

// Provider que carga los departamentos una sola vez
final _departmentsProvider = FutureProvider<List<Department>>((ref) {
  return ref.read(getDepartmentsUseCaseProvider)();
});
