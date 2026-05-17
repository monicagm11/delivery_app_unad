import 'dart:async';

import 'package:delivery_app/data/datasources/base_firestore_datasource.dart';
import 'package:delivery_app/data/models/checkout_order_model.dart';
import 'package:delivery_app/domain/entities/checkout_order.dart';
import 'package:delivery_app/domain/entities/payment_method.dart';
import 'package:delivery_app/domain/entities/rol.dart';
import 'package:delivery_app/domain/entities/user.dart';
import 'package:delivery_app/domain/usecases/checkout/add_stage_to_checkout_order_usecase.dart';
import 'package:delivery_app/domain/usecases/checkout/update_status_checkout_order_usecase.dart';
import 'package:delivery_app/domain/usecases/user/get_logistics_by_event_usecase.dart';
import 'package:delivery_app/domain/usecases/watch_collection_usecase.dart';
import 'package:delivery_app/presentation/notifier/manage_sales/manage_sales_state.dart';
import 'package:delivery_app/presentation/notifier/session/session_notifier.dart';
import 'package:delivery_app/presentation/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageSalesNotifier extends StateNotifier<ManageSalesState> {
  ManageSalesNotifier(
      {required this.useCase,
      required this.commerceId,
      required this.rolConfig,
      required this.getLogisticsByEventUseCase,
      required this.updateStatusCheckoutOrderUsecase,
      required this.addStageToCheckoutOrderUseCase
      })
      : super(ManageSalesState.initial(Constants.headersCategory));

  final WatchCollectionUseCase<CheckoutOrder> useCase;
  final String commerceId;
  final Rol rolConfig;
  final GetLogisticsByEventUseCase getLogisticsByEventUseCase;
  final UpdateStatusCheckoutOrderUsecase updateStatusCheckoutOrderUsecase;
  final AddStageToCheckoutOrderUseCase addStageToCheckoutOrderUseCase;
  StreamSubscription<List<CheckoutOrder>>? _subscription;

  void watchCollection() {
    final functionConfig =
          rolConfig.functionConfig[Constants.salesFunction];
      state = state.copyWith(
          functionConfig: functionConfig);
    _subscribe(useCase.where('commerce', commerceId));
  }

  void _subscribe(Stream<List<CheckoutOrder>> stream) {
    _subscription?.cancel();
    state = state.copyWith(isLoading: true, errorMessage: null);
    _subscription = stream.listen(
      (items) {
        List<Map<String, dynamic>> mappedData = items.map((e){
          String? currentStatus = e.stageList.last.name;
          return {...( e.toMap()), 'status': currentStatus, 'paymentMethodName' : getNameMehodPayment(e.paymentMethod)};
        }).toList();
        state = state.copyWith(items: items, isLoading: false, data: mappedData);
      },
      onError: (e) => state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ),
    );
  }

  String getNameMehodPayment(PaymentMethod paymentMethod) {
    return paymentMethod == PaymentMethod.cash ? 'Efectivo' : 'Transferencia';
  }

  Future<void> setLogisticAvailable(String eventId) async {
    try {
      List<User> logisticAvailable = await getLogisticsByEventUseCase(eventId);
      state = state.copyWith(logisticAvailable: logisticAvailable);
    } catch (_) {
      state = state.copyWith(logisticAvailable: []);
    }
  }
  
  Future<void> setDeliveryToOrder(String orderId, String idDelivery, String newStatus) async {
    final map = {
      'idDeliveryAssigned' : idDelivery
    };
    await updateStatusCheckoutOrderUsecase(orderId, map);
    await updateStatusOrder(orderId, newStatus);
  }

  Future<void> updateStatusOrder(String orderId, String newStatus) async {
    final trackingStage = TrackingStage(name: newStatus, date: DateTime.now(), completed: true);
    await addStageToCheckoutOrderUseCase(orderId, trackingStage);
  }

  void stop() {
    _subscription?.cancel();
    _subscription = null;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

final manageSalesRealtimeProvider =
    StateNotifierProvider<ManageSalesNotifier, ManageSalesState>((ref) {
  final useCase = WatchCollectionUseCase<CheckoutOrder>(
    firestore: ref.read(firebaseFirestoreProvider),
    collectionName: 'checkout_orders',
    mapper: CheckoutOrderModel.fromMap,
  );
  final commerceId = ref.read(sessionNotifierProvider).commerceId ?? '';
  final rolConfig =
      ref.read(sessionNotifierProvider).rolConfig ?? Constants.defaultRol;
  return ManageSalesNotifier(
      useCase: useCase,
      commerceId: commerceId,
      rolConfig: rolConfig,
      getLogisticsByEventUseCase: ref.read(getLogisticsByEventUseCaseProvider),
      updateStatusCheckoutOrderUsecase: ref.read(updateStatusCheckoutOrderUsecaseProvider),
      addStageToCheckoutOrderUseCase: ref.read(addStageToCheckoutOrderUseCaseProvider),
      );
});
