import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo/core/theme/app_colors.dart';
import 'package:nexo/core/theme/app_shapes.dart';
import 'package:nexo/features/auth/presentation/providers/auth_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangesProvider).valueOrNull;

    return Scaffold(
      backgroundColor: NexoColors.background,
      appBar: AppBar(
        title: const Text('Profile'),
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
                          user?.displayName ?? 'Nexo User',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: NexoColors.textMain,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user?.email ?? 'Setup your account',
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

            _buildSectionTitle('PREFERENCES'),
            const SizedBox(height: 16),
            _buildOption(Icons.notifications_none_rounded, 'Notifications',
                NexoColors.primaryDark),
            _buildOption(
                Icons.palette_outlined, 'App Theme', NexoColors.primaryDark),
            _buildOption(
                Icons.language_rounded, 'Language', NexoColors.primaryDark),

            const SizedBox(height: 32),

            _buildSectionTitle('SYSTEM'),
            const SizedBox(height: 16),
            _buildOption(Icons.help_outline_rounded, 'Help & Support',
                NexoColors.textMuted),
            _buildOption(
                Icons.info_outline_rounded, 'Legal Info', NexoColors.textMuted),

            const SizedBox(height: 48),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () =>
                    ref.read(authControllerProvider.notifier).signOut(),
                icon: const Icon(Icons.logout_rounded, size: 20),
                label: const Text('LOGOUT',
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

  Widget _buildOption(IconData icon, String title, Color accentColor) {
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
        trailing: const Icon(Icons.chevron_right_rounded,
            color: NexoColors.textMuted),
        onTap: () {},
      ),
    );
  }
}
