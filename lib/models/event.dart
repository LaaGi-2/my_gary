// ============================================================
// models/event.dart
// ------------------------------------------------------------
// INHERITANCE & POLYMORPHISM:
// `Event` adalah parent class. `DialogEvent` dan `CombatEvent`
// menggunakan keyword `extends`. Method `jalankanEvent()` di
// OVERRIDE pada masing-masing child class.
// ============================================================

import 'player.dart';

class Event {
  final String judul;
  Event(this.judul);

  // Method dasar - akan di-override polimorfik di child class.
  String jalankanEvent(Player p) {
    return 'Event \"$judul\" terjadi.';
  }
}

class DialogEvent extends Event {
  final String pembicara;
  final List<String> kalimat; // baris-baris dialog (akan masuk DialogQueue)

  DialogEvent({
    required String judul,
    required this.pembicara,
    required this.kalimat,
  }) : super(judul);

  @override
  String jalankanEvent(Player p) {
    // POLYMORPHISM: perilaku berbeda dari parent.
    return '[$pembicara]: ${kalimat.isNotEmpty ? kalimat.first : "..."}';
  }
}

class CombatEvent extends Event {
  final int damage;     // damage ke health
  final int karmaShift; // perubahan karma akibat konflik batin

  CombatEvent({
    required String judul,
    this.damage = 10,
    this.karmaShift = -5,
  }) : super(judul);

  @override
  String jalankanEvent(Player p) {
    // POLYMORPHISM: terapkan damage & karma shift ke player.
    p.health = p.health - damage;
    p.karma = p.karma + karmaShift;
    return 'Pertarungan batin \"$judul\" menguras ${damage} HP.';
  }
}
