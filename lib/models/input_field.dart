import 'field_option.dart';

class InputField {
  final String id;
  final String labelEn;
  final String labelAr;
  final String type; // 'text' or 'dropdown'
  final List<FieldOption>? options;
  InputField({
    required this.id,
    required this.labelEn,
    required this.labelAr,
    required this.type,
    this.options,
  });
  factory InputField.fromJson(Map<String, dynamic> json) => InputField(
    id: json['id'],
    labelEn: json['label_en'],
    labelAr: json['label_ar'],
    type: json['type'],
    options:
        json['options'] != null
            ? (json['options'] as List)
                .map((o) => FieldOption.fromJson(o))
                .toList()
            : null,
  );
}
