import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:nexo/core/theme/app_colors.dart';
import 'package:nexo/core/theme/app_shapes.dart';
import 'package:nexo/features/meals/domain/meal_plan_model.dart';
import 'package:nexo/features/meals/presentation/providers/meals_provider.dart';
import 'package:nexo/features/meals/presentation/widgets/add_meal_sheet.dart';
import 'package:nexo/features/meals/presentation/widgets/week_calendar_widget.dart';
import 'package:nexo/features/meals/presentation/widgets/day_detail_card.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// MealsPage V3 — Calendario semanal + carrusel de días + IA bajo demanda
/// ─────────────────────────────────────────────────────────────────────────────
class MealsPage extends ConsumerStatefulWidget {
  const MealsPage({super.key});

  @override
  ConsumerState<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends ConsumerState<MealsPage> {
  late PageController _pageController;
  int _selectedDayIndex = 0;

  @override
  void initState() {
    super.initState();
    // Start on today's day of the week (0=Mon, 6=Sun)
    final now = DateTime.now();
    _selectedDayIndex = (now.weekday - 1).clamp(0, 6);
    _pageController = PageController(
      initialPage: _selectedDayIndex,
      viewportFraction: 0.88,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPrevWeek() {
    final current = ref.read(selectedWeekProvider);
    ref.read(selectedWeekProvider.notifier).state =
        current.subtract(const Duration(days: 7));
  }

  void _goToNextWeek() {
    final current = ref.read(selectedWeekProvider);
    ref.read(selectedWeekProvider.notifier).state =
        current.add(const Duration(days: 7));
  }

  void _selectDay(int index) {
    setState(() => _selectedDayIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  Weekday _weekdayFromIndex(int index) => Weekday.values[index];

  @override
  Widget build(BuildContext context) {
    final weekStart = ref.watch(selectedWeekProvider);
    final activePlanAsync = ref.watch(activeMealPlanProvider);

    return Scaffold(
      backgroundColor: NexoColors.background,
      appBar: AppBar(
        title: const Text('Comidas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline_rounded),
            onPressed: () => _showAddMeal(context),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: activePlanAsync.when(
        data: (plan) => _buildContent(plan, weekStart),
        loading: () => const Center(
            child: CircularProgressIndicator(color: NexoColors.primaryDark)),
        error: (e, _) => Center(
            child: Text('Error: $e',
                style: const TextStyle(color: NexoColors.error))),
      ),
    );
  }

  Widget _buildContent(NexoMealPlan? plan, DateTime weekStart) {
    // Calculate meals per day for the calendar widget
    final mealsPerDay = <int, int>{};
    if (plan != null) {
      for (int i = 0; i < 7; i++) {
        final weekday = Weekday.values[i];
        mealsPerDay[i] = plan.meals.where((m) => m.weekday == weekday).length;
      }
    }

    return Column(
      children: [
        // ── Mini calendario semanal (arriba, compacto) ──────────
        WeekCalendarWidget(
          weekStart: weekStart,
          selectedDayIndex: _selectedDayIndex,
          mealsPerDay: mealsPerDay,
          onDayTap: _selectDay,
          onPrevWeek: _goToPrevWeek,
          onNextWeek: _goToNextWeek,
        ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.1),

        const SizedBox(height: 12),

        // ── Carrusel de días (abajo, más grande) ────────────────
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 100), // Evita solapamiento con footer
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _selectedDayIndex = index);
              },
              itemCount: 7,
              itemBuilder: (context, index) {
                final weekday = _weekdayFromIndex(index);
                final dayDate = weekStart.add(Duration(days: index));
                final dayMeals =
                    plan?.meals.where((m) => m.weekday == weekday).toList() ?? [];

                // Sort by slot order
                dayMeals.sort((a, b) => a.slot.index.compareTo(b.slot.index));

                return DayDetailCard(
                  date: dayDate,
                  weekday: weekday,
                  meals: dayMeals,
                  planId: plan?.id,
                  onAddMeal: () => _showAddMeal(context, weekday: weekday),
                ).animate().fadeIn(duration: 200.ms).scale(
                      begin: const Offset(0.96, 0.96),
                      curve: Curves.easeOut,
                    );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _showAddMeal(BuildContext context, {Weekday? weekday}) {
    AddMealSheet.show(context, weekday ?? _weekdayFromIndex(_selectedDayIndex));
  }
}
