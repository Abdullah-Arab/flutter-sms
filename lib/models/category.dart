import 'vendor.dart';

class Category {
  final String id;
  final String nameEn;
  final String nameAr;
  final List<Vendor> vendors;

  Category({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.vendors,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['id'],
    nameEn: json['name_en'],
    nameAr: json['name_ar'],
    vendors: List.from(json['vendors']).map((v) => Vendor.fromJson(v)).toList(),
  );
}
