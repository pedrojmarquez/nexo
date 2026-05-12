import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo/core/theme/app_colors.dart';
import 'package:nexo/core/theme/app_shapes.dart';
import 'package:nexo/features/auth/presentation/providers/auth_provider.dart';
import 'package:nexo/core/theme/theme_provider.dart';
import 'package:nexo/features/profile/presentation/providers/settings_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangesProvider).valueOrNull;
    final notificationsEnabled = ref.watch(settingsControllerProvider);

    return Scaffold(
      backgroundColor: NexoColors.background,
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
            // User Header - Clean & Premium
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: NexoColors.white,
                borderRadius: NexoShapes.large,
                border: Border.all(color: NexoColors.divider.withValues(alpha: 0.5)),
                boxShadow: [
                  BoxShadow(
                    color: NexoColors.black.withValues(alpha: 0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: NexoColors.surface,
                    backgroundImage: user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
                    child: user?.photoURL == null ? const Icon(Icons.person_rounded, size: 50, color: NexoColors.primaryDark) : null,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user?.displayName ?? 'Usuario',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: NexoColors.textMain),
                  ),
                  Text(
                    user?.email ?? '',
                    style: const TextStyle(color: NexoColors.textMuted, fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            _buildSectionTitle('PREFERENCIAS'),
            const SizedBox(height: 16),
            _buildToggleOption(
              context, 
              Icons.notifications_active_outlined, 
              'Notificaciones push', 
              NexoColors.primaryDark, 
              notificationsEnabled, 
              (val) => ref.read(settingsControllerProvider.notifier).toggleNotifications(val)
            ),
            _buildThemeOption(context, ref),

            const SizedBox(height: 40),
            _buildSectionTitle('SISTEMA'),
            const SizedBox(height: 16),
            _buildOption(context, Icons.info_outline_rounded, 'Sobre Nexo', NexoColors.textSub, onTap: () => _showAbout(context)),
            _buildOption(context, Icons.help_outline_rounded, 'Centro de ayuda', NexoColors.textSub),
            
            const SizedBox(height: 60),
            // Logo - Discreet but premium
            Hero(
              tag: 'logo',
              child: Image.asset('assets/images/logo.png', width: 60, height: 60),
            ),
            const SizedBox(height: 12),
            const Text(
              'NEXO v3.5.0', 
              style: TextStyle(
                fontSize: 11, 
                fontWeight: FontWeight.w900, 
                color: NexoColors.textMuted, 
                letterSpacing: 2.0
              )
            ),
            const Text(
              'Diseñado con ❤️ en España',
              style: TextStyle(fontSize: 10, color: NexoColors.textMuted),
            ),
            
            const SizedBox(height: 60),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => ref.read(authControllerProvider.notifier).signOut(),
                icon: const Icon(Icons.logout_rounded, size: 20),
                label: const Text('CERRAR SESIÓN', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.0)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: NexoColors.white,
                  foregroundColor: NexoColors.error,
                  elevation: 0,
                  side: const BorderSide(color: NexoColors.error, width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: NexoShapes.medium),
                ),
              ),
            ),
            ],
          ),
        ),
      ),
    ),
    );
  }

  Widget _buildSectionTitle(String title) => Align(alignment: Alignment.centerLeft, child: Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: NexoColors.textMuted, letterSpacing: 1.2)));

  Widget _buildOption(BuildContext context, IconData icon, String title, Color accentColor, {String? trailingText, VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: NexoColors.white, borderRadius: NexoShapes.medium, border: Border.all(color: NexoColors.divider)),
      child: ListTile(
        leading: Icon(icon, color: accentColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: trailingText != null ? Text(trailingText, style: const TextStyle(fontWeight: FontWeight.w700, color: NexoColors.textMuted)) : const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      ),
    );
  }

  Widget _buildToggleOption(BuildContext context, IconData icon, String title, Color accentColor, bool value, ValueChanged<bool> onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: NexoColors.white, borderRadius: NexoShapes.medium, border: Border.all(color: NexoColors.divider)),
      child: SwitchListTile(
        secondary: Icon(icon, color: accentColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        value: value,
        onChanged: onChanged,
        activeColor: NexoColors.primaryDark,
      ),
    );
  }

  Widget _buildThemeOption(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);
    String label = themeMode == ThemeMode.dark ? 'Oscuro' : (themeMode == ThemeMode.light ? 'Claro' : 'Sistema');
    return _buildOption(context, Icons.palette_outlined, 'Tema de la App', NexoColors.primaryDark, trailingText: label, onTap: () {
      showDialog(context: context, builder: (context) => AlertDialog(
        title: const Text('Tema de la App'),
        shape: RoundedRectangleBorder(borderRadius: NexoShapes.medium),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(title: const Text('Sistema'), onTap: () { ref.read(themeControllerProvider.notifier).setThemeMode(ThemeMode.system); Navigator.pop(context); }),
            ListTile(title: const Text('Claro'), onTap: () { ref.read(themeControllerProvider.notifier).setThemeMode(ThemeMode.light); Navigator.pop(context); }),
            ListTile(title: const Text('Oscuro'), onTap: () { ref.read(themeControllerProvider.notifier).setThemeMode(ThemeMode.dark); Navigator.pop(context); }),
          ],
        ),
      ));
    });
  }

  void _showAbout(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Nexo',
      applicationIcon: Image.asset('assets/images/logo.png', width: 40),
      applicationVersion: '3.5.0',
      applicationLegalese: '© 2026 Nexo Ecosystem',
    );
  }
}
