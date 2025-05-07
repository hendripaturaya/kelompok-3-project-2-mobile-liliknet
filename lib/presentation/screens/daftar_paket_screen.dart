import 'package:flutter/material.dart';
import '../../../models/paket.dart'; // Import model Paket
import '../../../models/pelanggan.dart'; // Import model Pelanggan
import '../../services/pelanggan_api_service.dart'; // Menggunakan PelangganApiService

class DaftarPaketScreen extends StatefulWidget {
  final Paket paket; // Paket yang dipilih oleh user
  final String username;
  final String namaPelanggan;

  const DaftarPaketScreen({
    Key? key,
    required this.paket,
    required this.username,
    required this.namaPelanggan,
  }) : super(key: key);

  @override
  _DaftarPaketScreenState createState() => _DaftarPaketScreenState();
}

class _DaftarPaketScreenState extends State<DaftarPaketScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _noTelponController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();  // Controller untuk password

  // Fungsi untuk mengirimkan data ke server
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Membuat objek pelanggan dari data form
      Pelanggan pelanggan = Pelanggan(
        username: widget.username,
        namaPelanggan: widget.namaPelanggan,
        alamat: _alamatController.text,
        noTelepon: _noTelponController.text,
        paket: widget.paket.nama,  // Mengambil nama paket
        harga: widget.paket.harga,  // Mengambil harga paket
        namaUser: widget.namaPelanggan,  // Menggunakan nama pelanggan sebagai nama_user
        password: _passwordController.text,  // Mengambil password yang dimasukkan
      );

      // Kirim data pelanggan ke API menggunakan PelangganApiService
      bool success = await PelangganApiService.registerPelanggan(pelanggan);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pendaftaran berhasil untuk paket ${widget.paket.nama}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pendaftaran gagal. Silakan coba lagi.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Pendaftaran Paket'),
        backgroundColor: Colors.blue.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ListTile(
                title: Text('Paket: ${widget.paket.nama}'),
                subtitle: Text('Harga: Rp ${widget.paket.harga}'),
              ),
              const SizedBox(height: 16),

              // Field untuk Alamat
              TextFormField(
                controller: _alamatController,
                decoration: const InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Field untuk Nomor Telepon
              TextFormField(
                controller: _noTelponController,
                decoration: const InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor telepon tidak boleh kosong';
                  }
                  // Validasi nomor telepon (misalnya harus 10 digit)
                  if (value.length != 12) {
                    return 'Nomor telepon harus 10 digit';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Field untuk Password
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Tombol Daftar
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Daftar Paket'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade300,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
