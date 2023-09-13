import '../model/detail_surah.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailSurahController {
  Future<List<DetailSurah>> fetchSurahDetail(int surahNumber) async {
    final response =
        await http.get(Uri.parse('https://equran.id/api/v2/$surahNumber'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      List<DetailSurah> deDetailSurahs = [];
      for (var item in data) {
        deDetailSurahs.add(DetailSurah.fromJson(item));
      }
      return deDetailSurahs;
    } else {
      throw Exception('Failed to fetch surahs');
    }
  }
}
