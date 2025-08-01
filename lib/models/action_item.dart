import 'input_field.dart';

class ActionItem {
  final String id;
  final String nameEn;
  final String nameAr;
  final String smsNumber;
  final String template;
  final List<InputField> fields;
  ActionItem({required this.id, required this.nameEn, required this.nameAr, required this.smsNumber, required this.template, required this.fields});
  factory ActionItem.fromJson(Map<String, dynamic> json) => ActionItem(
    id: json['id'],
    nameEn: json['name_en'],
    nameAr: json['name_ar'],
    smsNumber: json['smsNumber'],
    template: json['template'],
    fields: (json['fields'] as List).map((f) => InputField.fromJson(f)).toList(),
  );
}