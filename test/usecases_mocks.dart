// ignore_for_file: depend_on_referenced_packages
import 'package:delivery_app/domain/usecases/auth/login_google_usecase.dart';
import 'package:delivery_app/domain/usecases/auth/login_usecase.dart';
import 'package:delivery_app/domain/usecases/auth/reset_password_usecase.dart';
import 'package:delivery_app/domain/usecases/auth/update_password_usecase.dart';
import 'package:delivery_app/domain/usecases/category/create_category_usecase.dart';
import 'package:delivery_app/domain/usecases/category/get_categories_by_commerce_usecase.dart';
import 'package:delivery_app/domain/usecases/category/update_category_usecase.dart';
import 'package:delivery_app/domain/usecases/checkout/add_stage_to_checkout_order_usecase.dart';
import 'package:delivery_app/domain/usecases/checkout/create_checkout_order_usecase.dart';
import 'package:delivery_app/domain/usecases/checkout/get_all_checkout_order_usecases.dart';
import 'package:delivery_app/domain/usecases/checkout/get_checkout_order_by_id_usecase.dart';
import 'package:delivery_app/domain/usecases/checkout/get_checkout_orders_by_event_usecase.dart';
import 'package:delivery_app/domain/usecases/checkout/get_checkout_orders_by_user_usecase.dart';
import 'package:delivery_app/domain/usecases/checkout/update_checkout_order_usecase.dart';
import 'package:delivery_app/domain/usecases/checkout/update_status_checkout_order_usecase.dart';
import 'package:delivery_app/domain/usecases/commerce/create_commerce_usecase.dart';
import 'package:delivery_app/domain/usecases/commerce/get_all_commercers_usecase.dart';
import 'package:delivery_app/domain/usecases/commerce/get_commerce_by_id_usecase.dart';
import 'package:delivery_app/domain/usecases/commerce/update_commerce_usecase.dart';
import 'package:delivery_app/domain/usecases/create_request/create_request_event_usecase.dart';
import 'package:delivery_app/domain/usecases/create_request/get_all_request_event_usecases.dart';
import 'package:delivery_app/domain/usecases/create_request/get_request_events_by_commerce_usecase.dart';
import 'package:delivery_app/domain/usecases/create_request/update_request_event_usecase.dart';
import 'package:delivery_app/domain/usecases/event/create_event_usecase.dart';
import 'package:delivery_app/domain/usecases/event/get_all_events_usecase.dart';
import 'package:delivery_app/domain/usecases/event/get_event_by_city_usecase.dart';
import 'package:delivery_app/domain/usecases/event/get_event_by_id_usecase.dart';
import 'package:delivery_app/domain/usecases/event/update_event_usecase.dart';
import 'package:delivery_app/domain/usecases/functions/get_departments_usecase.dart';
import 'package:delivery_app/domain/usecases/functions/get_remote_config_usecase.dart';
import 'package:delivery_app/domain/usecases/functions/send_email_new_users_usecase.dart';
import 'package:delivery_app/domain/usecases/functions/send_push_notification_usecase.dart';
import 'package:delivery_app/domain/usecases/functions/upload_image_usecase.dart';
import 'package:delivery_app/domain/usecases/global_event/create_global_event_usecase.dart';
import 'package:delivery_app/domain/usecases/global_event/get_active_global_event_usecase.dart';
import 'package:delivery_app/domain/usecases/global_event/get_all_global_events_usecase.dart';
import 'package:delivery_app/domain/usecases/global_event/get_global_event_by_city_usecase.dart';
import 'package:delivery_app/domain/usecases/global_event/get_global_event_by_id_usecase.dart';
import 'package:delivery_app/domain/usecases/global_event/update_global_event_usecase.dart';
import 'package:delivery_app/domain/usecases/local_storage/get_string_localstorage_usecase.dart';
import 'package:delivery_app/domain/usecases/local_storage/save_string_localstorage_usecase.dart';
import 'package:delivery_app/domain/usecases/product/create_product_usecase.dart';
import 'package:delivery_app/domain/usecases/product/get_products_by_commerce_usecase.dart';
import 'package:delivery_app/domain/usecases/product/update_product_usecase.dart';
import 'package:delivery_app/domain/usecases/realtime/watch_collection_usecase.dart';
import 'package:delivery_app/domain/usecases/realtime/watch_document_usecase.dart';
import 'package:delivery_app/domain/usecases/user/create_user_usecase.dart';
import 'package:delivery_app/domain/usecases/user/get_all_user_usecase.dart';
import 'package:delivery_app/domain/usecases/user/get_logistics_by_event_usecase.dart';
import 'package:delivery_app/domain/usecases/user/get_user_by_id_usecase.dart';
import 'package:delivery_app/domain/usecases/user/update_current_event_id_usecase.dart';
import 'package:delivery_app/domain/usecases/user/update_user_usecase.dart';
import 'package:delivery_app/presentation/notifier/session/session_notifier.dart';
import 'package:mocktail/mocktail.dart';

import 'state_mocks.dart';

// ── Auth ─────────────────────────────────────────────────────────────────────
class LoginGoogleUsecaseMock extends Mock implements LoginGoogleUsecase {}
class LoginUseCaseMock extends Mock implements LoginUseCase {}
class ResetPasswordUseCaseMock extends Mock implements ResetPasswordUseCase {}
class UpdatePasswordUseCaseMock extends Mock implements UpdatePasswordUseCase {}

// ── Category ─────────────────────────────────────────────────────────────────
class CreateCategoryUseCaseMock extends Mock implements CreateCategoryUseCase {}
class GetCategoriesByCommerceUseCaseMock extends Mock implements GetCategoriesByCommerceUseCase {}
class UpdateCategoryUseCaseMock extends Mock implements UpdateCategoryUseCase {}

// ── Checkout ──────────────────────────────────────────────────────────────────
class AddStageToCheckoutOrderUseCaseMock extends Mock implements AddStageToCheckoutOrderUseCase {}
class CreateCheckoutOrderUseCaseMock extends Mock implements CreateCheckoutOrderUseCase {}
class GetAllCheckoutOrdersUseCaseMock extends Mock implements GetAllCheckoutOrdersUseCase {}
class GetCheckoutOrderByIdUseCaseMock extends Mock implements GetCheckoutOrderByIdUseCase {}
class GetCheckoutOrdersByEventUseCaseMock extends Mock implements GetCheckoutOrdersByEventUseCase {}
class GetCheckoutOrdersByUserUseCaseMock extends Mock implements GetCheckoutOrdersByUserUseCase {}
class UpdateCheckoutOrderUseCaseMock extends Mock implements UpdateCheckoutOrderUseCase {}
class UpdateStatusCheckoutOrderUsecaseMock extends Mock implements UpdateStatusCheckoutOrderUsecase {}

// ── Commerce ──────────────────────────────────────────────────────────────────
class CreateCommerceUseCaseMock extends Mock implements CreateCommerceUseCase {}
class GetAllCommercesUseCaseMock extends Mock implements GetAllCommercesUseCase {}
class GetCommerceByIdUseCaseMock extends Mock implements GetCommerceByIdUseCase {}
class UpdateCommerceUseCaseMock extends Mock implements UpdateCommerceUseCase {}

// ── Create Request ────────────────────────────────────────────────────────────
class CreateRequestEventUseCaseMock extends Mock implements CreateRequestEventUseCase {}
class GetAllRequestEventsUseCaseMock extends Mock implements GetAllRequestEventsUseCase {}
class GetRequestEventsByCommerceUseCaseMock extends Mock implements GetRequestEventsByCommerceUseCase {}
class UpdateRequestEventUseCaseMock extends Mock implements UpdateRequestEventUseCase {}

// ── Event (Local) ─────────────────────────────────────────────────────────────
class CreateLocalEventUseCaseMock extends Mock implements CreateLocalEventUseCase {}
class GetAllLocalEventsUseCaseMock extends Mock implements GetAllLocalEventsUseCase {}
class GetEventByCityUsecaseMock extends Mock implements GetEventByCityUsecase {}
class GetLocalEventByIdUseCaseMock extends Mock implements GetLocalEventByIdUseCase {}
class UpdateLocalEventUseCaseMock extends Mock implements UpdateLocalEventUseCase {}
class GetLocalEventsByCommerceUseCaseMock extends Mock implements GetLocalEventsByCommerceUseCase {}

// ── Functions ─────────────────────────────────────────────────────────────────
class GetDepartmentsUseCaseMock extends Mock implements GetDepartmentsUseCase {}
class GetRemoteConfigUsecaseMock extends Mock implements GetRemoteConfigUsecase {}
class SendEmailNewUsersUsecaseMock extends Mock implements SendEmailNewUsersUsecase {}
class SendPushNotificationUseCaseMock extends Mock implements SendPushNotificationUseCase {}
class UploadImageUseCaseMock extends Mock implements UploadImageUseCase {}

// ── Global Event ──────────────────────────────────────────────────────────────
class CreateGlobalEventUseCaseMock extends Mock implements CreateGlobalEventUseCase {}
class GetActiveGlobalEventUsecaseMock extends Mock implements GetActiveGlobalEventUsecase {}
class GetAllGlobalEventsUseCaseMock extends Mock implements GetAllGlobalEventsUseCase {}
class GetGlobalEventByCityUsecaseMock extends Mock implements GetGlobalEventByCityUsecase {}
class GetGlobalEventByIdUseCaseMock extends Mock implements GetGlobalEventByIdUseCase {}
class UpdateGlobalEventUseCaseMock extends Mock implements UpdateGlobalEventUseCase {}

// ── Local Storage ─────────────────────────────────────────────────────────────
class GetStringLocalstorageUsecaseMock extends Mock implements GetStringLocalstorageUsecase {}
class SaveStringLocalstorageUsecaseMock extends Mock implements SaveStringLocalstorageUsecase {}

// ── Product ───────────────────────────────────────────────────────────────────
class CreateProductUseCaseMock extends Mock implements CreateProductUseCase {}
class GetProductsByCommerceUsecaseMock extends Mock implements GetProductsByCommerceUsecase {}
class UpdateProductUseCaseMock extends Mock implements UpdateProductUseCase {}

// ── Realtime ──────────────────────────────────────────────────────────────────
class WatchCollectionUseCaseMock<T> extends Mock implements WatchCollectionUseCase<T> {}
class WatchDocumentUsecaseMock<T> extends Mock implements WatchDocumentUsecase<T> {}

// ── User ──────────────────────────────────────────────────────────────────────
class CreateUserUseCaseMock extends Mock implements CreateUserUseCase {}
class GetAllUsersUseCaseMock extends Mock implements GetAllUsersUseCase {}
class GetLogisticsByEventUseCaseMock extends Mock implements GetLogisticsByEventUseCase {}
class GetUserByIdUseCaseMock extends Mock implements GetUserByIdUseCase {}
class UpdateCurrentEventIdUseCaseMock extends Mock implements UpdateCurrentEventIdUseCase {}
class UpdateUserUseCaseMock extends Mock implements UpdateUserUseCase {}

//---SessionNotifier--------------------------------------------------------
class SessionNotiferMock extends SessionNotifier {
  SessionNotiferMock()
      : super(
          getCommerceByIdUseCase: GetCommerceByIdUseCaseMock(),
          getUserByIdUseCase: GetUserByIdUseCaseMock(),
          getRemoteConfigUsecase: GetRemoteConfigUsecaseMock(),
        ) {
    state = StateMocks.sessionStateMock;
  }
}
