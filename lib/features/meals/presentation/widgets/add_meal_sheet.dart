import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo/core/theme/app_colors.dart';
import 'package:nexo/core/theme/app_shapes.dart';
import 'package:nexo/features/meals/domain/meal_plan_model.dart';
import 'package:nexo/features/meals/presentation/providers/meals_provider.dart';

class AddMealSheet extends ConsumerStatefulWidget {
  final Weekday initialDay;
  const AddMealSheet({super.key, required this.initialDay});

  static Future<void> show(BuildContext context, Weekday initialDay) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddMealSheet(initialDay: initialDay),
    );
  }

  @override
  ConsumerState<AddMealSheet> createState() => _AddMealSheetState();
}

class _AddMealSheetState extends ConsumerState<AddMealSheet> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  late Weekday _selectedDay;
  MealSlot _selectedSlot = MealSlot.lunch;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.initialDay;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _submit() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    await ref.read(mealsControllerProvider.notifier).addManualMeal(
          weekday: _selectedDay,
          slot: _selectedSlot,
          mealName: name,
          description: _descController.text.trim(),
          prepTime: 15,
        );

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Comida añadida correctamente'),
          backgroundColor: NexoColors.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: NexoColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: EdgeInsets.fromLTRB(28, 12, 28, viewInsets + 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(color: NexoColors.surfaceDark, borderRadius: NexoShapes.full),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Nueva Comida',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: NexoColors.textMain, letterSpacing: -0.5)),
            const SizedBox(height: 24),
            
            Row(
              children: [
                Expanded(child: _buildDropdown<Weekday>(_selectedDay, 'Día', Weekday.values, (v) => setState(() => _selectedDay = v!), _getDayLabel)),
                const SizedBox(width: 12),
                Expanded(child: _buildDropdown<MealSlot>(_selectedSlot, 'Momento', MealSlot.values, (v) => setState(() => _selectedSlot = v!), _getSlotLabel)),
              ],
            ),
            const SizedBox(height: 16),
            _buildTextField(_nameController, '¿Qué vas a comer?', Icons.restaurant_rounded),
            const SizedBox(height: 16),
            _buildTextField(_descController, 'Notas adicionales (opcional)', Icons.notes_rounded, maxLines: 2),
            const SizedBox(height: 24),
            
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: NexoColors.primary,
                foregroundColor: NexoColors.textMain,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: NexoShapes.medium),
                elevation: 0,
              ),
              child: const Text('GUARDAR EN EL PLAN', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.1)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20, color: NexoColors.primaryDark),
        filled: true,
        fillColor: NexoColors.surface,
        border: OutlineInputBorder(borderRadius: NexoShapes.medium, borderSide: BorderSide.none),
        labelStyle: const TextStyle(color: NexoColors.textMuted, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildDropdown<T>(T value, String label, List<T> items, ValueChanged<T?> onChanged, String Function(T) getLabel) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items.map((i) => DropdownMenuItem(value: i, child: Text(getLabel(i), style: const TextStyle(fontWeight: FontWeight.w600)))).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: NexoColors.surface,
        border: OutlineInputBorder(borderRadius: NexoShapes.medium, borderSide: BorderSide.none),
      ),
    );
  }

  String _getDayLabel(Weekday day) {
    switch (day) {
      case Weekday.monday: return 'Lunes';
      case Weekday.tuesday: return 'Martes';
      case Weekday.wednesday: return 'Miércoles';
      case Weekday.thursday: return 'Jueves';
      case Weekday.friday: return 'Viernes';
      case Weekday.saturday: return 'Sábado';
      case Weekday.sunday: return 'Domingo';
    }
  }

  String _getSlotLabel(MealSlot slot) {
    switch (slot) {
      case MealSlot.breakfast: return 'Desayuno';
      case MealSlot.lunch: return 'Comida';
      case MealSlot.dinner: return 'Cena';
      case MealSlot.snack: return 'Snack';
    }
  }
}
