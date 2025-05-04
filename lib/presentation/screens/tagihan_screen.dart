import 'package:flutter/material.dart';
import 'pembayaran_screen.dart';

class TagihanScreen extends StatefulWidget {
  const TagihanScreen({super.key});

  @override
  State<TagihanScreen> createState() => _TagihanScreenState();
}

class _TagihanScreenState extends State<TagihanScreen> {
  List<Map<String, dynamic>> tagihanList = [
    {
      'tanggal': '2025-05-01',
      'status': 'Belum Dibayar',
      'total': 150000,
      'invoiceId': 'INV001',
    },
    {
      'tanggal': '2025-04-01',
      'status': 'Sudah Dibayar',
      'total': 150000,
      'invoiceId': 'INV002',
    },
  ];


  String formatRupiah(int total) {
    return 'Rp ${total.toString().replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.')}';
  }

  // Fungsi untuk menangani pembayaran
  Future<void> _handlePembayaran(Map<String, dynamic> tagihan) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PembayaranScreen(tagihan: tagihan),
      ),
    );

    // Jika pembayaran berhasil, ubah status tagihan
    if (result == true) {
      setState(() {
        final index = tagihanList.indexWhere((t) => t['invoiceId'] == tagihan['invoiceId']);
        if (index != -1) {
          tagihanList[index]['status'] = 'Sudah Dibayar';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tagihan')),
      body: ListView.builder(
        itemCount: tagihanList.length,
        itemBuilder: (context, index) {
          final tagihan = tagihanList[index];
          final isBelumDibayar = tagihan['status'] == 'Belum Dibayar';

          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text('Tanggal: ${tagihan['tanggal']}'),
              subtitle: Text('Total: ${formatRupiah(tagihan['total'])}'),
              trailing: Text(
                tagihan['status'],
                style: TextStyle(
                  color: isBelumDibayar ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: isBelumDibayar
                  ? () => _handlePembayaran(tagihan)
                  : null, // Hanya bisa ditekan jika statusnya "Belum Dibayar"
            ),
          );
        },
      ),
    );
  }
}
