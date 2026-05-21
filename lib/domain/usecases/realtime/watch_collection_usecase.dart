import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/data/datasources/base_firestore_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WatchCollectionUseCase<T> {
  final FirebaseFirestore firestore;
  final String collectionName;
  final T Function(Map<String, dynamic>) mapper;

  WatchCollectionUseCase({
    required this.firestore,
    required this.collectionName,
    required this.mapper,
  });

  /// Escucha todos los documentos de la colección en tiempo real.
  Stream<List<T>> call() {
    return firestore.collection(collectionName).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => mapper({...doc.data(), 'id': doc.id}))
              .toList(),
        );
  }

  /// Escucha documentos filtrados por un campo en tiempo real.
  Stream<List<T>> where(String field, dynamic value) {
    return firestore
        .collection(collectionName)
        .where(field, isEqualTo: value)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => mapper({...doc.data(), 'id': doc.id}))
              .toList(),
        );
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
    WatchCollectionUseCase,
    ({String collection, dynamic Function(Map<String, dynamic>) mapper})>(
  (ref, args) => WatchCollectionUseCase(
    firestore: ref.read(firebaseFirestoreProvider),
    collectionName: args.collection,
    mapper: args.mapper,
  ),
);
