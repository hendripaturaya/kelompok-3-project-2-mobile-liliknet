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
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView( 
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Paket WiFi Aktif Anda',
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold, 
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 16),
            
            // Card dengan gambar dan bayangan
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blueAccent, Colors.blue.shade400],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
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
              ),
            ),
            const SizedBox(height: 24),

            // Tombol dengan animasi dan gradien
            Center(
              child: GestureDetector(
                onTap: () {
                  // Tindakan untuk menonaktifkan paket
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.orange, Colors.redAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Center(
                    child: const Text(
                      'Nonaktifkan Paket',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
              color: Colors.blueGrey,
              fontSize: 16,
            ),
          ),
          Expanded( 
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
