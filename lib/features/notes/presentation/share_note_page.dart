import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo/core/theme/app_colors.dart';
import 'package:nexo/core/theme/app_shapes.dart';
import 'package:nexo/features/notes/domain/note_model.dart';
import 'package:nexo/features/notes/presentation/providers/notes_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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

  void _shareWithEmail() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) return;

    try {
      await ref.read(notesControllerProvider.notifier).shareNoteWithUser(widget.note.id, email);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invitación enviada correctamente')));
        _emailController.clear();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}'), backgroundColor: NexoColors.error));
      }
    }
  }

  void _shareViaWhatsApp() async {
    final text = '¡Hola! Te invito a colaborar en mi nota de Nexo: "${widget.note.title}"\n\nSi tienes la app instalada, puedes verla aquí: nexo://notes/view?id=${widget.note.id}';
    final url = Uri.parse('whatsapp://send?text=${Uri.encodeComponent(text)}');
    
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        await Share.share(text);
      }
    } catch (e) {
      await Share.share(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NexoColors.background,
      appBar: AppBar(
        title: const Text('Compartir'),
        leading: IconButton(icon: const Icon(Icons.close_rounded), onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildShareCard(),
            const SizedBox(height: 32),
            const Text('COLABORADORES ACTUALES', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.2, color: NexoColors.textMuted)),
            const SizedBox(height: 16),
            _buildCollaboratorsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildShareCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: NexoColors.white,
        borderRadius: NexoShapes.large,
        boxShadow: [BoxShadow(color: NexoColors.black.withValues(alpha: 0.05), blurRadius: 15, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Invitar Colaboradores', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: NexoColors.textMain)),
          const SizedBox(height: 8),
          const Text('Añade a otros usuarios de Nexo por su email para editar juntos.', style: TextStyle(color: NexoColors.textSub, fontSize: 13, height: 1.4)),
          const SizedBox(height: 24),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: 'email@ejemplo.com',
              prefixIcon: const Icon(Icons.mail_outline_rounded, color: NexoColors.primaryDark),
              filled: true,
              fillColor: NexoColors.surface,
              border: OutlineInputBorder(borderRadius: NexoShapes.medium, borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _shareWithEmail,
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            child: const Text('ENVIAR INVITACIÓN', style: TextStyle(fontWeight: FontWeight.w800)),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Expanded(child: Divider()),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text('O COMPARTE POR', style: TextStyle(fontSize: 10, color: NexoColors.textMuted, fontWeight: FontWeight.w800))),
              const Expanded(child: Divider()),
            ],
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: _shareViaWhatsApp,
            icon: const Icon(Icons.share_rounded, color: Color(0xFF25D366)),
            label: const Text('COMPARTIR POR WHATSAPP', style: TextStyle(fontWeight: FontWeight.w800, color: NexoColors.textMain)),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: const BorderSide(color: Color(0xFF25D366), width: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollaboratorsList() {
    if (widget.note.sharedWith.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(color: NexoColors.surface, borderRadius: NexoShapes.medium),
        child: const Center(child: Text('Nadie más tiene acceso a esta nota.', style: TextStyle(color: NexoColors.textMuted, fontSize: 13))),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.note.sharedWith.length,
      itemBuilder: (context, index) {
        final uid = widget.note.sharedWith[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const CircleAvatar(backgroundColor: NexoColors.surface, child: Icon(Icons.person_rounded, color: NexoColors.textMuted)),
          title: Text(uid, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)), // TODO: Fetch display names
          subtitle: const Text('Colaborador', style: TextStyle(fontSize: 12)),
          trailing: IconButton(icon: const Icon(Icons.remove_circle_outline, color: NexoColors.error), onPressed: () {}),
        );
      },
    );
  }
}
