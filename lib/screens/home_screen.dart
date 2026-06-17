import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';
import '../widgets/grid_background.dart';
import '../widgets/paper_panel.dart';
import 'game_screen.dart';
import 'gallery_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 30),
                  // Judul brand
                  Text(
                    'MyGary',
                    style: TextStyle(
                      fontFamily: 'serif',
                      fontWeight: FontWeight.bold,
                      fontSize: 72,
                      color: AppTheme.inkBrown,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 1,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.08),
                          offset: const Offset(2, 3),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'Story',
                    style: TextStyle(
                      fontFamily: 'serif',
                      fontSize: 30,
                      color: AppTheme.inkSoft,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 50),
                  // Panel menu dengan paperclip
                  PaperPanel(
                    withClip: false,
                    padding: const EdgeInsets.fromLTRB(28, 36, 28, 24),
                    child: Column(
                      children: [
                        _MenuButton(
                          label: 'Mulai',
                          testKey: 'start-btn',
                          bold: true,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const GameScreen(),
                              ),
                            );
                          },
                        ),
                        const _Divider(),
                        _MenuButton(
                          label: 'Galeri Ending',
                          testKey: 'gallery-btn',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const GalleryScreen(),
                              ),
                            );
                          },
                        ),
                        const _Divider(),
                        _MenuButton(
                          label: 'Keluar',
                          testKey: 'exit-btn',
                          onTap: () => SystemNavigator.pop(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Server Error di Negeri Sendiri',
                    style: TextStyle(
                      fontFamily: 'serif',
                      fontSize: 13,
                      color: AppTheme.inkSoft,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final String label;
  final String testKey;
  final VoidCallback onTap;
  final bool bold;
  const _MenuButton({
    required this.label,
    required this.testKey,
    required this.onTap,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: ValueKey(testKey),
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: bold ? 22 : 18,
            fontWeight: bold ? FontWeight.bold : FontWeight.w600,
            color: AppTheme.inkBrown,
          ),
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) {
    return Padding( 
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Expanded(child: Divider(color: AppTheme.paperShadow)),
          const SizedBox(width: 8),
          Icon(Icons.auto_awesome,
              size: 14, color: AppTheme.goldClipDark.withOpacity(0.6)),
          const SizedBox(width: 8),
          const Expanded(child: Divider(color: AppTheme.paperShadow)),
        ],
      ),
    );
  }
}