import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthApiService {
  // Update baseUrl to use the local IP address
  static const String _baseUrl = 'http://192.168.43.43:8000/api';

  // Fungsi untuk registrasi pengguna
  static Future<Map<String, dynamic>> register(String username, String email, String namaUser, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register'),
      body: {
        'username': username,
        'email': email,
        'nama_user': namaUser,
        'password': password,
      },
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Gagal melakukan registrasi');
    }
  }

  // Fungsi untuk login pengguna
  static Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      
      // Simpan token ke SharedPreferences setelah login
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', responseData['token']);

      return responseData;
    } else {
      throw Exception('Gagal melakukan login');
    }
  }
}
