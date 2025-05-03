import 'package:flutter/material.dart';

class RiwayatTagihanScreen extends StatelessWidget {
  const RiwayatTagihanScreen({super.key});

  final List<Map<String, String>> _riwayat = const [
    {
      'tanggal': '01 Maret 2025',
      'jumlah': 'Rp 150.000',
      'metode': 'Transfer Bank',
      'status': 'Lunas',
    },
    {
      'tanggal': '01 Februari 2025',
      'jumlah': 'Rp 150.000',
      'metode': 'E-Wallet',
      'status': 'Lunas',
    },
    {
      'tanggal': '01 Januari 2025',
      'jumlah': 'Rp 150.000',
      'metode': 'Tunai',
      'status': 'Lunas',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Tagihan', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _riwayat.length,
        itemBuilder: (context, index) {
          final riwayat = _riwayat[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: ListTile(
              leading: const Icon(Icons.history, color: Colors.deepPurple),
              title: Text(riwayat['tanggal']!),
              subtitle: Text('${riwayat['metode']} • ${riwayat['status']}'),
              trailing: Text(
                riwayat['jumlah']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
