import 'field_option.dart';

class InputField {
  final String id;
  final String labelEn;
  final String labelAr;
  final String type;
  final List<FieldOption>? options;

  const InputField({
    required this.id,
    required this.labelEn,
    required this.labelAr,
    required this.type,
    this.options,
  });

  factory InputField.fromJson(Map<String, dynamic> json) {
    return InputField(
      id: json['id'] as String,
      labelEn: json['label_en'] as String,
      labelAr: json['label_ar'] as String,
      type: json['type'] as String,
      options:
          json['options'] != null
              ? (json['options'] as List)
                  .map((o) => FieldOption.fromJson(o as Map<String, dynamic>))
                  .toList()
              : null,
    );
  }
}
