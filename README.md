# LILIKNET Mobile

**LILIKNET Mobile** adalah aplikasi berbasis Flutter yang dirancang untuk memudahkan pelanggan layanan internet **LILIK.NET** dalam mengelola akun, melihat tagihan, dan riwayat pembayaran mereka secara langsung dari perangkat mobile.

## 📱 Fitur Aplikasi

- 🔐 **Login & Registrasi**  
  Proses autentikasi yang sederhana dan aman.

- 💳 **Lihat Tagihan Bulanan**  
  Pelanggan dapat melihat daftar tagihan lengkap dengan tanggal dan status pembayaran.

- 📜 **Riwayat Pembayaran**  
  Menampilkan histori pembayaran pelanggan untuk referensi.

- ⚙️ **Pengaturan Akun**  
  Pelanggan dapat mengatur preferensi dan keamanan akun.

- 🚪 **Logout Aman**  
  Menyediakan opsi keluar dari aplikasi untuk menjaga privasi.

## 🚀 Teknologi yang Digunakan

- [Flutter](https://flutter.dev/)
- [Dart](https://dart.dev/)
- [Shared Preferences](https://pub.dev/packages/shared_preferences)
- [HTTP](https://pub.dev/packages/http)
- [Image Picker](https://pub.dev/packages/image_picker)

## 📂 Struktur Folder (Ringkasan)

lib/
├── core/ # Konstanta, tema, utilitas umum
├── features/ # Halaman utama aplikasi (Login, Register, Tagihan, dll.)
├── routes/ # Konfigurasi rute dan navigasi
├── services/ # Layanan HTTP dan API
└── main.dart # Titik masuk utama aplikasi

## ⚙️ Cara Menjalankan Aplikasi

1. Clone proyek ini:
   ```bash
   git clone https://github.com/username/liliknet_mobile.git
   cd liliknet_mobile
2. flutter pub get
3. flutter run
   
## Jika ingin menghasilkan file .apk:
flutter build apk --release

## 👨‍💻 Pengembang
Aplikasi ini dikembangkan oleh:
Hendri Paturaya
