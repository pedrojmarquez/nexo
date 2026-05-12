import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexo/core/theme/app_colors.dart';
import 'package:nexo/features/notes/domain/note_model.dart';
import 'package:nexo/features/notes/presentation/providers/notes_provider.dart';

class NoteDetailPage extends ConsumerStatefulWidget {
  final NexoNote note;

  const NoteDetailPage({super.key, required this.note});

  @override
  ConsumerState<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends ConsumerState<NoteDetailPage> {
  late NexoNote _currentNote;

  @override
  void initState() {
    super.initState();
    _currentNote = widget.note;
  }

  void _toggleItem(int index) {
    final newItems = List<NoteItem>.from(_currentNote.items);
    final item = newItems[index];
    newItems[index] = item.copyWith(isChecked: !item.isChecked);

    setState(() {
      _currentNote = _currentNote.copyWith(items: newItems);
    });

    ref.read(notesControllerProvider.notifier).updateNote(_currentNote);
  }

  void _deleteNote() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar nota'),
        content: const Text('¿Estás seguro de que deseas eliminar esta nota?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: NexoColors.error),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      ref.read(notesControllerProvider.notifier).deleteNote(_currentNote.id);
      context.pop(); // Go back
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color accentColor = _currentNote.accentColor != null
        ? Color(int.parse(_currentNote.accentColor!.replaceFirst('#', '0xFF')))
        : Theme.of(context).colorScheme.primaryContainer;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: accentColor.withOpacity(0.1),
        title: Text(_currentNote.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: NexoColors.error),
            onPressed: _deleteNote,
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              color: accentColor.withOpacity(0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_currentNote.isAiEnhanced)
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.auto_awesome,
                              size: 14, color: accentColor),
                          const SizedBox(width: 4),
                          Text(
                            'IA Generada',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: accentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Text(
                    _currentNote.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
          if (_currentNote.type == NoteType.text &&
              _currentNote.content != null)
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  _currentNote.content!,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          if (_currentNote.type == NoteType.list &&
              _currentNote.items.isNotEmpty)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = _currentNote.items[index];
                  return CheckboxListTile(
                    title: Text(
                      item.text,
                      style: TextStyle(
                        decoration:
                            item.isChecked ? TextDecoration.lineThrough : null,
                        color: item.isChecked
                            ? Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.5)
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    value: item.isChecked,
                    onChanged: (_) => _toggleItem(index),
                    activeColor: accentColor,
                    controlAffinity: ListTileControlAffinity.leading,
                  );
                },
                childCount: _currentNote.items.length,
              ),
            ),
        ],
      ),
    );
  }
}
