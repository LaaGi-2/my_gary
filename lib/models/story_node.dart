// ============================================================
// models/story_node.dart
// ------------------------------------------------------------
// BINARY TREE NODE:
// Tiap StoryNode memiliki maksimal 2 pointer anak: `left` & `right`.
// Ini adalah simpul (node) untuk pohon biner alur cerita.
//
// - left  -> percabangan keputusan A (Decision A)
// - right -> percabangan keputusan B (Decision B)
// Jika kedua pointer null, node ini adalah LEAF (ending).
// ============================================================

import 'event.dart';

class StoryNode {
  final String id;
  final String bab;       // contoh: \"Bagian 1\"
  final String narasi;    // teks panjang narator
  final String? pilihanA; // label tombol kiri (null = leaf)
  final String? pilihanB; // label tombol kanan (null = leaf)
  final List<Event> events; // dijalankan saat node ini aktif
  final String? itemDidapat; // item yang masuk InventoryBST di node ini
  final bool isEnding;
  final String? endingKode; // 'A', 'B', 'C'
  final String? endingJudul;

  // Pointer biner cerita.
  StoryNode? left;
  StoryNode? right;

  StoryNode({
    required this.id,
    required this.bab,
    required this.narasi,
    this.pilihanA,
    this.pilihanB,
    this.events = const [],
    this.itemDidapat,
    this.isEnding = false,
    this.endingKode,
    this.endingJudul,
    this.left,
    this.right,
  });

  // Helper: leaf bila tidak punya anak.
  bool get isLeaf => left == null && right == null;
}