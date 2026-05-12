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
  final _timeController = TextEditingController(text: '15');
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
    _timeController.dispose();
    super.dispose();
  }

  void _submit() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    final time = int.tryParse(_timeController.text) ?? 15;

    await ref.read(mealsControllerProvider.notifier).addManualMeal(
          weekday: _selectedDay,
          slot: _selectedSlot,
          mealName: name,
          description: _descController.text.trim(),
          prepTime: time,
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
              content: Text('Meal added successfully!'),
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
            'Add Manual Meal',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 24),

          // Day & Slot Selectors
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<Weekday>(
                  value: _selectedDay,
                  decoration: const InputDecoration(labelText: 'Day'),
                  items: Weekday.values
                      .map((d) => DropdownMenuItem(
                            value: d,
                            child: Text(_getDayLabel(d)),
                          ))
                      .toList(),
                  onChanged: (val) => setState(() => _selectedDay = val!),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<MealSlot>(
                  value: _selectedSlot,
                  decoration: const InputDecoration(labelText: 'Slot'),
                  items: MealSlot.values
                      .map((s) => DropdownMenuItem(
                            value: s,
                            child: Text(_getSlotLabel(s)),
                          ))
                      .toList(),
                  onChanged: (val) => setState(() => _selectedSlot = val!),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
                labelText: 'Meal Name', hintText: 'e.g. Pasta Carbonara'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _descController,
            decoration:
                const InputDecoration(labelText: 'Description (Optional)'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _timeController,
            decoration: const InputDecoration(
                labelText: 'Prep Time (mins)', suffixText: 'min'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('SAVE MEAL',
                style: TextStyle(fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }

  String _getDayLabel(Weekday day) {
    switch (day) {
      case Weekday.monday:
        return 'Monday';
      case Weekday.tuesday:
        return 'Tuesday';
      case Weekday.wednesday:
        return 'Wednesday';
      case Weekday.thursday:
        return 'Thursday';
      case Weekday.friday:
        return 'Friday';
      case Weekday.saturday:
        return 'Saturday';
      case Weekday.sunday:
        return 'Sunday';
    }
  }

  String _getSlotLabel(MealSlot slot) {
    switch (slot) {
      case MealSlot.breakfast:
        return 'Breakfast';
      case MealSlot.lunch:
        return 'Lunch';
      case MealSlot.dinner:
        return 'Dinner';
      case MealSlot.snack:
        return 'Snack';
    }
  }
}
