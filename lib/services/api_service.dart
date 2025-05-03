import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/paket.dart';
import '../models/user.dart';  // Pastikan sudah membuat model User
import '../models/pelanggan.dart';  // Pastikan sudah membuat model Pelanggan

class ApiService {
  static const String _baseUrl = 'http://localhost:8000/api';  // Atau 127.0.0.1 // Gunakan IP lokal atau 10.0.2.2 untuk emulator Android

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

  // Fungsi untuk mendapatkan profil pengguna
  static Future<User> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('Tidak ada token ditemukan');
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/user'),
      headers: {
        'Authorization': 'Bearer $token',  // Gunakan token untuk autentikasi
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return User.fromJson(data);  // Mengonversi JSON menjadi objek User
    } else {
      throw Exception('Gagal mengambil profil pengguna');
    }
  }

  // Fungsi untuk mendaftar paket pelanggan
  static Future<bool> registerPelanggan(Pelanggan pelanggan) async {
    // Mengonversi objek Pelanggan menjadi Map
    final Map<String, dynamic> pelangganData = pelanggan.toJson();

    try {
      // Cek apakah token ada di SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await http.post(
        Uri.parse('$_baseUrl/daftar-paket'), // URL API untuk mendaftar paket
        headers: <String, String>{
          'Content-Type': 'application/json', // Menggunakan format JSON
          if (token != null) 'Authorization': 'Bearer $token', // Kirimkan token jika ada
        },
        body: jsonEncode(pelangganData), // Mengonversi data menjadi JSON
      );

      // Memeriksa respons dari server
      if (response.statusCode == 201) {
        // Pendaftaran berhasil
        return true;
      } else {
        // Pendaftaran gagal
        print('Error: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      return false;
    }
  }
}
