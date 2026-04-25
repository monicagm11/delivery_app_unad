import 'package:delivery_app/domain/entities/category.dart';
import 'package:delivery_app/domain/entities/product.dart';

class EventProductsState {
  final List<Category> categories;
  final List<Product> allProducts;
  final List<Product> filteredProducts;
  final String commerceId;
  final bool isLoading;
  final String? errorMessage;
  final String? selectedCategoryId;

  const EventProductsState(
      {required this.allProducts,
      required this.categories,
      required this.filteredProducts,
      required this.commerceId,
      required this.isLoading,
      this.selectedCategoryId,
      this.errorMessage});

  factory EventProductsState.initial() => EventProductsState(
      allProducts: [],
      categories: [],
      filteredProducts: [],
      commerceId: '',
      isLoading: true,
      errorMessage: null,
      selectedCategoryId: null);

  EventProductsState copyWith(
      {List<Category>? categories,
      List<Product>? allProducts,
      List<Product>? filteredProducts,
      String? commerceId,
      bool? isLoading,
      String? selectedCategoryId,
      String? errorMessage}) {
    return EventProductsState(
        allProducts: allProducts ?? this.allProducts,
        categories: categories ?? this.categories,
        filteredProducts: filteredProducts ?? this.filteredProducts,
        commerceId: commerceId ?? this.commerceId,
        isLoading: isLoading ?? this.isLoading,
        selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
        errorMessage: errorMessage ?? this.errorMessage
        );
  }
}
