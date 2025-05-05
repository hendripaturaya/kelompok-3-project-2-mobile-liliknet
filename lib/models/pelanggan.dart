class Pelanggan {
  String username;
  String namaPelanggan;
  String alamat;
  String noTelepon;
  String paket;
  String harga;

  Pelanggan({
    required this.username,
    required this.namaPelanggan,
    required this.alamat,
    required this.noTelepon,
    required this.paket,
    required this.harga,
  });

  // Method untuk mengonversi objek Pelanggan menjadi Map yang dapat dikirim dalam request body
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
