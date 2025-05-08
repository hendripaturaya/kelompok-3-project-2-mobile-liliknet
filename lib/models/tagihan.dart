class Tagihan {
  final String id;
  final String tanggal;
  final String total;
  final String status;
  final String paket;  // Add the paket field

  Tagihan({
    required this.id,
    required this.tanggal,
    required this.total,
    required this.status,
    required this.paket,  // Include the paket field in the constructor
  });

  factory Tagihan.fromJson(Map<String, dynamic> json) {
    return Tagihan(
      id: json['id'].toString(),
      tanggal: json['bulan'] + '-' + json['tahun'].toString(),
      total: json['jumlah'].toString(),  // Ensure the total is a string
      status: json['status'],
      paket: json['paket'],  // Set paket field from API response
    );
  }
}
