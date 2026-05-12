import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:nexo/core/theme/app_colors.dart';
import 'package:nexo/core/theme/app_shapes.dart';
import 'package:nexo/features/auth/presentation/providers/auth_provider.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: NexoColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo Premium
              const Center(
                child: Icon(Icons.blur_on_rounded,
                    size: 80, color: NexoColors.primaryDark),
              ).animate().scale(duration: 800.ms, curve: Curves.elasticOut),

              const SizedBox(height: 32),

              const Text(
                'NEXO',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: NexoColors.textMain,
                  letterSpacing: 8,
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2),

              const SizedBox(height: 12),

              const Text(
                'Intelligent Personal Ecosystem',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: NexoColors.textSub,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w500,
                ),
              ).animate().fadeIn(delay: 400.ms),

              const SizedBox(height: 80),

              if (authState.isLoading)
                const Center(
                    child: CircularProgressIndicator(
                        color: NexoColors.primaryDark))
              else ...[
                ElevatedButton.icon(
                  onPressed: () => ref
                      .read(authControllerProvider.notifier)
                      .signInWithGoogle(),
                  icon: const Icon(Icons.login_rounded, size: 20),
                  label: const Text(
                    'CONTINUE WITH GOOGLE',
                    style: TextStyle(
                        fontWeight: FontWeight.w900, letterSpacing: 1.0),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: NexoColors.primary,
                    foregroundColor: NexoColors.textMain,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape:
                        RoundedRectangleBorder(borderRadius: NexoShapes.full),
                    elevation: 4,
                    shadowColor: NexoColors.primary.withValues(alpha: 0.2),
                  ),
                ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Terms & Privacy',
                    style: TextStyle(color: NexoColors.textMuted, fontSize: 12),
                  ),
                ).animate().fadeIn(delay: 800.ms),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
