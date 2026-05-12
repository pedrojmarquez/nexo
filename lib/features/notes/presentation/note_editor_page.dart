import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';
import 'package:nexo/core/theme/app_colors.dart';
import 'package:nexo/core/theme/app_shapes.dart';
import 'package:nexo/core/theme/background_patterns.dart';
import 'package:nexo/features/notes/domain/note_model.dart';
import 'package:nexo/features/notes/presentation/providers/notes_provider.dart';
import 'package:nexo/features/notes/presentation/widgets/note_ai_assistant.dart';

class NoteEditorPage extends ConsumerStatefulWidget {
  final NexoNote? note;
  const NoteEditorPage({super.key, this.note});

  @override
  ConsumerState<NoteEditorPage> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends ConsumerState<NoteEditorPage> {
  late QuillController _controller;
  late TextEditingController _titleController;
  final FocusNode _editorFocusNode = FocusNode();
  final FocusNode _titleFocusNode = FocusNode();
  bool _isPinned = false;
  String? _backgroundPattern;
  bool _showBackgroundPicker = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _isPinned = widget.note?.isPinned ?? false;
    _backgroundPattern = widget.note?.backgroundPattern;

    if (widget.note?.richContent != null) {
      try {
        final doc = Document.fromJson(jsonDecode(widget.note!.richContent!));
        _controller = QuillController(document: doc, selection: const TextSelection.collapsed(offset: 0));
      } catch (e) {
        _controller = QuillController.basic();
      }
    } else {
      _controller = QuillController.basic();
      if (widget.note?.content != null) {
        _controller.document.insert(0, widget.note!.content!);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _titleController.dispose();
    _editorFocusNode.dispose();
    _titleFocusNode.dispose();
    super.dispose();
  }

  void _deleteNote() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar nota?'),
        content: const Text('Esta nota se moverá a la papelera.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('CANCELAR')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: NexoColors.error),
            child: const Text('ELIMINAR'),
          ),
        ],
      ),
    );

    if (confirmed == true && widget.note != null) {
      ref.read(notesControllerProvider.notifier).deleteNote(widget.note!.id);
      if (mounted) context.pop();
    }
  }

  void _saveNote() {
    final title = _titleController.text.trim();
    final plainText = _controller.document.toPlainText().trim();
    final richContent = jsonEncode(_controller.document.toDelta().toJson());

    if (title.isEmpty && plainText.isEmpty) {
      context.pop();
      return;
    }

    if (widget.note != null) {
      ref.read(notesControllerProvider.notifier).updateNote(
        widget.note!.copyWith(
          title: title.isEmpty ? 'Sin título' : title,
          content: plainText,
          richContent: richContent,
          isPinned: _isPinned,
          backgroundPattern: _backgroundPattern,
          updatedAt: DateTime.now(),
        ),
      );
    } else {
      ref.read(notesControllerProvider.notifier).createTextNote(
        title.isEmpty ? 'Sin título' : title,
        plainText,
        richContent: richContent,
        isPinned: _isPinned,
      );
    }
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final bgPainter = NoteBackgrounds.getPainter(_backgroundPattern);
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: NexoColors.white,
      appBar: AppBar(
        backgroundColor: NexoColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: NexoColors.textMain),
          onPressed: _saveNote,
        ),
        title: const Text('Editor', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        actions: [
          if (widget.note != null)
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded, color: NexoColors.error),
              onPressed: _deleteNote,
            ),
          IconButton(
            icon: Icon(Icons.palette_outlined, color: _backgroundPattern != null ? NexoColors.primaryDark : NexoColors.textMuted),
            onPressed: () => setState(() => _showBackgroundPicker = !_showBackgroundPicker),
          ),
          IconButton(
            icon: Icon(_isPinned ? Icons.push_pin_rounded : Icons.push_pin_outlined, color: _isPinned ? NexoColors.primaryDark : NexoColors.textMuted),
            onPressed: () => setState(() => _isPinned = !_isPinned),
          ),
          IconButton(
            icon: const Icon(Icons.auto_awesome_rounded, color: NexoColors.primaryDark),
            onPressed: () => NoteAiAssistant.show(context, currentContent: _controller.document.toPlainText(), onApply: (t) {
              setState(() { _controller.document = Document()..insert(0, t); });
            }),
          ),
        ],
      ),
      body: Column(
        children: [
          if (_showBackgroundPicker) _buildBackgroundPicker(),
          Expanded(
            child: CustomPaint(
              painter: bgPainter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      focusNode: _titleFocusNode,
                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: NexoColors.textMain),
                      decoration: const InputDecoration(hintText: 'Título', border: InputBorder.none),
                    ),
                    Expanded(
                      child: QuillEditor.basic(
                        controller: _controller,
                        focusNode: _editorFocusNode,
                        config: const QuillEditorConfig(
                          placeholder: 'Escribe algo...',
                          padding: EdgeInsets.zero,
                          autoFocus: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isKeyboardVisible && _editorFocusNode.hasFocus)
            Container(
              decoration: BoxDecoration(
                color: NexoColors.surface,
                border: Border(top: BorderSide(color: NexoColors.divider.withValues(alpha: 0.5))),
                boxShadow: [
                  if (!isKeyboardVisible)
                    BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, -2))
                ],
              ),
              child: QuillSimpleToolbar(
                controller: _controller,
                config: const QuillSimpleToolbarConfig(
                  showSearchButton: false,
                  showFontFamily: false,
                  showFontSize: false,
                  multiRowsDisplay: false,
                  showSubscript: false,
                  showSuperscript: false,
                  showCodeBlock: false,
                  showInlineCode: false,
                  showLink: true,
                  showUndo: true,
                  showRedo: true,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBackgroundPicker() {
    return Container(
      height: 60,
      color: NexoColors.surface,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: NoteBackgrounds.allPatterns.length,
        itemBuilder: (context, index) {
          final p = NoteBackgrounds.allPatterns[index];
          final isSel = _backgroundPattern == (p == 'blank' ? null : p);
          return GestureDetector(
            onTap: () => setState(() => _backgroundPattern = (p == 'blank' ? null : p)),
            child: Container(
              width: 44, height: 44,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: NexoColors.white,
                borderRadius: NexoShapes.small,
                border: Border.all(color: isSel ? NexoColors.primaryDark : NexoColors.divider, width: isSel ? 2 : 1),
              ),
              child: Icon(NoteBackgrounds.patternIcons[p], size: 18, color: isSel ? NexoColors.primaryDark : NexoColors.textMuted),
            ),
          );
        },
      ),
    );
  }
}
