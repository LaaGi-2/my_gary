// ============================================================
// engine/game_engine.dart
// ------------------------------------------------------------
// CORE LOGIC: GameEngine mengikat semua struktur data:
//   - BinaryTree (root StoryNode)        : alur cerita
//   - DoubleLinkedList<StoryNode>        : history log (forward/backward)
//   - SaveStack<GameSnapshot>            : LIFO untuk Undo
//   - DialogQueue<String>                : FIFO untuk dialog
//   - InventoryBST                       : pencarian item cepat
//   - RecursiveEndingFinder              : algoritma rekursif menelusuri leaf
//
// Sengaja extends ChangeNotifier agar UI Flutter bisa reactive.
// ============================================================

import 'package:flutter/foundation.dart';

import '../models/event.dart';
import '../models/player.dart';
import '../models/story_node.dart';
import '../structures/dialog_queue.dart';
import '../structures/double_linked_list.dart';
import '../structures/inventory_bst.dart';
import '../structures/save_stack.dart';
import 'story_builder.dart';

/// Snapshot ringan untuk Undo/Redo (state penuh).
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

  // Ending yang sudah dibuka (untuk galeri).
  final Set<String> _endingsUnlocked = <String>{};

  // ============= GETTERS UNTUK UI =============
  StoryNode get root => _root;
  StoryNode get current => _current;
  Player get player => _player;
  DialogQueue<String> get dialogQueue => _dialogQueue;
  InventoryBST get inventory => _inventory;
  DoubleLinkedList<StoryNode> get history => _history;
  Set<String> get endingsUnlocked => _endingsUnlocked;
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

  // Jalankan efek node saat ini: events polimorfik, item ke BST,
  // dan dialog ke Queue (FIFO).
  void _applyNodeEffects(StoryNode node) {
    // Polimorfisme: Event.jalankanEvent() berbeda untuk DialogEvent vs CombatEvent.
    for (final Event e in node.events) {
      e.jalankanEvent(_player);
      if (e is DialogEvent) {
        // ENQUEUE dialog ke antrean (akan di-dequeue FIFO oleh UI).
        for (final baris in e.kalimat) {
          _dialogQueue.enqueue('${e.pembicara}: $baris');
        }
      }
    }
    // Item masuk InventoryBST (otomatis terurut via pointer left/right).
    if (node.itemDidapat != null) {
      _inventory.insert(node.itemDidapat!, 'Diperoleh di ${node.bab}');
    }
    // Jika ini ending leaf, catat sebagai unlocked.
    if (node.isEnding && node.endingKode != null) {
      _endingsUnlocked.add(node.endingKode!);
    }
  }

  // Buat snapshot sebelum berpindah node (untuk undo).
  GameSnapshot _snapshot() {
    return GameSnapshot(
      nodeId: _current.id,
      playerStats: _player.snapshot(),
      inventorySnap: _inventory.inOrder().map((n) => n.item).toList(),
    );
  }

  // ============= NAVIGASI BINARY TREE =============
  // Pilih anak kiri (Pilihan A) atau kanan (Pilihan B).
  void pilih({required bool kiri}) {
    final next = kiri ? _current.left : _current.right;
    if (next == null) return; // sudah leaf

    // Sebelum pindah: simpan state ke SaveStack (LIFO untuk undo).
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
    _history.removeLast(); // hapus jejak terakhir di DLL
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
  // Fungsi rekursif yang memanggil dirinya sendiri untuk menelusuri
  // SEMUA daun (leaf) di binary tree cerita.
  // Base case: node null, atau node.isEnding (leaf cerita).
  List<StoryNode> temukanSemuaEnding() {
    final hasil = <StoryNode>[];
    // Gunakan Set untuk melacak ID node yang sudah dikunjungi
    final dikunjungi = <String>{};
    _telusuriLeafRekursif(_root, hasil, dikunjungi);

    hasil.sort((node1, node2) {
      final kode1 = node1.endingKode ?? '';
      final kode2 = node2.endingKode ?? '';
      return kode1.compareTo(kode2);
    });

    return hasil;
  }

  void _telusuriLeafRekursif(
      StoryNode? node, List<StoryNode> acc, Set<String> dikunjungi) {
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
