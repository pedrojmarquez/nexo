import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexo/core/theme/app_colors.dart';
import 'package:nexo/core/theme/app_shapes.dart';
import 'package:nexo/features/notes/domain/note_model.dart';
import 'package:nexo/features/notes/presentation/providers/notes_provider.dart';

class PostItEditorPage extends ConsumerStatefulWidget {
  final NexoNote? note;
  const PostItEditorPage({super.key, this.note});

  @override
  ConsumerState<PostItEditorPage> createState() => _PostItEditorPageState();
}

class _PostItEditorPageState extends ConsumerState<PostItEditorPage> with SingleTickerProviderStateMixin {
  late TextEditingController _contentController;
  late Color _selectedColor;
  DateTime? _scheduledDate;
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  static const _postItColors = [
    Color(0xFFFFF176), Color(0xFFA5D6A7), Color(0xFFEF9A9A), Color(0xFF90CAF9),
    Color(0xFFFFCC80), Color(0xFFCE93D8), Color(0xFFB2EBF2), Color(0xFFF8BBD0),
  ];

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.note?.content ?? '');
    _selectedColor = _getInitialColor();
    _scheduledDate = widget.note?.scheduledDate ?? 
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1, 8, 0);
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _animController.forward();
  }

  Color _getInitialColor() {
    if (widget.note?.accentColor != null) {
      try { return Color(int.parse(widget.note!.accentColor!.replaceFirst('#', '0xFF'))); } catch (_) {}
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

  void _deleteNote() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar Post-it?'),
        content: const Text('Esta acción no se puede deshacer.'),
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

  void _saveAndClose() {
    final content = _contentController.text.trim();
    if (content.isEmpty) { context.pop(); return; }

    final autoTitle = content.length > 30 ? '${content.substring(0, 30)}...' : content;

    if (widget.note != null) {
      ref.read(notesControllerProvider.notifier).updateNote(
        widget.note!.copyWith(
          title: autoTitle,
          content: content,
          accentColor: _colorToHex(_selectedColor),
          noteSubType: 'post_it',
          scheduledDate: _scheduledDate,
          updatedAt: DateTime.now(),
        ),
      );
    } else {
      ref.read(notesControllerProvider.notifier).createTextNote(
        autoTitle, content,
        color: _colorToHex(_selectedColor),
        noteSubType: 'post_it',
        scheduledDate: _scheduledDate,
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
          leading: IconButton(icon: const Icon(Icons.arrow_back_rounded, color: Colors.black54), onPressed: _saveAndClose),
          title: const Text('Post-it', style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w700)),
          actions: [
            if (widget.note != null)
              IconButton(icon: const Icon(Icons.delete_outline_rounded, color: Colors.black54), onPressed: _deleteNote),
            IconButton(
              icon: Icon(_scheduledDate != null ? Icons.notifications_active_rounded : Icons.notification_add_outlined, color: _scheduledDate != null ? Colors.black87 : Colors.black54),
              onPressed: () async {
                final initialDate = _scheduledDate ?? DateTime.now();
                final date = await showDatePicker(
                  context: context, 
                  initialDate: initialDate, 
                  firstDate: DateTime.now().subtract(const Duration(days: 365)), 
                  lastDate: DateTime.now().add(const Duration(days: 365 * 5))
                );
                if (date == null) return;
                
                final initialTime = _scheduledDate != null ? TimeOfDay.fromDateTime(_scheduledDate!) : TimeOfDay.now();
                final time = await showTimePicker(context: context, initialTime: initialTime);
                if (time == null) return;
                
                setState(() => _scheduledDate = DateTime(date.year, date.month, date.day, time.hour, time.minute));
              },
            ),
            TextButton(onPressed: _saveAndClose, child: const Text('GUARDAR', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w900))),
          ],
        ),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                _buildColorPicker(),
                const SizedBox(height: 24),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_scheduledDate != null) _buildReminderBadge(),
                        Expanded(
                          child: TextField(
                            controller: _contentController,
                            autofocus: widget.note == null,
                            style: const TextStyle(fontSize: 19, color: Colors.black87, height: 1.6, fontWeight: FontWeight.w600),
                            decoration: const InputDecoration(hintText: 'Escribe tu pensamiento...', border: InputBorder.none, hintStyle: TextStyle(color: Colors.black26)),
                            maxLines: null, expands: true, textAlignVertical: TextAlignVertical.top,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColorPicker() {
    return Container(
      height: 52,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _postItColors.length,
        itemBuilder: (context, index) {
          final color = _postItColors[index];
          final isSelected = color.toARGB32() == _selectedColor.toARGB32();
          return GestureDetector(
            onTap: () => setState(() => _selectedColor = color),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 36, height: 36, margin: const EdgeInsets.only(right: 10, top: 8),
              decoration: BoxDecoration(color: color, shape: BoxShape.circle, border: Border.all(color: isSelected ? Colors.black38 : Colors.black12, width: isSelected ? 2.5 : 1)),
              child: isSelected ? const Icon(Icons.check_rounded, size: 16, color: Colors.black45) : null,
            ),
          );
        },
      ),
    );
  }

  Widget _buildReminderBadge() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.05), borderRadius: NexoShapes.full),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.alarm_rounded, size: 14, color: Colors.black54),
          const SizedBox(width: 6),
          Text(
            'Recordatorio: ${_scheduledDate!.day}/${_scheduledDate!.month} ${_scheduledDate!.hour.toString().padLeft(2, '0')}:${_scheduledDate!.minute.toString().padLeft(2, '0')}',
            style: const TextStyle(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 4),
          GestureDetector(onTap: () => setState(() => _scheduledDate = null), child: const Icon(Icons.close_rounded, size: 14, color: Colors.black45)),
        ],
      ),
    );
  }
}
