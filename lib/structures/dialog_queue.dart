class _QNode<T> {
  T data;
  _QNode<T>? next;
  _QNode(this.data);
}

class DialogQueue<T> {
  _QNode<T>? _front;
  _QNode<T>? _rear; 
  int _size = 0;

  int get size => _size;
  bool get isEmpty => _front == null;

  // masukkan ke REAR (belakang).
  void enqueue(T data) {
    final node = _QNode<T>(data);
    if (_rear == null) {
      _front = node;
      _rear = node;
    } else {
      _rear!.next = node;
      _rear = node;
    }
    _size++;
  }

  // keluarkan dari FRONT (depan) - FIFO.
  T? dequeue() {
    if (_front == null) return null;
    final data = _front!.data;
    _front = _front!.next;
    if (_front == null) _rear = null; // antrean kosong, reset rear
    _size--;
    return data;
  }

  // Intip front tanpa keluarkan.
  T? peekFront() => _front?.data;

  // Snapshot isi antrean
  List<T> toList() {
    final list = <T>[];
    var cur = _front;
    while (cur != null) {
      list.add(cur.data);
      cur = cur.next;
    }
    return list;
  }

  void clear() {
    _front = null;
    _rear = null;
    _size = 0;
  }
}