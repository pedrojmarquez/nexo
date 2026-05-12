import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo/core/theme/app_colors.dart';
import 'package:nexo/core/theme/app_shapes.dart';
import 'package:nexo/features/auth/presentation/providers/auth_provider.dart';
import 'package:nexo/core/theme/theme_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangesProvider).valueOrNull;

    return Scaffold(
      backgroundColor: NexoColors.background,
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // User Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: NexoColors.white,
                borderRadius: NexoShapes.xLarge,
                border: Border.all(color: NexoColors.divider),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: NexoColors.surface,
                    backgroundImage: user?.photoURL != null
                        ? NetworkImage(user!.photoURL!)
                        : null,
                    child: user?.photoURL == null
                        ? const Icon(Icons.person_rounded,
                            size: 40, color: NexoColors.textMuted)
                        : null,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.displayName ?? 'Usuario Nexo',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: NexoColors.textMain,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user?.email ?? 'Configura tu cuenta',
                          style: const TextStyle(
                              color: NexoColors.textMuted, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            _buildSectionTitle('PREFERENCIAS'),
            const SizedBox(height: 16),
            _buildOption(
              context,
              Icons.notifications_none_rounded,
              'Notificaciones',
              NexoColors.primaryDark,
              onTap: () => _showNotImplemented(context),
            ),
            _buildThemeOption(context, ref),
            _buildOption(
              context,
              Icons.language_rounded,
              'Idioma',
              NexoColors.primaryDark,
              trailingText: 'Español',
              onTap: () => _showLanguageDialog(context),
            ),

            const SizedBox(height: 32),

            _buildSectionTitle('SISTEMA'),
            const SizedBox(height: 16),
            _buildOption(
              context,
              Icons.help_outline_rounded,
              'Ayuda y Soporte',
              NexoColors.textMuted,
              onTap: () => _showNotImplemented(context),
            ),
            _buildOption(
              context,
              Icons.info_outline_rounded,
              'Info Legal',
              NexoColors.textMuted,
              onTap: () => _showLegalInfo(context),
            ),

            const SizedBox(height: 48),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () =>
                    ref.read(authControllerProvider.notifier).signOut(),
                icon: const Icon(Icons.logout_rounded, size: 20),
                label: const Text('CERRAR SESIÓN',
                    style: TextStyle(
                        fontWeight: FontWeight.w800, letterSpacing: 1.2)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: NexoColors.error,
                  side: const BorderSide(color: NexoColors.error, width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape:
                      RoundedRectangleBorder(borderRadius: NexoShapes.medium),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w900,
          letterSpacing: 2.0,
          color: NexoColors.textMuted,
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context, IconData icon, String title, Color accentColor,
      {String? trailingText, VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: NexoColors.white,
        borderRadius: NexoShapes.medium,
        border: Border.all(color: NexoColors.divider),
      ),
      child: ListTile(
        leading: Icon(icon, color: accentColor, size: 22),
        title: Text(title,
            style: const TextStyle(
                color: NexoColors.textMain,
                fontSize: 15,
                fontWeight: FontWeight.w500)),
        trailing: trailingText != null
            ? Text(trailingText,
                style: const TextStyle(
                    color: NexoColors.textMuted,
                    fontSize: 14,
                    fontWeight: FontWeight.w600))
            : const Icon(Icons.chevron_right_rounded,
                color: NexoColors.textMuted),
        onTap: onTap,
      ),
    );
  }

  Widget _buildThemeOption(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);
    String themeLabel = 'Sistema';
    if (themeMode == ThemeMode.light) themeLabel = 'Claro';
    if (themeMode == ThemeMode.dark) themeLabel = 'Oscuro';

    return _buildOption(
      context,
      Icons.palette_outlined,
      'Tema de la App',
      NexoColors.primaryDark,
      trailingText: themeLabel,
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Tema de la App'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<ThemeMode>(
                  title: const Text('Sistema'),
                  value: ThemeMode.system,
                  groupValue: themeMode,
                  onChanged: (val) {
                    ref.read(themeControllerProvider.notifier).setThemeMode(val!);
                    Navigator.pop(context);
                  },
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('Claro'),
                  value: ThemeMode.light,
                  groupValue: themeMode,
                  onChanged: (val) {
                    ref.read(themeControllerProvider.notifier).setThemeMode(val!);
                    Navigator.pop(context);
                  },
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('Oscuro'),
                  value: ThemeMode.dark,
                  groupValue: themeMode,
                  onChanged: (val) {
                    ref.read(themeControllerProvider.notifier).setThemeMode(val!);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Idioma'),
        content: const Text(
            'Actualmente Nexo está configurado íntegramente en Español. El soporte multilingüe completo se añadirá en futuras actualizaciones.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }

  void _showLegalInfo(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Nexo',
      applicationVersion: '3.0.0 (Build 15)',
      applicationIcon: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: NexoColors.primary,
          borderRadius: NexoShapes.small,
        ),
        child: const Icon(Icons.dashboard_rounded, color: NexoColors.textMain),
      ),
      applicationLegalese: '© 2026 Nexo Ecosystem.\nTodos los derechos reservados.',
    );
  }

  void _showNotImplemented(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Esta función estará disponible próximamente.')),
    );
  }
}
