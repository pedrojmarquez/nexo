import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:nexo/core/theme/app_colors.dart';
import 'package:nexo/core/theme/app_shapes.dart';
import 'package:nexo/features/auth/presentation/providers/auth_provider.dart';
import 'package:nexo/features/notes/domain/note_model.dart';
import 'package:nexo/features/notes/presentation/providers/notes_provider.dart';
import 'package:nexo/features/notes/presentation/widgets/note_card.dart';
import 'package:nexo/features/notes/presentation/widgets/note_type_selector.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// NotesPage — Tablón tipo board con MasonryGrid
/// ─────────────────────────────────────────────────────────────────────────────
class NotesPage extends ConsumerStatefulWidget {
  const NotesPage({super.key});

  @override
  ConsumerState<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends ConsumerState<NotesPage> {
  String _searchQuery = '';
  bool _isSearching = false;
  String _activeFilter = 'all'; // all, text, post_it, shopping_principal
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notesAsync = ref.watch(userNotesProvider);

    return Scaffold(
      backgroundColor: NexoColors.background,
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                autofocus: true,
                style:
                    const TextStyle(fontSize: 16, color: NexoColors.textMain),
                decoration: const InputDecoration(
                  hintText: 'Buscar notas...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: NexoColors.textMuted),
                ),
                onChanged: (val) => setState(() => _searchQuery = val),
              )
            : const Text('Nexo'),
        centerTitle: false,
        actions: [
          IconButton(
            icon:
                Icon(_isSearching ? Icons.close_rounded : Icons.search_rounded),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchQuery = '';
                  _searchController.clear();
                }
              });
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: notesAsync.when(
        data: (notes) {
          // Filtrar por búsqueda
          var filteredNotes = notes.toList();
          if (_searchQuery.isNotEmpty) {
            filteredNotes = filteredNotes
                .where((n) =>
                    n.title
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase()) ||
                    (n.content ?? '')
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase()))
                .toList();
          }

          // Filtrar por tipo
          if (_activeFilter != 'all') {
            filteredNotes = filteredNotes.where((n) {
              switch (_activeFilter) {
                case 'text':
                  return n.noteSubType == 'text' || n.noteSubType == null;
                case 'post_it':
                  return n.noteSubType == 'post_it';
                case 'shopping':
                  return n.noteSubType == 'shopping_principal' ||
                      n.noteSubType == 'list';
                default:
                  return true;
              }
            }).toList();
          }

          // Ordenar: pinned primero, luego por fecha
          filteredNotes.sort((a, b) {
            if (a.isPinned && !b.isPinned) return -1;
            if (!a.isPinned && b.isPinned) return 1;
            final dateA = a.updatedAt ?? a.createdAt ?? DateTime(2000);
            final dateB = b.updatedAt ?? b.createdAt ?? DateTime(2000);
            return dateB.compareTo(dateA);
          });

          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Column(
                children: [
                  // Filter chips
                  _buildFilterChips(),

                  // Notes grid
                  Expanded(
                    child: filteredNotes.isEmpty
                        ? _buildEmptyState()
                        : LayoutBuilder(
                            builder: (context, constraints) {
                              final crossAxisCount = constraints.maxWidth > 900
                                  ? 4
                                  : (constraints.maxWidth > 600 ? 3 : 2);
                              return MasonryGridView.count(
                                crossAxisCount: crossAxisCount,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                                itemCount: filteredNotes.length,
                                itemBuilder: (context, index) {
                                  final note = filteredNotes[index];
                                  return NoteCard(
                                    key: ValueKey(note.id),
                                    note: note,
                                    onTap: () => _openNote(note),
                                    onLongPress: () => _showContextMenu(context, note),
                                  ).animate().fadeIn(delay: (index * 40).ms).scale(
                                        begin: const Offset(0.95, 0.95),
                                        duration: 300.ms,
                                        curve: Curves.easeOut,
                                      );
                                },
                              );
                    },
                  ),
          ),
                ],
              ),
            ),
          ),
        );
      },
        loading: () => const Center(
          child: CircularProgressIndicator(color: NexoColors.primaryDark),
        ),
        error: (e, _) => Center(
          child: Text('Error: $e',
              style: const TextStyle(color: NexoColors.error)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => NoteTypeSelector.show(context),
        backgroundColor: NexoColors.primary,
        child:
            const Icon(Icons.add_rounded, color: NexoColors.textMain, size: 32),
      ).animate().scale(delay: 300.ms, curve: Curves.elasticOut),
    );
  }

  Widget _buildFilterChips() {
    final filters = [
      {'key': 'all', 'label': 'Todas', 'icon': Icons.dashboard_rounded},
      {'key': 'text', 'label': 'Notas', 'icon': Icons.edit_note_rounded},
      {
        'key': 'post_it',
        'label': 'Post-its',
        'icon': Icons.sticky_note_2_rounded
      },
      {'key': 'shopping', 'label': 'Listas', 'icon': Icons.checklist_rounded},
    ];

    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = _activeFilter == filter['key'];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              selected: isSelected,
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    filter['icon'] as IconData,
                    size: 14,
                    color:
                        isSelected ? NexoColors.textMain : NexoColors.textMuted,
                  ),
                  const SizedBox(width: 6),
                  Text(filter['label'] as String),
                ],
              ),
              labelStyle: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? NexoColors.textMain : NexoColors.textSub,
              ),
              backgroundColor: NexoColors.surface,
              selectedColor: NexoColors.primary.withValues(alpha: 0.25),
              checkmarkColor: NexoColors.textMain,
              showCheckmark: false,
              shape: RoundedRectangleBorder(
                borderRadius: NexoShapes.full,
                side: BorderSide(
                  color: isSelected
                      ? NexoColors.primaryDark.withValues(alpha: 0.3)
                      : NexoColors.divider,
                ),
              ),
              onSelected: (_) =>
                  setState(() => _activeFilter = filter['key'] as String),
            ),
          );
        },
      ),
    );
  }

  void _openNote(NexoNote note) {
    switch (note.noteSubType) {
      case 'post_it':
        context.push('/notas/postit', extra: note);
        break;
      case 'shopping_principal':
        context.push('/notas/lista', extra: note);
        break;
      default:
        context.push('/notas/detalle', extra: note);
    }
  }

  void _showContextMenu(BuildContext context, NexoNote note) {
    final currentUser = ref.read(authStateChangesProvider).valueOrNull;
    final isOwner = currentUser != null && note.ownerUid == currentUser.uid;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: NexoColors.white,
          borderRadius: NexoShapes.bottomSheet,
        ),
        padding: const EdgeInsets.fromLTRB(8, 12, 8, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                  color: NexoColors.surfaceDark, borderRadius: NexoShapes.full),
            ),
            ListTile(
              leading: Icon(
                note.isPinned
                    ? Icons.push_pin_outlined
                    : Icons.push_pin_rounded,
                color: NexoColors.primaryDark,
              ),
              title: Text(note.isPinned ? 'Desfijar' : 'Fijar arriba'),
              onTap: () {
                Navigator.pop(context);
                ref.read(notesControllerProvider.notifier).updateNote(
                      note.copyWith(isPinned: !note.isPinned),
                    );
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.share_rounded, color: NexoColors.textSub),
              title: const Text('Compartir'),
              onTap: () {
                Navigator.pop(context);
                context.push('/notas/compartir', extra: note);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline_rounded,
                  color: NexoColors.error),
              title: Text(
                isOwner ? 'Eliminar' : 'Dejar de ver',
                style: const TextStyle(color: NexoColors.error),
              ),
              onTap: () {
                Navigator.pop(context);
                _confirmDelete(context, note, isOwner);
              },
              ],
            );
          },
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, NexoNote note, bool isOwner) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isOwner ? '¿Eliminar nota?' : '¿Dejar de ver esta nota?'),
        content: Text(isOwner
            ? 'Esta acción no se puede deshacer.'
            : 'Dejarás de ver esta nota compartida. El dueño la conservará.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              final id = note.id;
              Navigator.pop(context);
              await ref.read(notesControllerProvider.notifier).deleteNote(id);
            },
            style: TextButton.styleFrom(foregroundColor: NexoColors.error),
            child: Text(isOwner ? 'Eliminar' : 'Dejar de ver'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.dashboard_customize_rounded,
                  size: 72, color: NexoColors.surfaceDark)
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.05, 1.05),
                  duration: 2.seconds),
          const SizedBox(height: 20),
          const Text('Tu tablón está vacío',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: NexoColors.textMain)),
          const SizedBox(height: 8),
          const Text('Pulsa + para crear tu primera nota',
              style: TextStyle(fontSize: 14, color: NexoColors.textMuted)),
        ],
      ),
    );
  }
}
