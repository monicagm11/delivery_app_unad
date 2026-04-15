class Rol {
  final String name;
  final String id;
  final String code;
  final bool enabled;
  final Map<String, FunctionConfig> functionConfig;
  final List<String> rolEnableToCreate;

  Rol(
      {required this.name,
      required this.id,
      required this.functionConfig,
      required this.code,
      required this.enabled,
      required this.rolEnableToCreate});

  factory Rol.fromMap(Map<String, dynamic> map) => Rol(
        id: map['id'] as String? ?? '',
        name: map['name'] as String? ?? '',
        code: map['code'] as String? ?? '',
        enabled: map['enabled'] as bool? ?? false,
        functionConfig: (map['functionConfig'] as Map<String, dynamic>? ?? {})
            .map((key, value) => MapEntry(
                  key,
                  FunctionConfig.fromMap(value as Map<String, dynamic>),
                )),
        rolEnableToCreate:
            List<String>.from(map['rolEnableToCreate'] as List? ?? []),
      );
}

class FunctionConfig {
  final bool enabled;
  final bool readData;
  final bool createData;
  final bool updateData;

  FunctionConfig(
      {required this.readData,
      required this.createData,
      required this.updateData,
      required this.enabled});

  factory FunctionConfig.fromMap(Map<String, dynamic> map) => FunctionConfig(
        enabled: map['enabled'] as bool? ?? false,
        readData: map['readData'] as bool? ?? false,
        createData: map['createData'] as bool? ?? false,
        updateData: map['updateData'] as bool? ?? false,
      );
}
