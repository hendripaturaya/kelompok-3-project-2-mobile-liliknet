class Pelanggan {
  final String username;
  final String namaPelanggan;
  final String alamat;
  final String noTelepon;
  final String paket;
  final String harga;  // Harga paket
  final String namaUser;  // Nama pengguna
  final String password;  // Password pengguna

  Pelanggan({
    required this.username,
    required this.namaPelanggan,
    required this.alamat,
    required this.noTelepon,
    required this.paket,
    required this.harga,
    required this.namaUser,
    required this.password,
  });

  // Fungsi untuk membuat objek Pelanggan dari JSON
  factory Pelanggan.fromJson(Map<String, dynamic> json) {
    return Pelanggan(
      username: json['username'],
      namaPelanggan: json['nama_pelanggan'],
      alamat: json['alamat'],
      noTelepon: json['no_telp'],
      paket: json['paket'],
      harga: json['harga'],
      namaUser: json['nama_user'],
      password: json['password'],
    );
  }

  // Fungsi untuk mengonversi objek Pelanggan menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'nama_pelanggan': namaPelanggan,
      'alamat': alamat,
      'no_telp': noTelepon,
      'paket': paket,
      'harga': harga,
      'nama_user': namaUser,
      'password': password,
    };
  }
}
