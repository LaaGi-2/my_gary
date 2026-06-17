class DLLNode<T> {
  T data;
  DLLNode<T>? next;
  DLLNode<T>? prev;
  DLLNode(this.data);
}

class DoubleLinkedList<T> {
  DLLNode<T>? _head;
  DLLNode<T>? _tail;
  int _length = 0;

  int get length => _length;
  bool get isEmpty => _head == null;
  DLLNode<T>? get head => _head;
  DLLNode<T>? get tail => _tail;

  // Tambahkan node di belakang (append).
  void append(T data) {
    final newNode = DLLNode<T>(data);
    if (_tail == null) {
      _head = newNode;
      _tail = newNode;
    } else {
      newNode.prev = _tail;       // POINTER prev mengarah ke tail lama
      _tail!.next = newNode;      // POINTER next dari tail lama -> node baru
      _tail = newNode;
    }
    _length++;
  }

  // Hapus node di belakang.
  T? removeLast() {
    if (_tail == null) return null;
    final removed = _tail!.data;
    if (_head == _tail) {
      _head = null;
      _tail = null;
    } else {
      _tail = _tail!.prev;
      _tail!.next = null;
    }
    _length--;
    return removed;
  }

  //head -> tail melalui pointer next.
  List<T> forwardScan() {
    final result = <T>[];
    var cur = _head;
    while (cur != null) {
      result.add(cur.data);
      cur = cur.next;
    }
    return result;
  }

  // tail -> head melalui pointer prev.
  List<T> backwardScan() {
    final result = <T>[];
    var cur = _tail;
    while (cur != null) {
      result.add(cur.data);
      cur = cur.prev;
    }
    return result;
  }

  void clear() {
    _head = null;
    _tail = null;
    _length = 0;
  }
}