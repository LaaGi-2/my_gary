// ============================================================
// structures/save_stack.dart
// ------------------------------------------------------------
// STACK (LIFO - Last In, First Out) - MANUAL.
// Menyimpan riwayat STATE permainan. Saat pemain ingin
// \"Undo\" (menyesali keputusan terakhir), kita panggil pop()
// untuk mengeluarkan state paling akhir lalu mengembalikan
// kondisi pemain ke state sebelum itu.
//
// >>> KAPAN LIFO TERJADI <<<
// LIFO terjadi pada method pop(): elemen yang TERAKHIR dimasukkan
// (push) adalah yang PERTAMA keluar. Ini cocok untuk Undo karena
// kita selalu ingin membatalkan AKSI TERBARU dulu.
// ============================================================

class _StackNode<T> {
  T data;
  _StackNode<T>? below; // pointer ke elemen di bawahnya
  _StackNode(this.data, [this.below]);
}

class SaveStack<T> {
  _StackNode<T>? _top;
  int _size = 0;

  int get size => _size;
  bool get isEmpty => _top == null;

  // PUSH: tambahkan elemen di atas tumpukan.
  void push(T data) {
    _top = _StackNode<T>(data, _top); // node baru menunjuk ke top lama
    _size++;
  }

  // POP: LIFO - keluarkan elemen paling atas (paling baru). Untuk UNDO.
  T? pop() {
    if (_top == null) return null;
    final data = _top!.data;
    _top = _top!.below; // top sekarang menjadi node di bawahnya
    _size--;
    return data;
  }

  // PEEK: lihat tanpa mengeluarkan.
  T? peek() => _top?.data;

  void clear() {
    _top = null;
    _size = 0;
  }
}