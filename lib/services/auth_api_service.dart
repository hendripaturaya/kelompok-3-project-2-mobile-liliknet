import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthApiService {
  // Update baseUrl to use the local IP address
  static const String _baseUrl = 'http://192.168.43.43:8000/api';

  // Fungsi untuk registrasi pengguna
  static Future<Map<String, dynamic>> register(String username, String namaUser, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        headers: {
          'Content-Type': 'application/json', // Pastikan menggunakan header JSON
        },
        body: json.encode({
          'username': username,
          'nama_user': namaUser,  // Kirimkan nama_user
          'password': password,  // Kirimkan password
        }),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);

        // Simpan token ke SharedPreferences setelah registrasi
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', responseData['token']);

        return responseData;
      } else {
        // Menangani jika registrasi gagal
        throw Exception('Gagal melakukan registrasi: ${response.body}');
      }
    } catch (e) {
      throw Exception('Gagal melakukan registrasi: $e');
    }
  }

  // Fungsi untuk login pengguna
static Future<Map<String, dynamic>> login(String username, String password) async {
  try {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: {
        'Content-Type': 'application/json', // Pastikan menggunakan header JSON
      },
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    // Periksa status code dan tangani respons dengan baik
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      // Simpan token ke SharedPreferences setelah login
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', responseData['token']);

      return responseData;
    } else {
      // Menangani jika login gagal
      print('Error: ${response.body}'); // Print response body error untuk debugging
      throw Exception('Gagal melakukan login: ${response.body}');
    }
  } catch (e) {
    print('Error exception: $e'); // Tambahkan debugging untuk exception
    throw Exception('Gagal melakukan login: $e');
  }
}
}