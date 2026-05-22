import 'package:delivery_app/domain/repositories/category_repository.dart';
import 'package:delivery_app/domain/repositories/checkout_order_repository.dart';
import 'package:delivery_app/domain/repositories/commerce_repository.dart';
import 'package:delivery_app/domain/repositories/global_event_repository.dart';
import 'package:delivery_app/domain/repositories/local_event_repository.dart';
import 'package:delivery_app/domain/repositories/local_storage_repository.dart';
import 'package:delivery_app/domain/repositories/product_repository.dart';
import 'package:delivery_app/domain/repositories/request_event_repository.dart';
import 'package:delivery_app/domain/repositories/user_repository.dart';
import 'package:mocktail/mocktail.dart';

class CategoryRepositoryMock extends Mock implements CategoryRepository {}
class CheckoutOrderRepositoryMock extends Mock implements CheckoutOrderRepository {}
class CommerceRepositoryMock extends Mock implements CommerceRepository {}
class GlobalEventRepositoryMock extends Mock implements GlobalEventRepository {}
class LocalEventRepositoryMock extends Mock implements LocalEventRepository {}
class LocalStorageRepositoryMock extends Mock implements LocalStorageRepository {}
class ProductRepositoryMock extends Mock implements ProductRepository {}
class RequestEventRepositoryMock extends Mock implements RequestEventRepository {}
class UserRepositoryMock extends Mock implements UserRepository {}

