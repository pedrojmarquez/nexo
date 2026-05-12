import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo/core/theme/app_colors.dart';
import 'package:nexo/core/theme/app_shapes.dart';
import 'package:nexo/features/fast_input/presentation/providers/fast_input_provider.dart';

class NoteAiAssistant extends ConsumerStatefulWidget {
  final String currentContent;
  final Function(String) onApply;

  const NoteAiAssistant({
    super.key,
    required this.currentContent,
    required this.onApply,
  });

  static Future<void> show(
    BuildContext context, {
    required String currentContent,
    required Function(String) onApply,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => NoteAiAssistant(
        currentContent: currentContent,
        onApply: onApply,
      ),
    );
  }

  @override
  ConsumerState<NoteAiAssistant> createState() => _AddNoteAiAssistantState();
}

class _AddNoteAiAssistantState extends ConsumerState<NoteAiAssistant> {
  final _commandController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  final List<String> _suggestions = [
    'Fix grammar',
    'Make it professional',
    'Summarize key points',
    'Expand information',
  ];

  Future<void> _processCommand(String command) async {
    if (command.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final aiRepo = ref.read(aiRepositoryProvider);
      final result = await aiRepo.getNoteAssistance(
        currentContent: widget.currentContent,
        command: command,
      );

      if (mounted) {
        // Extraemos el texto plano del resultado estructurado
        final plainText =
            result['plain_text'] as String? ?? widget.currentContent;
        widget.onApply(plainText);
        Navigator.pop(context);
      }
    } catch (e) {
      setState(() {
        _error = 'Error with AI. Try again.';
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _commandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: NexoColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: EdgeInsets.fromLTRB(24, 12, 24, viewInsets + 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: NexoColors.surfaceDark,
                borderRadius: NexoShapes.full,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Icon(Icons.auto_awesome_rounded,
                  color: NexoColors.primaryDark),
              const SizedBox(width: 12),
              Text(
                'Nexo AI Assistant',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: NexoColors.textMain,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                _error!,
                style: const TextStyle(color: NexoColors.error, fontSize: 13),
              ),
            ),
          TextField(
            controller: _commandController,
            autofocus: true,
            enabled: !_isLoading,
            decoration: InputDecoration(
              hintText: 'How can I help you with this note?',
              border: OutlineInputBorder(
                borderRadius: NexoShapes.medium,
                borderSide: BorderSide(color: NexoColors.divider),
              ),
              filled: true,
              fillColor: NexoColors.surface,
              suffixIcon: _isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(12),
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: NexoColors.primaryDark),
                    )
                  : IconButton(
                      icon: const Icon(Icons.send_rounded,
                          color: NexoColors.primaryDark),
                      onPressed: () => _processCommand(_commandController.text),
                    ),
            ),
            onSubmitted: _processCommand,
          ),
          const SizedBox(height: 16),
          const Text(
            'SUGGESTIONS',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.0,
              color: NexoColors.textMuted,
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _suggestions
                  .map((s) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ActionChip(
                          label: Text(s),
                          onPressed: _isLoading
                              ? null
                              : () {
                                  _commandController.text = s;
                                  _processCommand(s);
                                },
                          backgroundColor: NexoColors.surface,
                          side: BorderSide.none,
                          labelStyle: const TextStyle(
                              fontSize: 12, color: NexoColors.textMain),
                          shape: RoundedRectangleBorder(
                              borderRadius: NexoShapes.full),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
