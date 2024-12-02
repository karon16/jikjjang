import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/categories_service.dart';

final categoriesServiceProvider = Provider<CategoriesService>((ref) {
  return CategoriesService();
});

final categoriesProvider = FutureProvider<List<String>>((ref) async {
  final categoriesService = ref.watch(categoriesServiceProvider);
  final categories = await categoriesService.fetchCategories();
  return categories.map((category) => category.name).toList();
});
