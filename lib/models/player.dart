// ============================================================
// models/player.dart
// ------------------------------------------------------------
// Class Player meng-EXTENDS Makhluk (abstract).
// - Default constructor & named constructor (Player.hero()).
// - ENCAPSULATION: properti privat dengan underscore (_),
//   dilindungi getter/setter dengan VALIDASI.
// - InventoryBST disimpan sebagai field, tapi class BST sendiri
//   ada di structures/inventory_bst.dart (dependency injection
//   dari GameEngine).
// ============================================================

import 'makhluk.dart';

class Player extends MakhlukHidup {
  // Properti privat - tidak bisa diakses langsung dari luar file.
  int _health;
  int _karma;
  int _uang; //

  // Default constructor
  Player(String nama, {int health = 100, int karma = 0, int uang = 500})
      : _health = health,
        _karma = karma,
        _uang = uang,
        super(nama);

  // Named constructor
  Player.hero()
      : _health = 100,
        _karma = 100,
        _uang = 500,
        super('Sahla');

  // ---------------- GETTERS ----------------
  int get health => _health;
  int get karma => _karma;
  int get uang => _uang;

  // ---------------- SETTERS dengan VALIDASI ----------------
  set health(int value) {
    // Validasi: health tidak boleh negatif atau > 100.
    if (value < 0) {
      _health = 0;
    } else if (value > 100) {
      _health = 100;
    } else {
      _health = value;
    }
  }

  set karma(int value) {
    // Karma dibatasi -100..100 (semakin tinggi = semakin idealis).
    if (value < -100) {
      _karma = -100;
    } else if (value > 100) {
      _karma = 100;
    } else {
      _karma = value;
    }
  }

  set uang(int value) {
    // Uang tidak boleh negatif (tidak bisa minus).
    _uang = value < 0 ? 0 : value;
  }

  // ---------------- Implementasi abstract (POLYMORPHISM) ----------------
  @override
  void bernafas() {
    // Sederhana: bernafas memulihkan 1 health.
    health = _health + 1;
  }

  @override
  void bergerak() {
    // Setiap gerakan menghabiskan sedikit uang (ongkos).
    uang = _uang - 5;
  }

  // Snapshot ringan untuk SaveStack (undo).
  Map<String, int> snapshot() => {
        'health': _health,
        'karma': _karma,
        'uang': _uang,
      };

  void restore(Map<String, int> snap) {
    _health = snap['health'] ?? _health;
    _karma = snap['karma'] ?? _karma;
    _uang = snap['uang'] ?? _uang;
  }
}
