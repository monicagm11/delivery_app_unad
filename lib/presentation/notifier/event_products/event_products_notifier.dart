import 'package:delivery_app/domain/entities/category.dart';
import 'package:delivery_app/domain/usecases/category/get_categories_by_commerce_usecase.dart';
import 'package:delivery_app/domain/usecases/product/get_products_by_commerce_usecase.dart';
import 'package:delivery_app/presentation/notifier/event_products/event_products_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventProductsNotifier  extends StateNotifier<EventProductsState> {
  GetCategoriesByCommerceUseCase getCategoriesByCommerceUseCase;
  GetProductsByCommerceUsecase getProductsByCommerceUsecase;

  EventProductsNotifier({required this.getCategoriesByCommerceUseCase, required this.getProductsByCommerceUsecase}): super(EventProductsState.initial());
  
  Future<void> init(String commerceId) async {
    state = state.copyWith(
        isLoading: true, errorMessage: null, commerceId: commerceId);
    try {
      List<Category> allCategories =
          (await getCategoriesByCommerceUseCase.call(commerceId))
              .where((e) => e.status == 'ACTIVO')
              .toList();
      state = state.copyWith(categories: allCategories);
      await loadAll();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> loadAll() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    List<Category> categories = state.categories;
    try {
       final products = await getProductsByCommerceUsecase(state.commerceId);
      final productsAvailables = products
          .where((e) => e.status == 'ACTIVO').map(
            (e) => e.copyWith(categoryName: categories.firstWhere((c) => e.category == c.id).name)
          )
          .toList();

      state = state.copyWith(isLoading: false, allProducts: productsAvailables, filteredProducts: productsAvailables);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  void updateFilterList(String? categoryId) {
    final totalProducts = state.allProducts;
    if (categoryId == null) {
      state = state.copyWith(filteredProducts: totalProducts);
    } else{
      final productsFiltered = totalProducts
          .where((e) => e.category == categoryId)
          .toList();
      state = state.copyWith(filteredProducts: productsFiltered);
    }
    
    
  }
  
}

final eventProductNotifierProvider =
    StateNotifierProvider<EventProductsNotifier, EventProductsState>((ref) {
  return EventProductsNotifier(
      getProductsByCommerceUsecase: ref.read(getAllProductsUseCaseProvider),
      getCategoriesByCommerceUseCase: ref.read(getCategoriesByCommerceUseCaseProvider)
      );
});