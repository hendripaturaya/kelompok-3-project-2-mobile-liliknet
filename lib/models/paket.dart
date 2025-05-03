class Paket {
  final int id;
  final String nama;
  final String kategori;
  final int kecepatan;
  final String harga;

  Paket({required this.id, required this.nama, required this.kategori, required this.kecepatan, required this.harga});

  // Fungsi untuk mengonversi JSON menjadi objek Paket
  factory Paket.fromJson(Map<String, dynamic> json) {
    return Paket(
      id: json['id'],
      nama: json['nama'],
      kategori: json['kategori'],
      kecepatan: json['kecepatan'],
      harga: json['harga'],
    );
  }
}
