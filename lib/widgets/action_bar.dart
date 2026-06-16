// ============================================================
// widgets/action_bar.dart
// ------------------------------------------------------------
// Action buttons: Undo (LIFO pop), Redo, History, Inventory.
// ============================================================

import 'package:flutter/material.dart';
import '../engine/game_engine.dart';
import '../theme/app_theme.dart';

class ActionBar extends StatelessWidget {
  final GameEngine engine;
  final VoidCallback onOpenInventory;
  final VoidCallback onOpenHistory;
  const ActionBar({
    super.key,
    required this.engine,
    required this.onOpenInventory,
    required this.onOpenHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _ActionBtn(
          icon: Icons.undo,
          label: 'Undo',
          testKey: 'undo-btn',
          enabled: engine.canUndo,
          onTap: engine.undo,
        ),
        _ActionBtn(
          icon: Icons.redo,
          label: 'Redo',
          testKey: 'redo-btn',
          enabled: engine.canRedo,
          onTap: engine.redo,
        ),
        _ActionBtn(
          icon: Icons.history,
          label: 'History',
          testKey: 'history-btn',
          onTap: onOpenHistory,
        ),
        _ActionBtn(
          icon: Icons.inventory_2_outlined,
          label: 'Inventory',
          testKey: 'inventory-btn',
          onTap: onOpenInventory,
        ),
      ],
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final String testKey;
  final VoidCallback onTap;
  final bool enabled;
  const _ActionBtn({
    required this.icon,
    required this.label,
    required this.testKey,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final color = enabled ? AppTheme.inkBrown : AppTheme.inkSoft.withOpacity(0.4);
    return InkWell(
      key: ValueKey(testKey),
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: color),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'serif',
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}