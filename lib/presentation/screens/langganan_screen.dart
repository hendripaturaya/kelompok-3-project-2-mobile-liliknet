import 'package:flutter/material.dart';

class LanggananScreen extends StatelessWidget {
  const LanggananScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Langganan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Paket Langganan Anda',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildSubscriptionCard(
              title: 'Paket Murah',
              description: 'Kecepatan hingga 20Mbps',
              price: 'Rp 150.000 / bulan',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard({
    required String title,
    required String description,
    required String price,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            const SizedBox(height: 4),
            Text(price, style: const TextStyle(color: Colors.blue)),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // aksi ketika kartu diklik, misalnya tampilkan detail
        },
      ),
    );
  }
}
