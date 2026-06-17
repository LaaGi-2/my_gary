import 'event.dart';

class StoryNode {
  final String id;
  final String bab;       
  final String narasi;    
  final String? pilihanA; 
  final String? pilihanB; 
  final List<Event> events; 
  final String? itemDidapat;
  final bool isEnding;
  final String? endingKode;
  final String? endingJudul;

  // Pointer cerita.
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

  // Helper: leaf
  bool get isLeaf => left == null && right == null;
}