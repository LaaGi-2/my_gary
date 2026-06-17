import 'package:flutter/foundation.dart';

import '../models/event.dart';
import '../models/player.dart';
import '../models/story_node.dart';
import '../structures/dialog_queue.dart';
import '../structures/double_linked_list.dart';
import '../structures/inventory_bst.dart';
import '../structures/save_stack.dart';
import 'story_builder.dart';

/// Snapshot ringan untuk Undo/Redo.
class GameSnapshot {
  final String nodeId;
  final Map<String, int> playerStats;
  final List<String> inventorySnap; // daftar item saat itu
  GameSnapshot({
    required this.nodeId,
    required this.playerStats,
    required this.inventorySnap,
  });
}

class GameEngine extends ChangeNotifier {
  // Default constructor
  GameEngine() {
    _root = StoryBuilder.buildTree();
    reset();
  }

  late StoryNode _root;
  late StoryNode _current;
  late Player _player;

  // Struktur data inti
  final DoubleLinkedList<StoryNode> _history = DoubleLinkedList<StoryNode>();
  final SaveStack<GameSnapshot> _undoStack = SaveStack<GameSnapshot>();
  final SaveStack<GameSnapshot> _redoStack = SaveStack<GameSnapshot>();
  final DialogQueue<String> _dialogQueue = DialogQueue<String>();
  final InventoryBST _inventory = InventoryBST();

  // ============= GETTERS UNTUK UI =============
  StoryNode get current => _current;
  Player get player => _player;
  DialogQueue<String> get dialogQueue => _dialogQueue;
  InventoryBST get inventory => _inventory;
  DoubleLinkedList<StoryNode> get history => _history;
  bool get canUndo => !_undoStack.isEmpty;
  bool get canRedo => !_redoStack.isEmpty;

  // ============= LIFECYCLE =============
  void reset() {
    _player = Player.hero();
    _current = _root;
    _history.clear();
    _undoStack.clear();
    _redoStack.clear();
    _dialogQueue.clear();
    _inventory.clear();
    _history.append(_current);
    _applyNodeEffects(_current);
    notifyListeners();
  }
  
  void _applyNodeEffects(StoryNode node) {
    for (final Event e in node.events) {
      e.jalankanEvent(_player);
      if (e is DialogEvent) {
        // ENQUEUE dialog ke antrean.
        for (final baris in e.kalimat) {
          _dialogQueue.enqueue('${e.pembicara}: $baris');
        }
      }
    }
    // Item masuk InventoryBST.
    if (node.itemDidapat != null) {
      _inventory.insert(node.itemDidapat!, 'Diperoleh di ${node.bab}');
    }
  }

  // Buat snapshot -> inisialisasi simpan sementara.
  GameSnapshot _snapshot() {
    return GameSnapshot(
      nodeId: _current.id,
      playerStats: _player.snapshot(),
      inventorySnap: _inventory.inOrder().map((n) => n.item).toList(),
    );
  }

  // ============= NAVIGASI =============
  void pilih({required bool kiri}) {
    final next = kiri ? _current.left : _current.right;
    if (next == null) return; // sudah leaf

    // simpan state ke SaveStack (undo).
    _undoStack.push(_snapshot());
    _redoStack.clear(); // redo invalid setelah pilihan baru

    _current = next;
    _history.append(_current); // catat di Double Linked List

    // Polimorfisme + FIFO dialog + insert BST.
    _applyNodeEffects(_current);
    notifyListeners();
  }

  // ============= UNDO / REDO =============
  // UNDO -> LIFO: pop() state paling terakhir, kembalikan kondisi.
  void undo() {
    final snap = _undoStack.pop();
    if (snap == null) return;
    _redoStack.push(_snapshot()); // simpan current ke redo
    _restoreSnapshot(snap);
    _history.removeLast();        // hapus jejak terakhir di DLL
    notifyListeners();
  }

  void redo() {
    final snap = _redoStack.pop();
    if (snap == null) return;
    _undoStack.push(_snapshot());
    _restoreSnapshot(snap);
    _history.append(_findNodeById(snap.nodeId) ?? _current);
    notifyListeners();
  }

  void _restoreSnapshot(GameSnapshot snap) {
    final n = _findNodeById(snap.nodeId);
    if (n != null) _current = n;
    _player.restore(snap.playerStats);
    // Re-build inventory dari snapshot (sederhana - rebuild BST).
    _inventory.clear();
    for (final item in snap.inventorySnap) {
      _inventory.insert(item, 'Dipulihkan');
    }
  }

  // Cari node by id - DFS rekursif di binary tree.
  StoryNode? _findNodeById(String id) => _dfsFind(_root, id);
  StoryNode? _dfsFind(StoryNode? node, String id) {
    if (node == null) return null;
    if (node.id == id) return node;
    return _dfsFind(node.left, id) ?? _dfsFind(node.right, id);
  }

  // ============= DIALOG QUEUE - FIFO POP =============
  // UI memanggil ini untuk menampilkan baris dialog satu per satu.
  String? dequeueDialog() {
    final next = _dialogQueue.dequeue();
    if (next != null) notifyListeners();
    return next;
  }

  // ============= INVENTORY BST QUERY =============
  bool punyaItem(String item) => _inventory.contains(item);

  // ============= ALGORITMA REKURSIF: TEMUKAN SEMUA ENDING =============
  List<StoryNode> temukanSemuaEnding() {
      final hasil = <StoryNode>[];
      // Gunakan Set untuk melacak ID node yang sudah dikunjungi
      final dikunjungi = <String>{}; 
      _telusuriLeafRekursif(_root, hasil, dikunjungi);
      hasil.sort((a, b) => a.id.compareTo(b.id));
      return hasil;
    }
  
    void _telusuriLeafRekursif(StoryNode? node, List<StoryNode> acc, Set<String> dikunjungi) {
      // node tidak ada -> berhenti.
      if (node == null) return;
      // Jika node ini sudah pernah dicek dari cabang lain, lewati agar tidak duplikat.
      if (dikunjungi.contains(node.id)) return;
      
      // Tandai node ini sudah dikunjungi
      dikunjungi.add(node.id);
  
      // node adalah ending (leaf cerita) -> kumpulkan & berhenti rekursi.
      if (node.isEnding || node.isLeaf) {
        acc.add(node);
        return;
      }
      // panggil diri sendiri untuk anak kiri & kanan.
      _telusuriLeafRekursif(node.left, acc, dikunjungi);
      _telusuriLeafRekursif(node.right, acc, dikunjungi);
    }
}