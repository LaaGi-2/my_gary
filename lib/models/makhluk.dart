// ============================================================
// models/makhluk.dart
// ------------------------------------------------------------
// ABSTRACT CLASS:
// `Makhluk` adalah abstract class yang TIDAK memiliki body method.
// Memaksa class turunannya (Player, dll.) untuk meng-implement
// `bernafas()` dan `bergerak()`. Tidak bisa di-instansiasi langsung.
// ============================================================

abstract class MakhlukHidup {
  final String nama;

  MakhlukHidup(this.nama);

  // Abstract methods - tanpa body, wajib di-override.
  void bernafas();
  void bergerak();

  // Method konkret biasa (boleh ada di abstract class).
  String identitas() => 'Makhluk bernama $nama';
}