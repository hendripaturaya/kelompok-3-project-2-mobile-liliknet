import 'package:flutter/material.dart';
import '../../../models/paket.dart';
import '../../../services/api_service.dart';
import 'daftar_paket_screen.dart';  // Import layar pendaftaran

class PaketScreen extends StatefulWidget {
  const PaketScreen({Key? key}) : super(key: key);

  @override
  State<PaketScreen> createState() => _PaketScreenState();
}

class _PaketScreenState extends State<PaketScreen> {
  late Future<List<Paket>> futurePaketList;

  @override
  void initState() {
    super.initState();
    futurePaketList = ApiService.fetchPaketList();  // Memanggil API untuk mendapatkan daftar paket
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Paket'),
        backgroundColor: Colors.blue.shade300,  // Warna appbar menggunakan blue[300]
      ),
      body: FutureBuilder<List<Paket>>(
        future: futurePaketList,
        builder: (context, snapshot) {
          // Menunggu data API
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } 
          // Menampilkan error jika ada
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } 
          // Menangani jika tidak ada data atau data kosong
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data paket.'));
          } else {
            final paketList = snapshot.data!;
            return ListView.builder(
              itemCount: paketList.length,
              itemBuilder: (context, index) {
                final paket = paketList[index];
                return Card(
                  elevation: 5,  // Menambahkan bayangan untuk kartu
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),  // Menambahkan sudut melengkung
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        // Gambar Paket (bisa disesuaikan dengan gambar paket jika ada)
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.wifi, color: Colors.white),  // Ikon Wi-Fi, bisa diganti dengan gambar
                        ),
                        const SizedBox(width: 15),  // Spasi antara gambar dan informasi paket
                        // Informasi Paket
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                paket.nama,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Kecepatan: ${paket.kecepatan} Mbps',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              Text(
                                'Kategori: ${paket.kategori}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        // Harga Paket
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Rp ${double.tryParse(paket.harga)?.toStringAsFixed(0) ?? paket.harga}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Tombol Daftar / Checkout
                            ElevatedButton(
                              onPressed: () {
                                // Aksi tombol, pass data ke form pendaftaran
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DaftarPaketScreen(
                                      paket: paket,
                                      username: 'User123',  // Username bisa diambil dari sesi login
                                      namaPelanggan: 'John Doe', // Nama pelanggan bisa diambil dari sesi login
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Daftar'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade300,  // Tombol dengan warna biru terang
                                foregroundColor: Colors.white,  // Warna teks tombol
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
