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
      backgroundColor: NexoColors.background,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              NexoColors.primary.withValues(alpha: 0.1),
              NexoColors.background,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                const Spacer(),
                // Logo con sombra y presencia
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: NexoColors.primary.withValues(alpha: 0.2),
                          blurRadius: 40,
                          spreadRadius: 10,
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: NexoShapes.xLarge,
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 140,
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ).animate().scale(duration: 1.seconds, curve: Curves.elasticOut).fadeIn(),

                const SizedBox(height: 32),

                const Text(
                  'NEXO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w900,
                    color: NexoColors.textMain,
                    letterSpacing: 12,
                  ),
                ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2),

                const Text(
                  'Tu Ecosistema Inteligente',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: NexoColors.textSub,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ).animate().fadeIn(delay: 500.ms),

                const Spacer(),

                if (authState.isLoading)
                  const Center(child: CircularProgressIndicator(color: NexoColors.primaryDark))
                else ...[
                  ElevatedButton.icon(
                    onPressed: () => ref.read(authControllerProvider.notifier).signInWithGoogle(),
                    icon: Image.network('https://upload.wikimedia.org/wikipedia/commons/c/c1/Google_%22G%22_logo.svg', width: 20, height: 20, errorBuilder: (_, __, ___) => const Icon(Icons.login_rounded)),
                    label: const Text(
                      'ENTRAR CON GOOGLE',
                      style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.5),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: NexoColors.white,
                      foregroundColor: NexoColors.textMain,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: NexoShapes.medium,
                        side: const BorderSide(color: NexoColors.divider),
                      ),
                      elevation: 4,
                    ),
                  ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.3),
                  
                  const SizedBox(height: 24),
                  
                  const Text(
                    'Gestión de notas, comidas y recordatorios\ntodo en un solo lugar.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: NexoColors.textMuted, fontSize: 12, height: 1.5),
                  ).animate().fadeIn(delay: 900.ms),
                ],
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      );
  }
}
