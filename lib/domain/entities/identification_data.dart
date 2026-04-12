class IdentificationData {
  final String code;
  final String number;

  IdentificationData({
    required this.code,
    required this.number,
  });

  String get full => "$code $number";
}