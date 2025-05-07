import 'package:flutter/material.dart';
import 'pembayaran_screen.dart';
import '../../../models/tagihan.dart'; // Import model Tagihan
import '../../services/tagihan_api_service.dart'; // Menggunakan TagihanApiService

class TagihanScreen extends StatefulWidget {
  const TagihanScreen({super.key});

  @override
  State<TagihanScreen> createState() => _TagihanScreenState();
}

class _TagihanScreenState extends State<TagihanScreen> {
  // Variabel untuk menyimpan data tagihan yang diambil dari API
  List<Tagihan> tagihanList = [];

  @override
  void initState() {
    super.initState();
    _loadTagihan();  // Ambil data tagihan saat pertama kali membuka layar
  }

  // Fungsi untuk mengambil data tagihan dari API
  Future<void> _loadTagihan() async {
    try {
      final List<Tagihan> tagihanData = await TagihanApiService.fetchTagihanList();
      setState(() {
        tagihanList = tagihanData;
      });
    } catch (e) {
      // Menangani jika terjadi error saat mengambil data
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat tagihan: $e')),
      );
    }
  }

  // Fungsi untuk memformat nilai uang dalam format Rupiah
  String formatRupiah(String total) {
    final double totalDouble = double.tryParse(total) ?? 0.0;  // Konversi string ke double
    return 'Rp ${totalDouble.toString().replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.')}';
  }

  // Fungsi untuk menangani pembayaran
  Future<void> _handlePembayaran(Tagihan tagihan) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PembayaranScreen(tagihan: tagihan),
      ),
    );

    // Jika pembayaran berhasil, ubah status tagihan
    if (result == true) {
      setState(() {
        final index = tagihanList.indexWhere((t) => t.id == tagihan.id);
        if (index != -1) {
          // Perbarui status tagihan menjadi 'Sudah Dibayar'
          tagihanList[index] = Tagihan(
            id: tagihan.id,
            tanggal: tagihan.tanggal,
            total: tagihan.total,
            status: 'Sudah Dibayar',
            paket: tagihan.paket,  // Ensure paket remains unchanged
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tagihan'),
        backgroundColor: Colors.blue, // AppBar color for consistency
      ),
      body: tagihanList.isEmpty
          ? Center(child: CircularProgressIndicator())  // Menampilkan loading jika data belum ada
          : ListView.builder(
              itemCount: tagihanList.length,
              itemBuilder: (context, index) {
                final tagihan = tagihanList[index];
                final isBelumDibayar = tagihan.status == 'Belum Dibayar';

                return Card(
                  margin: const EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      'Tanggal: ${tagihan.tanggal}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Paket: ${tagihan.paket}'),
                        Text('Total: ${formatRupiah(tagihan.total)}'),
                      ],
                    ),
                    trailing: Text(
                      tagihan.status,
                      style: TextStyle(
                        color: isBelumDibayar ? Colors.red : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Show payment button only if the tagihan status is "Belum Dibayar"
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
