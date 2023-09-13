import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:alquran/model/ayat.dart'; // Pastikan mengganti path sesuai dengan struktur folder Anda

class AyatController {
  Future<List<Ayat>> fetchAyatList(int surahNumber) async {
    try {
      final response = await http.get(
        Uri.parse('https://equran.id/api/v2/surat/$surahNumber'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        // print(responseData['data']['ayat']);
        final data = DetailAyat.fromJson(responseData['data']);
        // print(data.data.ayat);
        return data.ayat ??
            []; // Mengembalikan list ayat atau list kosong jika tidak ada ayat
      } else {
        throw Exception('Gagal mengambil data ayat');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Gagal mengambil data ayat');
    }
  }
}
// Future<DetailAyat> fetchDetailAyat(int surahNumber) async {
//     try {
//       final response = await http.get(
//         Uri.parse('https://equran.id/api/v2/surat/$surahNumber'),
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = json.decode(response.body);
//         print(responseData['data']['ayat']);
//         final detailAyat = DetailAyat.fromJson(responseData['data']);
//         return detailAyat;
//       } else {
//         throw Exception('Gagal mengambil data detail ayat');
//       }
//     } catch (e) {
//       print('Error: $e');
//       throw Exception('Gagal mengambil data detail ayat');
//     }
//   }
