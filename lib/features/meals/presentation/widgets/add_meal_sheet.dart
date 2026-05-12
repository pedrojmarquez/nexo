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
          prepTime: 15, // Hardcoded since we removed the field
        );

    if (mounted) {
      final hasError = ref.read(mealsControllerProvider).hasError;
      if (hasError) {
        final err = ref.read(mealsControllerProvider).error;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Error: $err'), backgroundColor: NexoColors.error),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Comida añadida con éxito'),
              backgroundColor: NexoColors.success),
        );
        Navigator.pop(context);
      }
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
      padding: EdgeInsets.fromLTRB(24, 12, 24, viewInsets + 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: NexoColors.surfaceDark,
                borderRadius: NexoShapes.full,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Añadir Comida',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: NexoColors.textMain, letterSpacing: -0.5),
          ),
          const SizedBox(height: 8),
          const Text(
            'Registra una comida manualmente en tu plan semanal.',
            style: TextStyle(fontSize: 14, color: NexoColors.textSub),
          ),
          const SizedBox(height: 28),

          // Day & Slot Selectors
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<Weekday>(
                  value: _selectedDay,
                  decoration: const InputDecoration(labelText: 'Día', filled: true, fillColor: NexoColors.surface),
                  items: Weekday.values
                      .map((d) => DropdownMenuItem(
                            value: d,
                            child: Text(_getDayLabel(d), style: const TextStyle(fontWeight: FontWeight.w600)),
                          ))
                      .toList(),
                  onChanged: (val) => setState(() => _selectedDay = val!),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<MealSlot>(
                  value: _selectedSlot,
                  decoration: const InputDecoration(labelText: 'Tipo', filled: true, fillColor: NexoColors.surface),
                  items: MealSlot.values
                      .map((s) => DropdownMenuItem(
                            value: s,
                            child: Text(_getSlotLabel(s), style: const TextStyle(fontWeight: FontWeight.w600)),
                          ))
                      .toList(),
                  onChanged: (val) => setState(() => _selectedSlot = val!),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          TextField(
            controller: _nameController,
            style: const TextStyle(fontWeight: FontWeight.w600, color: NexoColors.textMain),
            decoration: const InputDecoration(
                labelText: 'Nombre del plato', hintText: 'Ej. Pasta Carbonara', filled: true, fillColor: NexoColors.surface),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _descController,
            maxLines: 2,
            style: const TextStyle(color: NexoColors.textMain),
            decoration:
                const InputDecoration(labelText: 'Descripción (Opcional)', filled: true, fillColor: NexoColors.surface),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('GUARDAR COMIDA',
                style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.2)),
          ),
        ],
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
