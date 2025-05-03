import 'package:flutter/material.dart';

class TagihanScreen extends StatelessWidget {
  const TagihanScreen({super.key});

  final List<Map<String, dynamic>> _tagihanList = const [
    {
      'tanggal': '01 April 2025',
      'status': 'Belum Dibayar',
      'jumlah': 'Rp 150.000',
    },
    {
      'tanggal': '01 Maret 2025',
      'status': 'Lunas',
      'jumlah': 'Rp 150.000',
    },
    {
      'tanggal': '01 Februari 2025',
      'status': 'Lunas',
      'jumlah': 'Rp 150.000',
    },
  ];

  Color _getStatusColor(String status) {
    if (status == 'Lunas') return Colors.green;
    if (status == 'Belum Dibayar') return Colors.red;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tagihan', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _tagihanList.length,
        itemBuilder: (context, index) {
          final tagihan = _tagihanList[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            child: ListTile(
              leading: Icon(Icons.receipt_long, color: Colors.blue[700]),
              title: Text(tagihan['tanggal']),
              subtitle: Text(
                tagihan['status'],
                style: TextStyle(
                  color: _getStatusColor(tagihan['status']),
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(
                tagihan['jumlah'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // Tambahkan navigasi atau detail jika dibutuhkan
              },
            ),
          );
        },
      ),
    );
  }
}
