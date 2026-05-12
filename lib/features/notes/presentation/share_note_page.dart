import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo/core/theme/app_colors.dart';
import 'package:nexo/core/theme/app_shapes.dart';
import 'package:nexo/features/notes/domain/note_model.dart';
import 'package:nexo/features/notes/presentation/providers/notes_provider.dart';

class ShareNotePage extends ConsumerStatefulWidget {
  final NexoNote note;
  const ShareNotePage({super.key, required this.note});

  @override
  ConsumerState<ShareNotePage> createState() => _ShareNotePageState();
}

class _ShareNotePageState extends ConsumerState<ShareNotePage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _share() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) return;

    try {
      await ref
          .read(notesControllerProvider.notifier)
          .shareNoteWithUser(widget.note.id, email);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nota compartida con éxito')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NexoColors.background,
      appBar: AppBar(
        title: const Text('Compartir Nota'),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Invita a alguien a colaborar en esta nota. Podrá verla y editarla en tiempo real.',
              style: TextStyle(color: NexoColors.textSub, height: 1.5),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _emailController,
              autofocus: true,
              style: const TextStyle(color: NexoColors.textMain),
              decoration: InputDecoration(
                hintText: 'email@ejemplo.com',
                prefixIcon: const Icon(Icons.email_outlined,
                    color: NexoColors.primaryDark),
                filled: true,
                fillColor: NexoColors.white,
                border: OutlineInputBorder(
                  borderRadius: NexoShapes.medium,
                  borderSide: BorderSide(color: NexoColors.divider),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              onSubmitted: (_) => _share(),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _share,
              style: ElevatedButton.styleFrom(
                backgroundColor: NexoColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: NexoShapes.medium),
              ),
              child: const Text(
                'ENVIAR INVITACIÓN',
                style:
                    TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1.2),
              ),
            ),
            const SizedBox(height: 48),
            const Text(
              'COLABORADORES ACTUALES',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
                color: NexoColors.textMuted,
              ),
            ),
            const SizedBox(height: 16),
            if (widget.note.sharedWith.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('Aún no has compartido esta nota',
                      style:
                          TextStyle(color: NexoColors.textMuted, fontSize: 13)),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: widget.note.sharedWith.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const CircleAvatar(
                        backgroundColor: NexoColors.surface,
                        child: Icon(Icons.person_outline,
                            color: NexoColors.primaryDark),
                      ),
                      title: Text(widget.note.sharedWith[index],
                          style: const TextStyle(
                              color: NexoColors.textMain, fontSize: 14)),
                      subtitle: const Text('Colaborador',
                          style: TextStyle(
                              color: NexoColors.textMuted, fontSize: 12)),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_circle_outline,
                            color: NexoColors.error),
                        onPressed: () {
                          // TODO: Revoke access
                        },
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
