// ============================================================
// widgets/paper_panel.dart
// ------------------------------------------------------------
// Widget reusable: panel kertas bergaya buku interaktif dengan
// paperclip emas opsional. Dipakai untuk semua panel utama.
// ============================================================

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PaperPanel extends StatelessWidget {
  final Widget child;
  final bool withClip;
  final EdgeInsets padding;
  final Color color;
  const PaperPanel({
    super.key,
    required this.child,
    this.withClip = false,
    this.padding = const EdgeInsets.all(AppTheme.sp3),
    this.color = AppTheme.paperLight,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: padding,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(AppTheme.rLg),
            boxShadow: const [
              BoxShadow(
                color: AppTheme.paperShadow,
                offset: Offset(4, 6),
                blurRadius: 0,
              ),
            ],
            border: Border.all(color: AppTheme.paperShadow, width: 1),
          ),
          child: child,
        ),
        if (withClip)
          Positioned(
            top: -14,
            left: 24,
            child: _PaperClip(),
          ),
      ],
    );
  }
}

class _PaperClip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          colors: [AppTheme.goldClip, AppTheme.goldClipDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black26, offset: Offset(1, 2), blurRadius: 3),
        ],
      ),
      child: Center(
        child: Container(
          width: 12,
          height: 24,
          decoration: BoxDecoration(
            color: AppTheme.paperCream,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppTheme.goldClipDark, width: 1),
          ),
        ),
      ),
    );
  }
}