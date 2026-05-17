import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:nexo/core/theme/app_colors.dart';
import 'package:nexo/core/theme/app_shapes.dart';
import 'package:nexo/features/notes/domain/note_model.dart';
import 'package:nexo/features/notes/presentation/providers/notes_provider.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// ShoppingListEditorPage — Editor interactivo de lista de la compra
/// ─────────────────────────────────────────────────────────────────────────────
class ShoppingListEditorPage extends ConsumerStatefulWidget {
  final NexoNote? note;

  const ShoppingListEditorPage({super.key, this.note});

  @override
  ConsumerState<ShoppingListEditorPage> createState() =>
      _ShoppingListEditorPageState();
}

class _ShoppingListEditorPageState
    extends ConsumerState<ShoppingListEditorPage> {
  late TextEditingController _titleController;
  final TextEditingController _addItemController = TextEditingController();
  final FocusNode _addItemFocus = FocusNode();
  late List<NoteItem> _items;
  bool _isPrimary = false;
  final _uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: widget.note?.title ?? 'Lista de la compra');
    _items = List.from(widget.note?.items ?? []);
    _isPrimary = widget.note?.isPrimaryShoppingList ?? false;
    _sortItems();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _addItemController.dispose();
    _addItemFocus.dispose();
    super.dispose();
  }

  void _sortItems() {
    _items.sort((a, b) {
      if (a.isChecked && !b.isChecked) return 1;
      if (!a.isChecked && b.isChecked) return -1;
      return a.order.compareTo(b.order);
    });
  }

  void _addItem() {
    final text = _addItemController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _items.add(NoteItem(
        id: _uuid.v4(),
        text: text,
        isChecked: false,
        order: _items.length,
      ));
      _addItemController.clear();
      _sortItems();
    });

    _addItemFocus.requestFocus();
    _autoSave();
  }

  void _toggleItem(int index) {
    setState(() {
      final item = _items[index];
      _items[index] = item.copyWith(isChecked: !item.isChecked);
      _sortItems();
    });
    _autoSave();
  }

  void _deleteItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
    _autoSave();
  }

  void _autoSave() {
    if (widget.note != null) {
      ref.read(notesControllerProvider.notifier).updateNote(
            widget.note!.copyWith(
              title: _titleController.text.trim().isEmpty
                  ? 'Lista de la compra'
                  : _titleController.text.trim(),
              items: _items,
              type: NoteType.list,
              isPrimaryShoppingList: _isPrimary,
              noteSubType: _isPrimary ? 'shopping_principal' : 'list',
              updatedAt: DateTime.now(),
            ),
          );
    }
  }

  void _saveAndClose() {
    final title = _titleController.text.trim();

    if (widget.note == null) {
      if (_items.isEmpty) {
        context.pop();
        return;
      }
      ref.read(notesControllerProvider.notifier).createListNote(
            title.isEmpty ? 'Lista de la compra' : title,
            _items,
            isPrimary: _isPrimary,
          );
    } else {
      _autoSave();
    }

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final checked = _items.where((i) => i.isChecked).length;
    final total = _items.length;

    return Scaffold(
      backgroundColor: NexoColors.white,
      appBar: AppBar(
        backgroundColor: NexoColors.white,
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_rounded, color: NexoColors.textMain),
          onPressed: _saveAndClose,
        ),
        title: SizedBox(
          height: 36,
          child: TextField(
            controller: _titleController,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: NexoColors.textMain),
            decoration: const InputDecoration(
              hintText: 'Nombre de la lista',
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              isDense: true,
            ),
            onChanged: (_) => _autoSave(),
          ),
        ),
        actions: [
          // Borrar lista
          if (widget.note != null)
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded, color: NexoColors.error),
              onPressed: () async {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('¿Eliminar lista?'),
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
                if (confirmed == true) {
                  ref.read(notesControllerProvider.notifier).deleteNote(widget.note!.id);
                  if (mounted) context.pop();
                }
              },
            ),
          // Primary list toggle
          IconButton(
            icon: Icon(
              _isPrimary ? Icons.star_rounded : Icons.star_outline_rounded,
              color:
                  _isPrimary ? const Color(0xFFFACC15) : NexoColors.textMuted,
              size: 24,
            ),
            tooltip:
                _isPrimary ? 'Lista principal' : 'Establecer como principal',
            onPressed: () {
              setState(() => _isPrimary = !_isPrimary);
              if (_isPrimary && widget.note != null) {
                ref
                    .read(notesControllerProvider.notifier)
                    .setPrimaryShoppingList(widget.note!.id);
              }
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              // Progress header
              if (total > 0)
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 4, 24, 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: NexoShapes.full,
                          child: LinearProgressIndicator(
                            value: total > 0 ? checked / total : 0,
                            backgroundColor: NexoColors.surface,
                            valueColor:
                                const AlwaysStoppedAnimation(NexoColors.success),
                            minHeight: 6,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '$checked/$total',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: NexoColors.textSub,
                        ),
                      ),
                    ],
                  ),
                ),

              // Items list
              Expanded(
                child: _items.isEmpty
                    ? _buildEmptyState()
                    : ReorderableListView.builder(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 100),
                        itemCount: _items.length,
                        onReorder: (oldIndex, newIndex) {
                          setState(() {
                            if (newIndex > oldIndex) newIndex--;
                            final item = _items.removeAt(oldIndex);
                            _items.insert(newIndex, item);
                            for (int i = 0; i < _items.length; i++) {
                              _items[i] = _items[i].copyWith(order: i);
                            }
                          });
                          _autoSave();
                        },
                        itemBuilder: (context, index) {
                          final item = _items[index];
                          return Dismissible(
                            key: ValueKey(item.id),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 24),
                              margin: const EdgeInsets.symmetric(vertical: 2),
                              decoration: BoxDecoration(
                                color: NexoColors.error.withValues(alpha: 0.1),
                                borderRadius: NexoShapes.small,
                              ),
                              child: const Icon(Icons.delete_outline_rounded,
                                  color: NexoColors.error),
                            ),
                            onDismissed: (_) => _deleteItem(index),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 8),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () => _toggleItem(index),
                                  borderRadius: NexoShapes.small,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 12),
                                    child: Row(
                                      children: [
                                        AnimatedSwitcher(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          child: Icon(
                                            item.isChecked
                                                ? Icons.check_circle_rounded
                                                : Icons
                                                    .radio_button_unchecked_rounded,
                                            key: ValueKey(item.isChecked),
                                            color: item.isChecked
                                                ? NexoColors.success
                                                : NexoColors.textMuted,
                                            size: 22,
                                          ),
                                        ),
                                        const SizedBox(width: 14),
                                        Expanded(
                                          child: Text(
                                            item.text,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: item.isChecked
                                                  ? NexoColors.textMuted
                                                  : NexoColors.textMain,
                                              decoration: item.isChecked
                                                  ? TextDecoration.lineThrough
                                                  : null,
                                              fontWeight: item.isChecked
                                                  ? FontWeight.w400
                                                  : FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        const Icon(Icons.drag_handle_rounded,
                                            size: 18,
                                            color: NexoColors.surfaceDark),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                              .animate(key: ValueKey(item.id))
                              .fadeIn(duration: 200.ms);
                        },
                      ),
              ),

              // Add item bar (siempre visible)
              Container(
                padding: const EdgeInsets.fromLTRB(16, 8, 8, 20),
                decoration: BoxDecoration(
                  color: NexoColors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 4,
                        offset: const Offset(0, -2))
                  ],
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(Icons.add_rounded,
                          color: NexoColors.success, size: 28),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _addItemController,
                        focusNode: _addItemFocus,
                        style: const TextStyle(fontSize: 16),
                        decoration: const InputDecoration(
                          hintText: 'Añadir artículo...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          isDense: true,
                          hintStyle: TextStyle(color: NexoColors.textMuted),
                        ),
                        onSubmitted: (_) => _addItem(),
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    IconButton(
                      onPressed: _addItem,
                      icon: const Icon(Icons.send_rounded,
                          color: NexoColors.success, size: 22),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_bag_outlined,
                  size: 64, color: NexoColors.surfaceDark)
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.05, 1.05),
                  duration: 2.seconds),
          const SizedBox(height: 16),
          const Text('Lista vacía',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: NexoColors.textMain)),
          const SizedBox(height: 6),
          const Text('Añade tu primer artículo abajo',
              style: TextStyle(fontSize: 13, color: NexoColors.textMuted)),
        ],
      ),
    );
  }
}
