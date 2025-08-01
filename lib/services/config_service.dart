import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';

class ConfigService {
  // Replace with your GitHub raw URL, e.g.: https://raw.githubusercontent.com/username/repo/main/assets/config.json
  static const remoteUrl =
      'https://raw.githubusercontent.com/<user>/<repo>/<branch>/assets/config.json';

  Future<List<Category>> loadConfig() async {
    try {
      final res = await http.get(Uri.parse(remoteUrl));
      if (res.statusCode == 200) return parseConfig(res.body);
    } catch (_) {}
    // Fallback: if you want a local asset, uncomment below and add asset in pubspec
    // final data = await rootBundle.loadString('assets/config.json');
    // return parseConfig(data);
    throw Exception('Failed to load config from GitHub');
  }

  List<Category> parseConfig(String jsonStr) {
    final map = json.decode(jsonStr) as Map<String, dynamic>;
    return List.from(
      map['categories'],
    ).map((c) => Category.fromJson(c)).toList();
  }
}
