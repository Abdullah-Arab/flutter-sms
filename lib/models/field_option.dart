class FieldOption {
  final String labelEn;
  final String labelAr;
  final String value;
  FieldOption({required this.labelEn, required this.labelAr, required this.value});
  factory FieldOption.fromJson(Map<String, dynamic> json) => FieldOption(
    labelEn: json['label_en'],
    labelAr: json['label_ar'],
    value: json['value'],
  );
}