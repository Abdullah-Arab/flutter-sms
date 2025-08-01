import 'action_item.dart';

class ServiceProvider {
  final String id;
  final String nameEn;
  final String nameAr;
  final List<ActionItem> actions;
  ServiceProvider({required this.id, required this.nameEn, required this.nameAr, required this.actions});
  factory ServiceProvider.fromJson(Map<String, dynamic> json) => ServiceProvider(
    id: json['id'],
    nameEn: json['name_en'],
    nameAr: json['name_ar'],
    actions: (json['actions'] as List).map((a) => ActionItem.fromJson(a)).toList(),
  );
}