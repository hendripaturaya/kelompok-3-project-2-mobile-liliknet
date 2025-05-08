import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/pelanggan.dart';  // Pastikan model Pelanggan sudah dibuat

class PelangganApiService {
  static const String _baseUrl = 'http://192.168.43.43:8000/api';  // Gunakan IP lokal

  // Fungsi untuk mendaftar pelanggan dengan nama_user dan password
  static Future<bool> registerPelanggan(Pelanggan pelanggan) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');  // Ambil token dari SharedPreferences

      final response = await http.post(
        Uri.parse('$_baseUrl/register'),  // Endpoint untuk registrasi pelanggan
        headers: <String, String>{
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',  // Kirim token jika ada
        },
        body: jsonEncode({
          'nama_pelanggan': pelanggan.namaPelanggan,
          'alamat': pelanggan.alamat,
          'no_telp': pelanggan.noTelepon,
          'paket': pelanggan.paket,
          'username': pelanggan.username,
          'nama_user': pelanggan.namaUser,  // Kirim nama_user
          'password': pelanggan.password,   // Kirim password
        }),  // Kirimkan data pelanggan dalam bentuk JSON
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      return false;
    }
  }
}
