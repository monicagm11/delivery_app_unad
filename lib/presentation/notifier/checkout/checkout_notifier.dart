import 'dart:typed_data';

import 'package:delivery_app/data/models/checkout_order_model.dart';
import 'package:delivery_app/domain/entities/cart_item.dart';
import 'package:delivery_app/domain/entities/checkout_item.dart';
import 'package:delivery_app/domain/entities/commerce.dart';
import 'package:delivery_app/domain/entities/payment_method.dart';
import 'package:delivery_app/domain/usecases/checkout/create_checkout_order_usecase.dart';
import 'package:delivery_app/domain/usecases/commerce/get_commerce_by_id_usecase.dart';
import 'package:delivery_app/domain/usecases/upload_image_usecase.dart';
import 'package:delivery_app/presentation/notifier/checkout/checkout_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutNotifier  extends StateNotifier<CheckoutState> {
  CheckoutNotifier({
    required this.getCommerceByIdUseCase,
    required this.uploadImageUseCase,
    required this.createCheckoutOrderUseCase
  }) : super(CheckoutState.initial());

  final GetCommerceByIdUseCase getCommerceByIdUseCase;
  final UploadImageUseCase uploadImageUseCase;
  final CreateCheckoutOrderUseCase createCheckoutOrderUseCase;

Future<void> init(String eventId, List<CartItem> items) async {
    state = state.copyWith(isLoading: true, errorMessage: null, eventId: eventId, items: items);
    try {
      String idCommerce = items[0].product.commerce;
      Commerce? commerce = await getCommerceByIdUseCase.call(idCommerce);
      state = state.copyWith(commerce: commerce, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> createOrder(Map<String, dynamic> map) async {
    state = state.copyWith(isLoading: true);
    try {
      PaymentMethod paymentMethod = map['paymentMethod'] as PaymentMethod;
      Uint8List? bytes = map['imageBytes'] as Uint8List?;
      String? imagePath = map['imagePath'] as String?;
      if (paymentMethod == PaymentMethod.transfer &&
          bytes != null &&
          imagePath != null) {
        String urlImage = await uploadImageUseCase.call(
            path: imagePath, bytes: bytes, folder: 'voucher');
        map['urlImage'] = urlImage;
      }
      final List<CheckoutItem> checkoutItems =
          (map['cartItems'] as List<CartItem>)
              .map((e) => CheckoutItem(
                  priceTotal: e.subtotal,
                  valueIva: e.subtotalIva,
                  percentageIva: e.percentageIva,
                  priceBase: e.subtotalBase,
                  idProduct: e.product.id,
                  nameProduct: e.product.name,
                  count: e.quantity))
              .toList();
      map['checkoutItems'] = checkoutItems;
      CheckoutOrderModel model = CheckoutOrderModel.fromMap(map);
      await createCheckoutOrderUseCase.call(model);

      state = state.copyWith(isLoading: false, isCheckoutCompleted: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final checkoutNotifierProvider =
    StateNotifierProvider<CheckoutNotifier, CheckoutState>((ref) {
  return CheckoutNotifier(
      getCommerceByIdUseCase: ref.read(getCommerceByIdUseCaseProvider),
      uploadImageUseCase: ref.read(uploadImageUseCaseProvider),
      createCheckoutOrderUseCase: ref.read(createCheckoutOrderUseCaseProvider)
      );
});
