// ============================================================
// widgets/dialog_queue_panel.dart
// ------------------------------------------------------------
// Panel \"Queue Dialog\": menampilkan dialog karakter dari
// DialogQueue (FIFO). Tombol \"Lanjut\" memanggil dequeue() yang
// mengeluarkan baris paling DEPAN sesuai urutan masuknya.
// ============================================================

import 'package:flutter/material.dart';
import '../engine/game_engine.dart';
import '../theme/app_theme.dart';
import 'paper_panel.dart';

class DialogQueuePanel extends StatelessWidget {
  final GameEngine engine;
  const DialogQueuePanel({super.key, required this.engine});

  @override
  Widget build(BuildContext context) {
    final items = engine.dialogQueue.toList();
    if (items.isEmpty) return const SizedBox.shrink();

    return PaperPanel(
      color: const Color(0xFFFFF7E1),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.chat_bubble_outline,
                  size: 16, color: AppTheme.inkSoft),
              const SizedBox(width: 6),
              Text(
                'QUEUE DIALOG (${items.length})',
                style: const TextStyle(
                  fontFamily: 'serif',
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  letterSpacing: 1.5,
                  color: AppTheme.inkSoft,
                ),
              ),
              const Spacer(),
              TextButton(
                key: const ValueKey('dialog-next-btn'),
                onPressed: () => engine.dequeueDialog(),
                child: const Text(
                  'Lanjut ▸',
                  style: TextStyle(
                    fontFamily: 'serif',
                    color: AppTheme.inkBrown,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Baris paling depan (akan keluar berikutnya).
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.paperLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.goldClip, width: 1),
            ),
            child: Text(
              items.first,
              style: const TextStyle(
                fontFamily: 'serif',
                fontSize: 14,
                color: AppTheme.inkBrown,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          if (items.length > 1) ...[
            const SizedBox(height: 8),
            Text(
              '${items.length - 1} dialog menunggu di antrean…',
              style: const TextStyle(
                fontFamily: 'serif',
                fontSize: 11,
                color: AppTheme.inkSoft,
              ),
            ),
          ],
        ],
      ),
    );
  }
}