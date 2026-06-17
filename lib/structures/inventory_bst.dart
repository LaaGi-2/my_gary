class BSTNode {
  String item;       // nama item (key)
  String deskripsi;  // deskripsi singkat
  BSTNode? left;
  BSTNode? right;
  BSTNode(this.item, this.deskripsi);
}

class InventoryBST {
  BSTNode? _root;
  int _count = 0;

  int get count => _count;
  bool get isEmpty => _root == null;

  // INSERT - mengarahkan pointer left/right secara rekursif
  // sesuai perbandingan string. Duplikat item diabaikan.
  void insert(String item, String deskripsi) {
    final before = _count;
    _root = _insertNode(_root, item, deskripsi);
    if (_count > before) {

    }
  }

  BSTNode? _insertNode(BSTNode? node, String item, String deskripsi) {
    if (node == null) {
      _count++;
      return BSTNode(item, deskripsi);
    }
    final cmp = item.toLowerCase().compareTo(node.item.toLowerCase());
    if (cmp < 0) {
      //lebih kecil -> cabang kiri.
      node.left = _insertNode(node.left, item, deskripsi);
    } else if (cmp > 0) {
      //lebih besar -> cabang kanan.
      node.right = _insertNode(node.right, item, deskripsi);
    }
    // cmp == 0 -> sudah ada, tidak insert duplikat.
    return node;
  }

  // FIND NODE - validasi kepemilikan item, O(log n) rata-rata.
  // Memilih pointer kiri/kanan tiap langkah.
  BSTNode? findNode(String item) {
    var cur = _root;
    while (cur != null) {
      final cmp = item.toLowerCase().compareTo(cur.item.toLowerCase());
      if (cmp == 0) return cur;
      cur = (cmp < 0) ? cur.left : cur.right;
    }
    return null;
  }

  bool contains(String item) => findNode(item) != null;

  // hasilkan daftar item terurut secara alfabet.
  List<BSTNode> inOrder() {
    final result = <BSTNode>[];
    _inOrder(_root, result);
    return result;
  }

  void _inOrder(BSTNode? node, List<BSTNode> acc) {
    if (node == null) return;
    _inOrder(node.left, acc);
    acc.add(node);
    _inOrder(node.right, acc);
  }

  void clear() {
    _root = null;
    _count = 0;
  }
}