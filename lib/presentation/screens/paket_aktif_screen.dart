import 'package:flutter/material.dart';

class PaketAktifScreen extends StatelessWidget {
  const PaketAktifScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data paket WiFi aktif
    final paket = {
      'nama': 'Paket WiFi 100Mbps',
      'tanggalMulai': '1 April 2025',
      'tanggalAkhir': '1 Mei 2025',
      'status': 'Aktif',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text("Paket WiFi Aktif"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView( // Membuat konten bisa digulir jika melebihi batas layar
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Paket WiFi Aktif Anda',
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold, 
                color: Colors.blueAccent
              ),
            ),
            const SizedBox(height: 16),
            
            // Menampilkan informasi paket WiFi aktif dalam Card untuk tampilan lebih menarik
            Card(
              elevation: 8, // Memberikan bayangan pada Card
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PaketInfoWidget(
                      label: 'Nama Paket',
                      value: paket['nama'] ?? 'Tidak tersedia',
                    ),
                    PaketInfoWidget(
                      label: 'Tanggal Mulai',
                      value: paket['tanggalMulai'] ?? 'Tidak tersedia',
                    ),
                    PaketInfoWidget(
                      label: 'Tanggal Akhir',
                      value: paket['tanggalAkhir'] ?? 'Tidak tersedia',
                    ),
                    PaketInfoWidget(
                      label: 'Status',
                      value: paket['status'] ?? 'Tidak tersedia',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Tombol untuk menonaktifkan paket dengan gradien
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Tindakan untuk menonaktifkan paket
                },
                child: const Text(
                  'Nonaktifkan Paket',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaketInfoWidget extends StatelessWidget {
  final String label;
  final String value;

  const PaketInfoWidget({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold, 
              color: Colors.blueGrey
            ),
          ),
          Expanded(  // Agar text tidak overflow
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
