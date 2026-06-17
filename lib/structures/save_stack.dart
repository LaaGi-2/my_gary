class _StackNode<T> {
  T data;
  _StackNode<T>? below;
  _StackNode(this.data, [this.below]);
}

class SaveStack<T> {
  _StackNode<T>? _top;
  int _size = 0;

  int get size => _size;
  bool get isEmpty => _top == null;

  // tambahkan elemen di atas tumpukan.
  void push(T data) {
    _top = _StackNode<T>(data, _top); // node baru menunjuk ke top lama
    _size++;
  }

  // keluarkan elemen paling atas (paling baru). Untuk UNDO.
  T? pop() {
    if (_top == null) return null;
    final data = _top!.data;
    _top = _top!.below; // top sekarang menjadi node di bawahnya
    _size--;
    return data;
  }

  // lihat tanpa mengeluarkan.
  T? peek() => _top?.data;

  void clear() {
    _top = null;
    _size = 0;
  }
}