// lib/screens/pembayaran_screen.dart

import 'package:flutter/material.dart';
import '../../../models/tagihan.dart';  // Pastikan model Tagihan diimport

class PembayaranScreen extends StatelessWidget {
  final Tagihan tagihan;  // Parameter tagihan

  const PembayaranScreen({Key? key, required this.tagihan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pembayaran Tagihan')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tagihan: ${tagihan.tanggal}', style: TextStyle(fontSize: 20)),
            Text('Status: ${tagihan.status}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Menangani pembayaran, kembalikan hasil
                Navigator.pop(context, true);
              },
              child: Text('Bayar'),
            ),
          ],
        ),
      ),
    );
  }
}
