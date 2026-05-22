import 'package:delivery_app/data/datasources/category_datasource.dart';
import 'package:delivery_app/data/datasources/checkout_order_datasource.dart';
import 'package:delivery_app/data/datasources/commerce_datasource.dart';
import 'package:delivery_app/data/datasources/global_event_datasource.dart';
import 'package:delivery_app/data/datasources/local_event_datasource.dart';
import 'package:delivery_app/data/datasources/local_storage_datasource.dart';
import 'package:delivery_app/data/datasources/product_datasource.dart';
import 'package:delivery_app/data/datasources/request_event_datasource.dart';
import 'package:delivery_app/data/datasources/user_datasource.dart';
import 'package:mocktail/mocktail.dart';

class CategoryDatasourceMock extends Mock implements CategoryDatasource {}
class CheckoutOrderDatasourceMock extends Mock implements CheckoutOrderDatasource {}
class CommerceDatasourceMock extends Mock implements CommerceDatasource {}
class GlobalEventDatasourceMock extends Mock implements GlobalEventDatasource {}
class LocalEventDatasourceMock extends Mock implements LocalEventDatasource {}
class LocalStorageDatasourceMock extends Mock implements LocalStorageDatasource {}
class ProductDatasourceMock extends Mock implements ProductDatasource {}
class RequestEventDatasourceMock extends Mock implements RequestEventDatasource {}
class UserDatasourceMock extends Mock implements UserDatasource {}