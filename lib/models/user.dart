class User {
  final String username;
  final String email;
  final String level;

  User({
    required this.username,
    required this.email,
    required this.level,
  });

  // Fungsi untuk membuat objek User dari JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      level: json['level'],
    );
  }

  // Fungsi untuk mengubah objek User menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'level': level,
    };
  }
}
