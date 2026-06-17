import 'package:flutter/material.dart';
import '../engine/game_engine.dart';
import '../theme/app_theme.dart';

class InventorySheet extends StatelessWidget {
  final GameEngine engine;
  const InventorySheet({super.key, required this.engine});

  @override
  Widget build(BuildContext context) {
    final items = engine.inventory.inOrder();
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
      decoration: const BoxDecoration(
        color: AppTheme.paperLight,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: AppTheme.paperShadow,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          const SizedBox(height: AppTheme.sp2),
          const Text(
            'Inventory (BST)',
            style: TextStyle(
              fontFamily: 'serif',
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: AppTheme.inkBrown,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Terurut alfabetis via in-order traversal BST (${items.length} item)',
            style: const TextStyle(
              fontFamily: 'serif',
              fontSize: 12,
              color: AppTheme.inkSoft,
            ),
          ),
          const SizedBox(height: AppTheme.sp2),
          if (items.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: Text(
                  'Belum ada item. Item akan otomatis tersusun di BST saat kamu memperolehnya.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'serif',
                    color: AppTheme.inkSoft,
                    height: 1.5,
                  ),
                ),
              ),
            )
          else
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 320),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: items.length,
                separatorBuilder: (_, __) => const Divider(
                  color: AppTheme.paperShadow,
                  height: 1,
                ),
                itemBuilder: (_, i) => ListTile(
                  key: ValueKey('inv-item-$i'),
                  leading: const Icon(Icons.bookmark_outline,
                      color: AppTheme.goldClipDark),
                  title: Text(
                    items[i].item,
                    style: const TextStyle(
                      fontFamily: 'serif',
                      fontWeight: FontWeight.bold,
                      color: AppTheme.inkBrown,
                    ),
                  ),
                  subtitle: Text(
                    items[i].deskripsi,
                    style: const TextStyle(
                      fontFamily: 'serif',
                      fontSize: 12,
                      color: AppTheme.inkSoft,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}