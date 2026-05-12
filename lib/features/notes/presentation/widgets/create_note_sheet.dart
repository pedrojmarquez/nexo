import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo/core/theme/app_colors.dart';
import 'package:nexo/core/theme/app_shapes.dart';
import 'package:nexo/features/notes/presentation/providers/notes_provider.dart';

class CreateNoteSheet extends ConsumerStatefulWidget {
  const CreateNoteSheet({super.key});

  @override
  ConsumerState<CreateNoteSheet> createState() => _CreateNoteSheetState();
}

class _CreateNoteSheetState extends ConsumerState<CreateNoteSheet> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _createNote() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();
    if (content.isEmpty) return;

    ref.read(notesControllerProvider.notifier).createTextNote(
          title.isEmpty ? 'Sin título' : title,
          content,
        );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: NexoColors.surface,
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
                color: NexoColors.divider.withValues(alpha: 0.3),
                borderRadius: NexoShapes.full,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Nueva Nota Rápida',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: NexoColors.textMain,
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _titleController,
            style: const TextStyle(
                color: NexoColors.textMain, fontWeight: FontWeight.w700),
            decoration: InputDecoration(
              hintText: 'Título (opcional)',
              hintStyle: const TextStyle(color: NexoColors.textMuted),
              fillColor: NexoColors.background,
              border: OutlineInputBorder(
                borderRadius: NexoShapes.medium,
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _contentController,
            autofocus: true,
            maxLines: 5,
            style: const TextStyle(color: NexoColors.textMain),
            decoration: InputDecoration(
              hintText: 'Escribe algo...',
              hintStyle: const TextStyle(color: NexoColors.textMuted),
              fillColor: NexoColors.background,
              border: OutlineInputBorder(
                borderRadius: NexoShapes.medium,
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _createNote,
            style: ElevatedButton.styleFrom(
              backgroundColor: NexoColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: NexoShapes.medium),
            ),
            child: const Text(
              'GUARDAR NOTA',
              style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.2),
            ),
          ),
        ],
      ),
    );
  }
}
