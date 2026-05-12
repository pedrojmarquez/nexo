import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexo/features/notes/domain/note_model.dart';
import 'package:nexo/features/notes/presentation/providers/notes_provider.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// PostItEditorPage — Editor minimalista para post-its rápidos (sin título)
/// ─────────────────────────────────────────────────────────────────────────────
class PostItEditorPage extends ConsumerStatefulWidget {
  final NexoNote? note;

  const PostItEditorPage({super.key, this.note});

  @override
  ConsumerState<PostItEditorPage> createState() => _PostItEditorPageState();
}

class _PostItEditorPageState extends ConsumerState<PostItEditorPage>
    with SingleTickerProviderStateMixin {
  late TextEditingController _contentController;
  late Color _selectedColor;
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  static const _postItColors = [
    Color(0xFFFFF176), // Yellow
    Color(0xFFA5D6A7), // Green
    Color(0xFFEF9A9A), // Pink
    Color(0xFF90CAF9), // Blue
    Color(0xFFFFCC80), // Orange
    Color(0xFFCE93D8), // Purple
    Color(0xFFB2EBF2), // Cyan
    Color(0xFFF8BBD0), // Light Pink
  ];

  @override
  void initState() {
    super.initState();
    _contentController =
        TextEditingController(text: widget.note?.content ?? '');
    _selectedColor = _getInitialColor();

    _animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _animController.forward();
  }

  Color _getInitialColor() {
    if (widget.note?.accentColor != null) {
      try {
        return Color(
            int.parse(widget.note!.accentColor!.replaceFirst('#', '0xFF')));
      } catch (_) {}
    }
    return _postItColors[0];
  }

  String _colorToHex(Color c) {
    final argb = c.toARGB32();
    return '#${argb.toRadixString(16).padLeft(8, '0').substring(2)}';
  }

  @override
  void dispose() {
    _contentController.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _saveAndClose() {
    final content = _contentController.text.trim();

    if (content.isEmpty) {
      context.pop();
      return;
    }

    // Título interno: primeras palabras del contenido (para búsquedas)
    final autoTitle =
        content.length > 30 ? '${content.substring(0, 30)}...' : content;

    if (widget.note != null) {
      ref.read(notesControllerProvider.notifier).updateNote(
            widget.note!.copyWith(
              title: autoTitle,
              content: content,
              accentColor: _colorToHex(_selectedColor),
              noteSubType: 'post_it',
              updatedAt: DateTime.now(),
            ),
          );
    } else {
      ref.read(notesControllerProvider.notifier).createTextNote(
            autoTitle,
            content,
            color: _colorToHex(_selectedColor),
            noteSubType: 'post_it',
          );
    }

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: Scaffold(
        backgroundColor: _selectedColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.black54),
            onPressed: _saveAndClose,
          ),
          title: const Text('Post-it',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
          actions: [
            TextButton(
              onPressed: _saveAndClose,
              child: const Text('Guardar',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w800,
                  )),
            ),
          ],
        ),
        body: Column(
          children: [
            // Color picker
            Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _postItColors.length,
                itemBuilder: (context, index) {
                  final color = _postItColors[index];
                  final isSelected =
                      color.toARGB32() == _selectedColor.toARGB32();
                  return GestureDetector(
                    onTap: () => setState(() => _selectedColor = color),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 36,
                      height: 36,
                      margin: const EdgeInsets.only(right: 10, top: 8),
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? Colors.black38 : Colors.black12,
                          width: isSelected ? 2.5 : 1,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                    color: color.withValues(alpha: 0.5),
                                    blurRadius: 8),
                              ]
                            : null,
                      ),
                      child: isSelected
                          ? const Icon(Icons.check_rounded,
                              size: 16, color: Colors.black45)
                          : null,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Editor (solo contenido, sin título)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: TextField(
                  controller: _contentController,
                  autofocus: widget.note == null,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    height: 1.6,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Escribe tu pensamiento...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.black26),
                  ),
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
