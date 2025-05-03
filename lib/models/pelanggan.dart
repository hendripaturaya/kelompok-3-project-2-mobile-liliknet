class Pelanggan {
  final String username;
  final String namaPelanggan;
  final String alamat;
  final String noTelepon;
  final String paket;
  final String harga;

  Pelanggan({
    required this.username,
    required this.namaPelanggan,
    required this.alamat,
    required this.noTelepon,
    required this.paket,
    required this.harga,
  });

  // Konversi objek Pelanggan menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'nama_pelanggan': namaPelanggan,
      'alamat': alamat,
      'no_telp': noTelepon,
      'paket': paket,
      'harga': harga,
    };
  }
}
