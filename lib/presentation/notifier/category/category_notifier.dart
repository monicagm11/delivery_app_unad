import 'package:delivery_app/data/models/category_model.dart';
import 'package:delivery_app/domain/usecases/category/create_category_usecase.dart';
import 'package:delivery_app/domain/usecases/category/get_categories_by_commerce_usecase.dart';
import 'package:delivery_app/domain/usecases/category/update_category_usecase.dart';
import 'package:delivery_app/presentation/notifier/category/category_state.dart';
import 'package:delivery_app/presentation/notifier/session/session_notifier.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryNotifier extends StateNotifier<CategoryState> {

  final CreateCategoryUseCase createUseCase;
  final UpdateCategoryUseCase updateUseCase;
  final GetCategoriesByCommerceUseCase getCategoriesByCommerceUseCase;
  final String commerceId;

  CategoryNotifier({
      required this.createUseCase,
      required this.updateUseCase,
      required this.getCategoriesByCommerceUseCase,
      required this.commerceId,
  }) : super(CategoryState.initial(Constants.headersCategory));

  Future<void> init() async {
    await loadAll();
  }

  Future<void> loadAll() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final items = await getCategoriesByCommerceUseCase(commerceId);
      final data = items.map((e) => e.toMap()).toList();
      state = state.copyWith(isLoading: false, data: data);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> create(Map<String, dynamic> map) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      map['commerce'] = commerceId;
      CategoryModel model = CategoryModel.fromMap(map);
      await createUseCase(model);
      await loadAll();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> update(String id, Map<String, dynamic> map) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      map['commerce'] = commerceId;
      CategoryModel model = CategoryModel.fromMap(map);
      await updateUseCase(id, model);
      await loadAll();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  void openForm() {
    state = state.copyWith(showForm: true);
  }

  void closeForm() {
    state = state.copyWith(showForm: false);
  }
}

final categoryNotifierProvider =
    StateNotifierProvider<CategoryNotifier, CategoryState>((ref) {
    final commerceId = ref.read(sessionNotifierProvider).commerceId ?? '2G9IlFqKCL36mMaFF4Jg';
  return CategoryNotifier(
      createUseCase: ref.read(createCategoryUseCaseProvider),
      updateUseCase: ref.read(updateCategoryUseCaseProvider),
      getCategoriesByCommerceUseCase: ref.read(getCategoriesByCommerceUseCaseProvider),
      commerceId: commerceId,
      );
});