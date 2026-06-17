import 'package:flutter/material.dart';
import '../models/story_node.dart';
import '../theme/app_theme.dart';
import 'paper_panel.dart';

class NarrativePanel extends StatelessWidget {
  final StoryNode node;
  const NarrativePanel({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    return PaperPanel(
      withClip: false,
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            node.bab,
            style: const TextStyle(
              fontFamily: 'serif',
              fontSize: 13,
              letterSpacing: 2,
              color: AppTheme.inkSoft,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          if (node.endingJudul != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                node.endingJudul!,
                style: const TextStyle(
                  fontFamily: 'serif',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppTheme.inkBrown,
                ),
              ),
            ),
          Container(
            width: 60,
            height: 2,
            color: AppTheme.goldClip,
            margin: const EdgeInsets.only(bottom: 12),
          ),
          Text(
            node.narasi,
            style: const TextStyle(
              fontFamily: 'serif',
              fontSize: 15,
              height: 1.6,
              color: AppTheme.inkBrown,
            ),
          ),
        ],
      ),
    );
  }
}