// ============================================================
// widgets/grid_background.dart
// ------------------------------------------------------------
// Background bergaris-titik halus ala kertas grid notebook.
// ============================================================

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GridBackground extends StatelessWidget {
  final Widget child;
  const GridBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.paperCream,
      child: CustomPaint(
        painter: _GridPainter(),
        child: child,
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  final double step = 40;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.paperShadow.withOpacity(0.55)
      ..strokeWidth = 0.6
      ..style = PaintingStyle.fill;

    for (double x = 0; x < size.width; x += step) {
      for (double y = 0; y < size.height; y += step) {
        // Titik kecil di tiap perpotongan grid (efek dotted grid).
        canvas.drawCircle(Offset(x, y), 0.9, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}