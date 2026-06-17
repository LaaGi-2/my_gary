import 'player.dart';

class Event {
  final String judul;
  Event(this.judul);

  String jalankanEvent(Player p) {
    return 'Event \"$judul\" terjadi.';
  }
}

class DialogEvent extends Event {
  final String pembicara;
  final List<String> kalimat; 

  DialogEvent({
    required String judul,
    required this.pembicara,
    required this.kalimat,
  }) : super(judul);

  @override
  String jalankanEvent(Player p) {
    return '[$pembicara]: ${kalimat.isNotEmpty ? kalimat.first : "..."}';
  }
}

class CombatEvent extends Event {
  final int damage;     
  final int karmaShift;

  CombatEvent({
    required String judul,
    this.damage = 10,
    this.karmaShift = -5,
  }) : super(judul);

  @override
  String jalankanEvent(Player p) {
    p.health = p.health - damage;
    p.karma = p.karma + karmaShift;
    return 'Pertarungan batin \"$judul\" menguras ${damage} HP.';
  }
}
