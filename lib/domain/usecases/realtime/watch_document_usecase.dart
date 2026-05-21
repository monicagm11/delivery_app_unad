import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/data/datasources/base_firestore_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WatchDocumentUsecase<T> {
  final FirebaseFirestore firestore;
  final String collectionName;
  final T Function(Map<String, dynamic>) mapper;

  WatchDocumentUsecase({
    required this.firestore,
    required this.collectionName,
    required this.mapper,
  });

  /// Escucha documentos filtrados por un campo en tiempo real.
  Stream<T?> where(String id) {
    return firestore
        .collection(collectionName)
        .doc(id)
        .snapshots()
        .map((doc) {
        if (!doc.exists) return null;

        return mapper(
          {...doc.data() as Map<String, dynamic>, 'id': doc.id},
        );
      });
  }
}

/// Provider factory — crea un WatchCollectionUseCase para cualquier colección.
/// Uso:
/// ```dart
/// final useCase = ref.read(
///   watchCollectionUseCaseProvider((
///     collection: 'checkout_orders',
///     mapper: CheckoutOrderModel.fromMap,
///   ))
/// );
/// ```
final watchCollectionUseCaseProvider = Provider.family<
    WatchDocumentUsecase,
    ({String collection, dynamic Function(Map<String, dynamic>) mapper})>(
  (ref, args) => WatchDocumentUsecase(
    firestore: ref.read(firebaseFirestoreProvider),
    collectionName: args.collection,
    mapper: args.mapper,
  ),
);
