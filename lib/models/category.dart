import 'service_provider.dart';

class Category {
  final String id;
  final String nameEn;
  final String nameAr;
  final List<ServiceProvider> providers;
  Category({required this.id, required this.nameEn, required this.nameAr, required this.providers});
  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['id'],
    nameEn: json['name_en'],
    nameAr: json['name_ar'],
    providers: (json['providers'] as List).map((p) => ServiceProvider.fromJson(p)).toList(),
  );
}