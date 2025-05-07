// lib/services/tagihan_api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tagihan.dart';

class TagihanApiService {
  static const String _baseUrl = 'http://192.168.43.43:8000/api';  // Gunakan IP lokal

  // Fungsi untuk mengambil list tagihan
  static Future<List<Tagihan>> fetchTagihanList() async {
    final response = await http.get(Uri.parse('$_baseUrl/tagihan'));

    // Periksa status code dari respons
    if (response.statusCode == 200) {
      try {
        final data = json.decode(response.body);  // Parsing respons JSON

        // Pastikan respons mengandung 'success' dan nilai successnya benar
        if (data['success'] == true) {
          final List tagihanData = data['tagihan'];  // Ambil data tagihan
          
          // Mengonversi setiap item tagihan menjadi objek Tagihan
          return tagihanData.map((item) => Tagihan.fromJson(item)).toList();
        } else {
          throw Exception('Gagal memuat tagihan');
        }
      } catch (e) {
        throw Exception('Error parsing response: $e');
      }
    } else {
      throw Exception('Gagal memuat tagihan, status code: ${response.statusCode}');
    }
  }
}
