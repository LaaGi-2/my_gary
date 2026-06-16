// ============================================================
// widgets/choice_buttons.dart
// ------------------------------------------------------------
// Tombol Decision A / Decision B. Memanggil engine.pilih(kiri:).
// ============================================================

import 'package:flutter/material.dart';
import '../engine/game_engine.dart';
import '../models/story_node.dart';
import '../theme/app_theme.dart';

class ChoiceButtons extends StatelessWidget {
  final GameEngine engine;
  final StoryNode node;
  const ChoiceButtons({super.key, required this.engine, required this.node});

  @override
  Widget build(BuildContext context) {
    if (node.isEnding || node.isLeaf) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: AppTheme.goldClip.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.goldClipDark, width: 1.5),
        ),
        child: Text(
          '— TAMAT (Ending ${node.endingKode ?? '?'}) —\nBuka galeri untuk melihat ending lain.',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'serif',
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: AppTheme.inkBrown,
            height: 1.5,
          ),
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          child: _ChoiceCard(
            label: 'Pilihan A',
            text: node.pilihanA ?? '',
            onTap: () => engine.pilih(kiri: true),
            testKey: 'choice-a-btn',
          ),
        ),
        const SizedBox(width: AppTheme.sp2),
        Expanded(
          child: _ChoiceCard(
            label: 'Pilihan B',
            text: node.pilihanB ?? '',
            onTap: () => engine.pilih(kiri: false),
            testKey: 'choice-b-btn',
          ),
        ),
      ],
    );
  }
}

class _ChoiceCard extends StatelessWidget {
  final String label;
  final String text;
  final VoidCallback onTap;
  final String testKey;
  const _ChoiceCard({
    required this.label,
    required this.text,
    required this.onTap,
    required this.testKey,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        key: ValueKey(testKey),
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppTheme.paperLight,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppTheme.inkBrown, width: 1.2),
            boxShadow: const [
              BoxShadow(
                color: AppTheme.paperShadow,
                offset: Offset(3, 4),
                blurRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: const TextStyle(
                  fontFamily: 'serif',
                  fontSize: 11,
                  letterSpacing: 1.5,
                  color: AppTheme.goldClipDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                text,
                style: const TextStyle(
                  fontFamily: 'serif',
                  fontSize: 14,
                  color: AppTheme.inkBrown,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}