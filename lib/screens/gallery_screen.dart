// ============================================================
// screens/gallery_screen.dart
// ------------------------------------------------------------
// Galeri Semua Ending. Daftar leaf node dihasilkan oleh
// FUNGSI REKURSIF `temukanSemuaEnding()` di GameEngine.
// Status unlock dari `endingsUnlocked` (terisi saat pemain
// menyentuh leaf node yang sesuai).
// ============================================================

import 'package:flutter/material.dart';
import '../engine/game_engine.dart';
import '../models/story_node.dart';
import '../theme/app_theme.dart';
import '../widgets/grid_background.dart';
import '../widgets/paper_panel.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Catatan: GameEngine dibuat baru di sini hanya untuk menelusuri
    // pohon (struktur sama). Untuk track unlock-cross-screen di
    // aplikasi nyata, gunakan Provider/InheritedWidget. Sederhana di sini.
    final engine = GameEngine();
    final endings = engine.temukanSemuaEnding();

    return Scaffold(
      backgroundColor: AppTheme.paperCream,
      body: GridBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 16, 4),
                child: Row(
                  children: [
                    IconButton(
                      key: const ValueKey('gallery-back-btn'),
                      icon: const Icon(Icons.arrow_back,
                          color: AppTheme.inkBrown),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Text(
                      'Galeri Ending',
                      style: TextStyle(
                        fontFamily: 'serif',
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: AppTheme.inkBrown,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Text(
                  'Ditemukan oleh algoritma rekursif yang menelusuri seluruh leaf binary tree cerita. '
                  'Total: ${endings.length} ending.',
                  style: const TextStyle(
                    fontFamily: 'serif',
                    fontSize: 12,
                    color: AppTheme.inkSoft,
                    height: 1.5,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: endings.length,
                  itemBuilder: (_, i) => _EndingCard(node: endings[i]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EndingCard extends StatelessWidget {
  final StoryNode node;
  const _EndingCard({required this.node});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: PaperPanel(
        withClip: false,
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ENDING ${node.endingKode ?? '-'}',
              style: const TextStyle(
                fontFamily: 'serif',
                fontSize: 12,
                letterSpacing: 2,
                color: AppTheme.goldClipDark,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              node.endingJudul ?? node.bab,
              style: const TextStyle(
                fontFamily: 'serif',
                fontWeight: FontWeight.bold,
                fontSize: 19,
                color: AppTheme.inkBrown,
              ),
            ),
            Container(
              width: 50,
              height: 2,
              color: AppTheme.goldClip,
              margin: const EdgeInsets.symmetric(vertical: 10),
            ),
            Text(
              node.narasi,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'serif',
                fontSize: 14,
                color: AppTheme.inkBrown,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}