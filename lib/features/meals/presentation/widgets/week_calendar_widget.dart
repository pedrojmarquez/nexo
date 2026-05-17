import 'package:flutter/material.dart';
import 'package:nexo/core/theme/app_colors.dart';
import 'package:nexo/core/theme/app_shapes.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// WeekCalendarWidget — Mini calendario semanal compacto
/// Muestra 7 días con indicadores de comidas registradas
/// ─────────────────────────────────────────────────────────────────────────────
class WeekCalendarWidget extends StatelessWidget {
  final DateTime weekStart;
  final int selectedDayIndex; // 0=Mon, 6=Sun
  final Map<int, int> mealsPerDay; // dayIndex → number of meals
  final ValueChanged<int> onDayTap;
  final VoidCallback onPrevWeek;
  final VoidCallback onNextWeek;

  const WeekCalendarWidget({
    super.key,
    required this.weekStart,
    required this.selectedDayIndex,
    required this.mealsPerDay,
    required this.onDayTap,
    required this.onPrevWeek,
    required this.onNextWeek,
  });

  static const _dayLabels = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final todayIndex = _getTodayIndex(now);
    final weekEnd = weekStart.add(const Duration(days: 6));
    
    // Formatear en español manualmente si el locale no está configurado
    final months = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'];
    final startStr = '${weekStart.day} ${months[weekStart.month - 1]}';
    final endStr = '${weekEnd.day} ${months[weekEnd.month - 1]}';
    final dateRange = '$startStr – $endStr';

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
      decoration: BoxDecoration(
        color: NexoColors.white,
        borderRadius: NexoShapes.large,
        boxShadow: [
          BoxShadow(
            color: NexoColors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Header con navegación de semanas ──────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: onPrevWeek,
                icon: const Icon(Icons.chevron_left_rounded,
                    color: NexoColors.textSub),
                iconSize: 22,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              ),
              Text(
                dateRange,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: NexoColors.textMain,
                ),
              ),
              IconButton(
                onPressed: onNextWeek,
                icon: const Icon(Icons.chevron_right_rounded,
                    color: NexoColors.textSub),
                iconSize: 22,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ── Grid de 7 días ───────────────────────────────────────
          Row(
            children: List.generate(7, (index) {
              final dayDate = weekStart.add(Duration(days: index));
              final isToday = todayIndex == index;
              final isSelected = selectedDayIndex == index;
              final mealCount = mealsPerDay[index] ?? 0;

              return Expanded(
                child: GestureDetector(
                  onTap: () => onDayTap(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? NexoColors.primary.withValues(alpha: 0.15)
                          : Colors.transparent,
                      borderRadius: NexoShapes.small,
                      border: isToday && !isSelected
                          ? Border.all(
                              color: NexoColors.primaryDark, width: 1.5)
                          : null,
                    ),
                    child: Column(
                      children: [
                        // Day label
                        Text(
                          _dayLabels[index],
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: isSelected
                                ? NexoColors.textMain
                                : NexoColors.textMuted,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Day number
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: isToday
                                ? NexoColors.primaryDark
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${dayDate.day}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: isToday
                                  ? NexoColors.white
                                  : NexoColors.textMain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        // Meal indicators (dots)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(4, (slotIdx) {
                            final hasMeal = slotIdx < mealCount;
                            return Container(
                              width: 5,
                              height: 5,
                              margin: const EdgeInsets.symmetric(horizontal: 1),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: hasMeal
                                    ? NexoColors.success
                                    : NexoColors.surfaceDark
                                        .withValues(alpha: 0.4),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  int _getTodayIndex(DateTime now) {
    final today = DateTime(now.year, now.month, now.day);
    final diff = today
        .difference(DateTime(weekStart.year, weekStart.month, weekStart.day))
        .inDays;
    if (diff >= 0 && diff <= 6) return diff;
    return -1; // Today is not in this week
  }
}
