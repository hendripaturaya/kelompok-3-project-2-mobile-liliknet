import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/paket.dart';

class PaketApiService {
  // Update baseUrl to use the local IP address
  static const String _baseUrl = 'http://192.168.43.43:8000/api';  // Gunakan IP lokal

  // Fungsi untuk mengambil list paket
  static Future<List<Paket>> fetchPaketList() async {
    final response = await http.get(Uri.parse('$_baseUrl/paket'));

    // Periksa status code dari respons
    if (response.statusCode == 200) {
      try {
        final data = json.decode(response.body);  // Parsing respons JSON

        // Pastikan respons mengandung 'success' dan nilai successnya benar
        if (data['success'] == true) {
          final List paketData = data['paket'];  // Ambil data paket
          
          // Mengonversi setiap item paket menjadi objek Paket
          return paketData.map((item) => Paket.fromJson(item)).toList();
        } else {
          throw Exception('Gagal memuat paket');
        }
      } catch (e) {
        throw Exception('Error parsing response: $e');
      }
    } else {
      throw Exception('Gagal memuat paket, status code: ${response.statusCode}');
    }
  }
}
