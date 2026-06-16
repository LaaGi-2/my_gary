// ============================================================
// screens/game_screen.dart
// ------------------------------------------------------------
// Layar utama gameplay. Menggabungkan:
//   - NarrativePanel
//   - DialogQueuePanel (FIFO)
//   - ChoiceButtons (binary tree branching)
//   - ActionBar (Undo/LIFO, Redo, History, Inventory)
//   - Drawer history (Double Linked List forward/backward)
//   - BottomSheet inventory (BST in-order)
// ============================================================

import 'package:flutter/material.dart';
import '../engine/game_engine.dart';
import '../theme/app_theme.dart';
import '../widgets/action_bar.dart';
import '../widgets/choice_buttons.dart';
import '../widgets/dialog_queue_panel.dart';
import '../widgets/grid_background.dart';
import '../widgets/history_drawer.dart';
import '../widgets/inventory_sheet.dart';
import '../widgets/narrative_panel.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final GameEngine engine = GameEngine();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    engine.addListener(_onEngineChanged);
  }

  void _onEngineChanged() => setState(() {});

  @override
  void dispose() {
    engine.removeListener(_onEngineChanged);
    engine.dispose();
    super.dispose();
  }

  void _openInventory() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => InventorySheet(engine: engine),
    );
  }

  void _openHistory() => _scaffoldKey.currentState?.openEndDrawer();

  @override
  Widget build(BuildContext context) {
    final node = engine.current;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppTheme.paperCream,
      endDrawer: HistoryDrawer(engine: engine),
      body: GridBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
                child: Row(
                  children: [
                    IconButton(
                      key: const ValueKey('back-home-btn'),
                      icon: const Icon(Icons.arrow_back,
                          color: AppTheme.inkBrown),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Spacer(),
                    Text(
                      'MyGary LightNovel',
                      style: TextStyle(
                        fontFamily: 'serif',
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.inkBrown.withOpacity(0.85),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      key: const ValueKey('reset-btn'),
                      icon: const Icon(Icons.refresh,
                          color: AppTheme.inkBrown),
                      onPressed: engine.reset,
                    ),
                  ],
                ),
              ),
              // Stat strip
              _PlayerStats(engine: engine),
              const SizedBox(height: 8),
              // Konten utama scrollable
              Expanded(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      NarrativePanel(node: node),
                      const SizedBox(height: AppTheme.sp2),
                      DialogQueuePanel(engine: engine),
                      if (!engine.dialogQueue.isEmpty)
                        const SizedBox(height: AppTheme.sp2),
                      ChoiceButtons(engine: engine, node: node),
                      const SizedBox(height: AppTheme.sp2),
                    ],
                  ),
                ),
              ),
              // Action bar bawah
              Container(
                decoration: const BoxDecoration(
                  color: AppTheme.paperLight,
                  border: Border(
                      top: BorderSide(color: AppTheme.paperShadow, width: 1)),
                ),
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: ActionBar(
                  engine: engine,
                  onOpenInventory: _openInventory,
                  onOpenHistory: _openHistory,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlayerStats extends StatelessWidget {
  final GameEngine engine;
  const _PlayerStats({required this.engine});

  @override
  Widget build(BuildContext context) {
    final p = engine.player;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.paperLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.paperShadow),
      ),
      child: Row(
        children: [
          _Stat(icon: Icons.favorite, label: 'HP', value: '${p.health}'),
          const _StatDivider(),
          _Stat(
              icon: Icons.psychology_outlined,
              label: 'Karma',
              value: '${p.karma}'),
          const _StatDivider(),
          _Stat(
              icon: Icons.account_balance_wallet_outlined,
              label: 'Uang',
              value: '${p.uang}k'),
          const _StatDivider(),
          _Stat(
              icon: Icons.bookmark_outline,
              label: 'Item',
              value: '${engine.inventory.count}'),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _Stat({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 14, color: AppTheme.inkSoft),
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'serif',
                  fontSize: 11,
                  color: AppTheme.inkSoft,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'serif',
              fontWeight: FontWeight.bold,
              color: AppTheme.inkBrown,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  const _StatDivider();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      width: 1,
      color: AppTheme.paperShadow,
    );
  }
}