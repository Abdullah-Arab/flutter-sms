class Command {
  final String id;
  final String nameEn;
  final String nameAr;
  final String template;

  Command({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.template,
  });

  factory Command.fromJson(Map<String, dynamic> json) => Command(
    id: json['id'],
    nameEn: json['name_en'],
    nameAr: json['name_ar'],
    template: json['template'],
  );
}
