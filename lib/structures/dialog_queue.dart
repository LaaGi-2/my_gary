// ============================================================
// structures/dialog_queue.dart
// ------------------------------------------------------------
// QUEUE (FIFO - First In, First Out) - MANUAL.
// Class DialogQueue menggunakan pointer `_front` dan `_rear`.
// Teks dialog karakter masuk via ENQUEUE (ke _rear), lalu
// ditampilkan ke layar urut dengan DEQUEUE (dari _front).
//
// >>> KAPAN FIFO TERJADI <<<
// FIFO terjadi pada dequeue(): elemen yang PERTAMA di-enqueue
// adalah yang PERTAMA dikeluarkan. Ini meniru antrean dialog
// percakapan natural (urutan baris dialog tidak boleh diacak).
// ============================================================

class _QNode<T> {
  T data;
  _QNode<T>? next;
  _QNode(this.data);
}

class DialogQueue<T> {
  _QNode<T>? _front; // pointer depan (lokasi dequeue)
  _QNode<T>? _rear;  // pointer belakang (lokasi enqueue)
  int _size = 0;

  int get size => _size;
  bool get isEmpty => _front == null;

  // ENQUEUE: masukkan ke REAR (belakang).
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

  // DEQUEUE: keluarkan dari FRONT (depan) - FIFO.
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

  // Snapshot isi antrean (untuk UI).
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