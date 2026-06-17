import 'makhluk.dart';

class Player extends MakhlukHidup {
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

  //  Getter 
  int get health => _health;
  int get karma => _karma;
  int get uang => _uang;

  //  Setter  
  set health(int value) {
    if (value < 0) {
      _health = 0;
    } else if (value > 100) {
      _health = 100;
    } else {
      _health = value;
    }
  }

  set karma(int value) {
    if (value < -100) {
      _karma = -100;
    } else if (value > 100) {
      _karma = 100;
    } else {
      _karma = value;
    }
  }

  set uang(int value) {
    _uang = value < 0 ? 0 : value;
  }

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
