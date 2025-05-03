import 'package:flutter/material.dart';
import '../../../models/paket.dart'; // Import model Paket
import '../../../models/pelanggan.dart'; // Import model Pelanggan
import '../../../services/api_service.dart'; // Import API Service

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
  late String harga;

  @override
  void initState() {
    super.initState();
    harga = widget.paket.harga;  // Mengatur harga paket
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Membuat objek pelanggan dari data form
      Pelanggan pelanggan = Pelanggan(
        username: widget.username,
        namaPelanggan: widget.namaPelanggan,
        alamat: _alamatController.text,
        noTelepon: _noTelponController.text,
        paket: widget.paket.nama,
        harga: harga,
      );

      // Kirim data pelanggan ke API
      bool success = await ApiService.registerPelanggan(pelanggan);

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
                subtitle: Text('Harga: Rp $harga'),
              ),
              const SizedBox(height: 16),
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
                  return null;
                },
              ),
              const SizedBox(height: 16),
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
