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

/// ─────────────────────────────────────────────────────────────────────────────
/// NoteEditorPage — Editor rico para notas estándar
/// Toolbar aparece solo cuando el teclado está abierto (encima del teclado)
/// ─────────────────────────────────────────────────────────────────────────────
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
  bool _showToolbar = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _isPinned = widget.note?.isPinned ?? false;
    _backgroundPattern = widget.note?.backgroundPattern;

    if (widget.note?.richContent != null) {
      try {
        final doc = Document.fromJson(jsonDecode(widget.note!.richContent!));
        _controller = QuillController(
            document: doc, selection: const TextSelection.collapsed(offset: 0));
      } catch (e) {
        _controller = QuillController.basic();
      }
    } else if (widget.note?.content != null) {
      _controller = QuillController(
        document: Document()..insert(0, widget.note!.content!),
        selection: const TextSelection.collapsed(offset: 0),
      );
    } else {
      _controller = QuillController.basic();
    }

    // Listener para mostrar/ocultar toolbar según foco
    _editorFocusNode.addListener(_onFocusChanged);
    _titleFocusNode.addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    final hasFocus = _editorFocusNode.hasFocus;
    if (hasFocus != _showToolbar) {
      setState(() => _showToolbar = hasFocus);
    }
  }

  @override
  void dispose() {
    _editorFocusNode.removeListener(_onFocusChanged);
    _titleFocusNode.removeListener(_onFocusChanged);
    _controller.dispose();
    _titleController.dispose();
    _editorFocusNode.dispose();
    _titleFocusNode.dispose();
    super.dispose();
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
              noteSubType: 'text',
              updatedAt: DateTime.now(),
            ),
          );
    } else {
      ref.read(notesControllerProvider.notifier).createTextNote(
            title.isEmpty ? 'Sin título' : title,
            plainText,
            richContent: richContent,
            isPinned: _isPinned,
            noteSubType: 'text',
          );
    }

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final bgPainter = NoteBackgrounds.getPainter(_backgroundPattern);

    return Scaffold(
      backgroundColor: NexoColors.white,
      appBar: AppBar(
        backgroundColor: NexoColors.white,
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_rounded, color: NexoColors.textMain),
          onPressed: _saveNote,
        ),
        title: const Text('Nota',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        actions: [
          // Background picker toggle
          IconButton(
            icon: Icon(
              Icons.palette_outlined,
              color: _backgroundPattern != null
                  ? NexoColors.primaryDark
                  : NexoColors.textMuted,
            ),
            onPressed: () =>
                setState(() => _showBackgroundPicker = !_showBackgroundPicker),
          ),
          // Pin toggle
          IconButton(
            icon: Icon(
              _isPinned ? Icons.push_pin_rounded : Icons.push_pin_outlined,
              color: _isPinned ? NexoColors.primaryDark : NexoColors.textMuted,
              size: 20,
            ),
            onPressed: () => setState(() => _isPinned = !_isPinned),
          ),
          // AI Assistant
          IconButton(
            icon: const Icon(Icons.auto_awesome_rounded,
                color: NexoColors.primaryDark, size: 20),
            onPressed: () {
              NoteAiAssistant.show(
                context,
                currentContent: _controller.document.toPlainText(),
                onApply: (newText) {
                  setState(() {
                    _controller.document = Document()..insert(0, newText);
                  });
                },
              );
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: Column(
        children: [
          // Background pattern picker
          if (_showBackgroundPicker)
            Container(
              height: 60,
              color: NexoColors.surface,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: NoteBackgrounds.allPatterns.length,
                itemBuilder: (context, index) {
                  final pattern = NoteBackgrounds.allPatterns[index];
                  final isSelected = _backgroundPattern ==
                      (pattern == 'blank' ? null : pattern);
                  return GestureDetector(
                    onTap: () => setState(() {
                      _backgroundPattern = pattern == 'blank' ? null : pattern;
                    }),
                    child: Container(
                      width: 44,
                      height: 44,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: NexoColors.white,
                        borderRadius: NexoShapes.small,
                        border: Border.all(
                          color: isSelected
                              ? NexoColors.primaryDark
                              : NexoColors.divider,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Icon(
                        NoteBackgrounds.patternIcons[pattern],
                        size: 18,
                        color: isSelected
                            ? NexoColors.primaryDark
                            : NexoColors.textMuted,
                      ),
                    ),
                  );
                },
              ),
            ),

          // Editor area
          Expanded(
            child: CustomPaint(
              painter: bgPainter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      focusNode: _titleFocusNode,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: NexoColors.textMain,
                        height: 1.3,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Título de la nota',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            color: NexoColors.textMuted,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: QuillEditor.basic(
                        controller: _controller,
                        focusNode: _editorFocusNode,
                        config: const QuillEditorConfig(
                          placeholder: 'Empieza a escribir algo increíble...',
                          padding: EdgeInsets.zero,
                          scrollable: true,
                          autoFocus: false,
                          expands: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Toolbar — solo visible cuando el teclado está abierto
          Visibility(
            visible: _showToolbar,
            maintainState: true,
            maintainAnimation: true,
            maintainSize: false,
            child: Container(
              decoration: BoxDecoration(
                color: NexoColors.surface,
                border: Border(
                    top: BorderSide(
                        color: NexoColors.divider.withValues(alpha: 0.5))),
              ),
              child: QuillSimpleToolbar(
                controller: _controller,
                config: const QuillSimpleToolbarConfig(
                  showSearchButton: false,
                  showFontFamily: false,
                  showFontSize: false,
                  showLink: true,
                  multiRowsDisplay: false,
                  showSubscript: false,
                  showSuperscript: false,
                  showCodeBlock: false,
                  showInlineCode: false,
                  showSmallButton: false,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
