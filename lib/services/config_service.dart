import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';

class ConfigService {
  static const remoteUrl =
      'https://raw.githubusercontent.com/MElkmeshi/flutter-sms/main/assets/config.json';

  Future<List<Category>> loadConfig() async {
    try {
      final res = await http.get(Uri.parse(remoteUrl));
      if (res.statusCode == 200) return parseConfig(res.body);
    } catch (_) {}
    throw Exception('Failed to load config from GitHub');
  }

  List<Category> parseConfig(String jsonStr) {
    final map = json.decode(jsonStr) as Map<String, dynamic>;
    return List.from(
      map['categories'],
    ).map((c) => Category.fromJson(c)).toList();
  }
}
