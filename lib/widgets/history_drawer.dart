
// widgets/history_drawer.dart
// ------------------------------------------------------------
// Drawer \"History Log\" - menampilkan Double Linked List
// dengan scan forward & backward.
// ============================================================

import 'package:flutter/material.dart';
import '../engine/game_engine.dart';
import '../theme/app_theme.dart';

class HistoryDrawer extends StatefulWidget {
  final GameEngine engine;
  const HistoryDrawer({super.key, required this.engine});

  @override
  State<HistoryDrawer> createState() => _HistoryDrawerState();
}

class _HistoryDrawerState extends State<HistoryDrawer> {
  bool _forward = true;

  @override
  Widget build(BuildContext context) {
    final items = _forward
        ? widget.engine.history.forwardScan()
        : widget.engine.history.backwardScan();

    return Drawer(
      backgroundColor: AppTheme.paperLight,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'History Log',
                style: TextStyle(
                  fontFamily: 'serif',
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: AppTheme.inkBrown,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Double Linked List (pointer next / prev)',
                style: TextStyle(
                  fontFamily: 'serif',
                  fontSize: 12,
                  color: AppTheme.inkSoft,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  ChoiceChip(
                    key: const ValueKey('history-forward-chip'),
                    label: const Text('Forward ▶'),
                    selected: _forward,
                    onSelected: (_) => setState(() => _forward = true),
                    selectedColor: AppTheme.goldClip,
                    labelStyle: const TextStyle(
                        fontFamily: 'serif', color: AppTheme.inkBrown),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    key: const ValueKey('history-backward-chip'),
                    label: const Text('◀ Backward'),
                    selected: !_forward,
                    onSelected: (_) => setState(() => _forward = false),
                    selectedColor: AppTheme.goldClip,
                    labelStyle: const TextStyle(
                        fontFamily: 'serif', color: AppTheme.inkBrown),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (_, i) {
                    final node = items[i];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.paperCream,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppTheme.paperShadow),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${i + 1}. ${node.bab}',
                            style: const TextStyle(
                              fontFamily: 'serif',
                              fontWeight: FontWeight.bold,
                              color: AppTheme.inkBrown,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            node.narasi.split('\n').first,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: 'serif',
                              fontSize: 12,
                              color: AppTheme.inkSoft,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}