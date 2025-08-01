import 'command.dart';

class Vendor {
  final String id;
  final String nameEn;
  final String nameAr;
  final String shortcode;
  final List<Command> commands;

  Vendor({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.shortcode,
    required this.commands,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
    id: json['id'],
    nameEn: json['name_en'],
    nameAr: json['name_ar'],
    shortcode: json['shortcode'],
    commands:
        List.from(json['commands']).map((c) => Command.fromJson(c)).toList(),
  );
}
