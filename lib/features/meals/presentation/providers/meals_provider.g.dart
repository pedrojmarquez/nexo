// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meals_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mealsRepositoryHash() => r'c6980bfb6e42f53b58568b590bc7043ca420ecef';

/// See also [mealsRepository].
@ProviderFor(mealsRepository)
final mealsRepositoryProvider = AutoDisposeProvider<MealsRepository>.internal(
  mealsRepository,
  name: r'mealsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$mealsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MealsRepositoryRef = AutoDisposeProviderRef<MealsRepository>;
String _$activeMealPlanHash() => r'55f0c66cadeec0cc5cde737cc87dce8e92248bac';

/// Plan de la semana seleccionada
///
/// Copied from [activeMealPlan].
@ProviderFor(activeMealPlan)
final activeMealPlanProvider =
    AutoDisposeStreamProvider<NexoMealPlan?>.internal(
  activeMealPlan,
  name: r'activeMealPlanProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activeMealPlanHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActiveMealPlanRef = AutoDisposeStreamProviderRef<NexoMealPlan?>;
String _$mealsControllerHash() => r'13e997d2e421c49ecdf6ea73201aa319e1e0c039';

/// See also [MealsController].
@ProviderFor(MealsController)
final mealsControllerProvider =
    AutoDisposeNotifierProvider<MealsController, AsyncValue<void>>.internal(
  MealsController.new,
  name: r'mealsControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$mealsControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MealsController = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
