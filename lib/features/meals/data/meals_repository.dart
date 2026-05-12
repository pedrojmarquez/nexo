import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nexo/core/constants/app_constants.dart';
import 'package:nexo/features/meals/domain/meal_plan_model.dart';

class MealsRepository {
  final FirebaseFirestore _firestore;

  MealsRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<NexoMealPlan> get _mealsRef => _firestore
      .collection(AppConstants.mealPlansCollection)
      .withConverter<NexoMealPlan>(
        fromFirestore: (doc, _) => NexoMealPlan.fromFirestore(doc),
        toFirestore: (plan, _) {
          // json_serializable sin explicitToJson no mapea listas anidadas a Map,
          // por lo que debemos mapearlo manualmente para que Firestore lo acepte
          final json = plan.toJson();

          if (json['meals'] != null) {
            json['meals'] = plan.meals.map((m) {
              final mealMap = m.toJson();
              mealMap['recipe'] = m.recipe.toJson();

              if (m.recipe.ingredients.isNotEmpty) {
                final recipeMap = mealMap['recipe'] as Map<String, dynamic>;
                recipeMap['ingredients'] =
                    m.recipe.ingredients.map((i) => i.toJson()).toList();
              }

              return mealMap;
            }).toList();
          }
          json.remove('id');
          return json;
        },
      );

  /// Obtiene el plan de comidas activo del usuario (legacy — mantiene compatibilidad)
  Stream<NexoMealPlan?> watchActiveMealPlan(String uid) {
    return _mealsRef
        .where('ownerUid', isEqualTo: uid)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) return null;

      final plans = snapshot.docs.map((doc) => doc.data()).toList();
      plans.sort((a, b) {
        final dateA = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final dateB = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return dateB.compareTo(dateA);
      });

      return plans.first;
    });
  }

  /// Obtiene el plan de una semana específica (por weekStartDate = lunes de esa semana)
  Stream<NexoMealPlan?> watchMealPlanForWeek(String uid, DateTime weekStart) {
    // Normalizamos a medianoche para comparaciones consistentes
    final start = DateTime(weekStart.year, weekStart.month, weekStart.day);
    final end = start.add(const Duration(days: 1));

    return _mealsRef
        .where('ownerUid', isEqualTo: uid)
        .where('weekStartDate',
            isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('weekStartDate', isLessThan: Timestamp.fromDate(end))
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) return null;

      final docs = snapshot.docs.map((d) => d.data()).toList();
      docs.sort((a, b) {
        final dateA = a.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final dateB = b.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return dateB.compareTo(dateA); // Descendente
      });

      return docs.first;
    });
  }

  /// Obtiene o crea un plan para una semana concreta
  Future<NexoMealPlan> getOrCreatePlanForWeek(
      String uid, DateTime weekStart) async {
    final start = DateTime(weekStart.year, weekStart.month, weekStart.day);
    final end = start.add(const Duration(days: 1));

    final snapshot = await _mealsRef
        .where('ownerUid', isEqualTo: uid)
        .where('weekStartDate',
            isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('weekStartDate', isLessThan: Timestamp.fromDate(end))
        .get();

    if (snapshot.docs.isNotEmpty) {
      final docs = snapshot.docs.map((d) => d.data()).toList();
      docs.sort((a, b) {
        final dateA = a.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final dateB = b.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return dateB.compareTo(dateA); // Descendente
      });
      return docs.first;
    }

    // Crear plan vacío para esta semana
    final newPlan = NexoMealPlan(
      id: '',
      ownerUid: uid,
      name: 'Semana del ${start.day}/${start.month}/${start.year}',
      weekStartDate: start,
      meals: [],
    );
    return await createMealPlan(newPlan);
  }

  /// Crea un nuevo plan de comidas
  Future<NexoMealPlan> createMealPlan(NexoMealPlan plan) async {
    final docRef = _mealsRef.doc();
    final newPlan = plan.copyWith(
      id: docRef.id,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await docRef.set(newPlan);
    return newPlan;
  }

  /// Actualiza un plan de comidas existente
  Future<void> updateMealPlan(NexoMealPlan plan) async {
    if (plan.id.isEmpty) return;
    await _mealsRef.doc(plan.id).set(plan.copyWith(updatedAt: DateTime.now()));
  }

  /// Actualiza una comida específica dentro de un plan
  Future<void> updateDayMeal(String planId, DayMeal updatedMeal) async {
    final doc = await _mealsRef.doc(planId).get();
    if (!doc.exists) return;

    final plan = doc.data()!;
    final updatedMeals = plan.meals.map((m) {
      return m.id == updatedMeal.id ? updatedMeal : m;
    }).toList();

    await updateMealPlan(plan.copyWith(meals: updatedMeals));
  }
}
