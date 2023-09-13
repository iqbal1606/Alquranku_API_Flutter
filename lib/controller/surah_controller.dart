import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/surah.dart';

class SurahController {
  Future<List<Surah>> fetchSurahs() async {
    final response =
        await http.get(Uri.parse('https://equran.id/api/v2/surat'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<Surah> surahs = [];
      for (var item in data) {
        surahs.add(Surah.fromJson(item));
      }
      return surahs;
    } else {
      throw Exception('Failed to fetch surahs');
    }
  }
}
