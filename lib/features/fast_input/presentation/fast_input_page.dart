import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:nexo/core/theme/app_colors.dart';
import 'package:nexo/core/theme/app_shapes.dart';
import 'package:nexo/features/fast_input/presentation/providers/fast_input_provider.dart';

class FastInputPage extends ConsumerStatefulWidget {
  const FastInputPage({super.key});

  @override
  ConsumerState<FastInputPage> createState() => _FastInputPageState();
}

class _FastInputPageState extends ConsumerState<FastInputPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    _controller.clear();
    await ref
        .read(fastInputControllerProvider.notifier)
        .processAndSaveInput(text);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(fastInputControllerProvider).isLoading;

    return Scaffold(
      backgroundColor: NexoColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.auto_awesome_rounded,
                      size: 64, color: NexoColors.primaryDark)
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(duration: 2.seconds, color: NexoColors.primary)
                  .scale(
                      duration: 1.seconds,
                      begin: const Offset(0.9, 0.9),
                      curve: Curves.easeInOut),
              const SizedBox(height: 32),
              const Text(
                'How can I help you?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: NexoColors.textMain,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Create notes, add meals, or set reminders with a single sentence.',
                textAlign: TextAlign.center,
                style: TextStyle(color: NexoColors.textSub, fontSize: 14),
              ),
              const SizedBox(height: 48),
              Container(
                decoration: BoxDecoration(
                  color: NexoColors.surface,
                  borderRadius: NexoShapes.xLarge,
                  border: Border.all(
                    color: NexoColors.primaryDark
                        .withValues(alpha: isLoading ? 1.0 : 0.2),
                    width: isLoading ? 2 : 1,
                  ),
                ),
                child: TextField(
                  controller: _controller,
                  enabled: !isLoading,
                  autofocus: true,
                  style:
                      const TextStyle(color: NexoColors.textMain, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'e.g. "Add milk to my shopping list"',
                    hintStyle: const TextStyle(color: NexoColors.textMuted),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(20),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send_rounded,
                          color: NexoColors.primaryDark),
                      onPressed: _submit,
                    ),
                  ),
                  onSubmitted: (_) => _submit(),
                ),
              )
                  .animate(target: isLoading ? 1 : 0)
                  .shimmer(duration: 1.seconds, color: NexoColors.primary),
              const SizedBox(height: 24),
              if (isLoading)
                const Center(
                  child: Text(
                    'Nexo is processing your request...',
                    style: TextStyle(
                        color: NexoColors.primaryDark,
                        fontWeight: FontWeight.w600,
                        fontSize: 13),
                  ),
                ).animate().fadeIn(),
            ],
          ),
        ),
      ),
    );
  }
}
