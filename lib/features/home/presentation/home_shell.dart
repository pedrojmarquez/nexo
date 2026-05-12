import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nexo/core/theme/app_colors.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// HomeShell — Shell principal de navegación
/// ─────────────────────────────────────────────────────────────────────────────
class HomeShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const HomeShell({
    super.key,
    required this.navigationShell,
  });

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NexoColors.background,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: navigationShell,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: NexoColors.white,
          border: Border(
              top:
                  BorderSide(color: NexoColors.divider.withValues(alpha: 0.5))),
          boxShadow: [
            BoxShadow(
              color: NexoColors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: NavigationBar(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: _onTap,
              backgroundColor: Colors.transparent,
              indicatorColor: NexoColors.primary.withValues(alpha: 0.2),
              elevation: 0,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.note_alt_outlined, color: NexoColors.textMuted),
                  selectedIcon:
                      Icon(Icons.note_alt_rounded, color: NexoColors.textMain),
                  label: 'Notas',
                ),
                NavigationDestination(
                  icon:
                      Icon(Icons.restaurant_outlined, color: NexoColors.textMuted),
                  selectedIcon:
                      Icon(Icons.restaurant_rounded, color: NexoColors.textMain),
                  label: 'Comidas',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline_rounded,
                      color: NexoColors.textMuted),
                  selectedIcon:
                      Icon(Icons.person_rounded, color: NexoColors.textMain),
                  label: 'Perfil',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
