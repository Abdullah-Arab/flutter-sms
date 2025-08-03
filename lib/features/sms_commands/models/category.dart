import 'service_provider.dart';

class Category {
  final String id;
  final String nameEn;
  final String nameAr;
  final List<ServiceProvider> providers;

  const Category({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.providers,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      nameEn: json['name_en'] as String,
      nameAr: json['name_ar'] as String,
      providers:
          (json['providers'] as List)
              .map((p) => ServiceProvider.fromJson(p as Map<String, dynamic>))
              .toList(),
    );
  }
}
