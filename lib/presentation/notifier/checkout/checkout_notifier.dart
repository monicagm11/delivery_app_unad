import 'dart:typed_data';

import 'package:delivery_app/domain/entities/cart_item.dart';
import 'package:delivery_app/domain/entities/checkout_item.dart';
import 'package:delivery_app/domain/entities/checkout_order.dart';
import 'package:delivery_app/domain/entities/commerce.dart';
import 'package:delivery_app/domain/entities/payment_method.dart';
import 'package:delivery_app/domain/usecases/checkout/create_checkout_order_usecase.dart';
import 'package:delivery_app/domain/usecases/commerce/get_commerce_by_id_usecase.dart';
import 'package:delivery_app/domain/usecases/upload_image_usecase.dart';
import 'package:delivery_app/presentation/notifier/checkout/checkout_state.dart';
import 'package:delivery_app/presentation/notifier/session/session_notifier.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutNotifier  extends StateNotifier<CheckoutState> {
  CheckoutNotifier({
    required this.getCommerceByIdUseCase,
    required this.uploadImageUseCase,
    required this.createCheckoutOrderUseCase,
    required this.userId,
    required this.userName
  }) : super(CheckoutState.initial());

  final GetCommerceByIdUseCase getCommerceByIdUseCase;
  final UploadImageUseCase uploadImageUseCase;
  final CreateCheckoutOrderUseCase createCheckoutOrderUseCase;
  final String userId;
  final String userName;

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
      map['userId'] = userId;
      final now = DateTime.now();
      map['stageList'] = [
        TrackingStage(
            name: Constants.orderCreatedStatus, date: now, completed: true),
        TrackingStage(name: Constants.orderConfirmedStatus, completed: false)
      ];
      CheckoutOrder model = createOrderModel(map);
      String orderId = await createCheckoutOrderUseCase.call(model);

      state = state.copyWith(isLoading: false, isCheckoutCompleted: true, currentOrderId: orderId);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  CheckoutOrder createOrderModel(Map<String, dynamic> map) =>
      CheckoutOrder(
        id: map['id'] as String? ?? '',
        userId: map['userId'] as String? ?? '',
        eventId: map['eventId'] as String? ?? '',
        urlImage: map['urlImage'] as String?,
        change: map['change'] as String?,
        comments: map['comments'] as String? ?? '',
        commerce: map['commerce'] as String? ?? '',
        total: map['total'] as double? ?? 0.0,
        paymentMethod: PaymentMethod.values.firstWhere(
          (e) => e.name == map['paymentMethod'],
          orElse: () => PaymentMethod.cash,
        ),
        checkoutItems: map['checkoutItems'],
        stageList: (map['stageList']),
        location: map['location'],
        userName: map['userName']
      );
}

final checkoutNotifierProvider =
    StateNotifierProvider<CheckoutNotifier, CheckoutState>((ref) {
      final userId = ref.read(sessionNotifierProvider).userId ?? '';
      final userName = ref.read(sessionNotifierProvider).userName ?? '';
  return CheckoutNotifier(
      getCommerceByIdUseCase: ref.read(getCommerceByIdUseCaseProvider),
      uploadImageUseCase: ref.read(uploadImageUseCaseProvider),
      createCheckoutOrderUseCase: ref.read(createCheckoutOrderUseCaseProvider),
      userId: userId,
      userName: userName
      );
});
