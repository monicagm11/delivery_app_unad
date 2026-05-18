import 'package:delivery_app/domain/entities/calculator_price_data.dart';
import 'package:delivery_app/domain/entities/dropdown_option.dart';
import 'package:delivery_app/domain/entities/image_data.dart';
import 'package:delivery_app/domain/entities/product.dart';
import 'package:delivery_app/domain/entities/rol.dart';
import 'package:delivery_app/domain/usecases/category/get_categories_by_commerce_usecase.dart';
import 'package:delivery_app/domain/usecases/product/create_product_usecase.dart';
import 'package:delivery_app/domain/usecases/product/get_products_by_commerce_usecase.dart';
import 'package:delivery_app/domain/usecases/product/update_product_usecase.dart';
import 'package:delivery_app/domain/usecases/upload_image_usecase.dart';
import 'package:delivery_app/presentation/notifier/product/product_state.dart';
import 'package:delivery_app/presentation/notifier/session/session_notifier.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductNotifier extends StateNotifier<ProductState> {
  final GetProductsByCommerceUsecase getAllUseCase;
  final CreateProductUseCase createUseCase;
  final UpdateProductUseCase updateUseCase;
  final GetCategoriesByCommerceUseCase getCategoriesByCommerceUseCase;
  final String commerceId;
  final UploadImageUseCase uploadImageUseCase;
  final Rol rolConfig;

  ProductNotifier({
    required this.getAllUseCase,
    required this.createUseCase,
    required this.updateUseCase,
    required this.getCategoriesByCommerceUseCase,
    required this.commerceId,
    required this.uploadImageUseCase,
    required this.rolConfig
  }) : super(ProductState.initial(Constants.headersProducts));

  Future<void> init() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final categories = await getCategoriesByCommerceUseCase(commerceId);
      final categoriesOptions = categories
          .map((e) => DropdownOption(label: e.name, value: e.id))
          .toList();
      final functionConfig =
          rolConfig.functionConfig[Constants.productFunction];
      state = state.copyWith(
          categoryOptions: categoriesOptions,
          functionConfig: functionConfig,
          categories: categories);
      await loadAll();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> loadAll() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final items = await getAllUseCase(commerceId);
      final data = items.map((e) => {...e.toMap(), 'image': e.urlImage}).toList();
      state = state.copyWith(isLoading: false, data: data);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> create(Map<String, dynamic> map) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      ImageData imageData = map['image'] as ImageData;
      final urlImage = await uploadImageUseCase(path: imageData.path!, folder: imageData.folder, bytes: imageData.bytes);
      map['urlImage'] = urlImage;
      Product model = mapFromFormData(map);

      await createUseCase(model);
      await loadAll();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> update(String id, Map<String, dynamic> map) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      ImageData imageData = map['image'] as ImageData;
      if (imageData.path!= null && !imageData.path!.contains(Constants.bucketName)) {
        final urlImage = await uploadImageUseCase(path: imageData.path!, folder: imageData.folder, bytes: imageData.bytes);
        map['urlImage'] = urlImage;
      } else {
        map['urlImage'] = imageData.path;
      }
      Product model = mapFromFormData(map);
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

  Product mapFromFormData(Map<String, dynamic> map) {
    CalculatorPriceData priceData = map['price'] as CalculatorPriceData;
    return Product(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      status: map['status'] as String? ?? '',
      priceBase: priceData.priceBase,
      percentageIva: priceData.ivaPercentage,
      valueIva: priceData.ivaValue,
      totalPrice: priceData.priceTotal,
      commerce: commerceId,
      category: map['category'] as String? ?? '',
      urlImage: map['urlImage'] as String,
      description: map['description'] as String? ?? ''
    );
  }
}

final productNotifierProvider =
    StateNotifierProvider<ProductNotifier, ProductState>((ref) {
  final commerceId =
      ref.read(sessionNotifierProvider).commerceId ?? '2G9IlFqKCL36mMaFF4Jg';
  final rolConfig =
      ref.read(sessionNotifierProvider).rolConfig ?? Constants.defaultRol;
  return ProductNotifier(
      getAllUseCase: ref.read(getAllProductsUseCaseProvider),
      createUseCase: ref.read(createProductUseCaseProvider),
      updateUseCase: ref.read(updateProductUseCaseProvider),
      getCategoriesByCommerceUseCase:
          ref.read(getCategoriesByCommerceUseCaseProvider),
      uploadImageUseCase: ref.read(uploadImageUseCaseProvider),
      commerceId: commerceId,
      rolConfig: rolConfig);
});
