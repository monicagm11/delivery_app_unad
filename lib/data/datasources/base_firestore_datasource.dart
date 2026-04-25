import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaseFirestoreDatasource<T> {
  final FirebaseFirestore firestore;
  final String collectionName;

  const BaseFirestoreDatasource(
      {required this.firestore, required this.collectionName});

  Future<List<T>?> fetchAll(T Function(Map<String, dynamic>) mapper) async {
    try {
      final snapshot = await firestore.collection(collectionName).get();
      return snapshot.docs.map((e) => mapper({...e.data(), 'id': e.id})).toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> add(Map<String, dynamic> data) async {
    try {
      data.remove('id');
      await firestore.collection(collectionName).add(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<T>?> fetchWhere(T Function(Map<String, dynamic>) mapper, String keyWhere, dynamic where) async {
    try {
      final snapshot = await firestore.collection(collectionName).where(keyWhere, isEqualTo: where).get();
      return snapshot.docs.map((e) => mapper({...e.data(), 'id': e.id})).toList();
    } catch (_) {
      return [];
    }
  }

  Future<T?> findById(String id, T Function(Map<String, dynamic>) mapper) async {
    try {
      final doc =
          await firestore.collection(collectionName).doc(id).get();
      if (!doc.exists || doc.data() == null) return null;
      return mapper(doc.data()!);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateDoc(String id, Map<String, dynamic> map) async {
    try {
      map.remove('id');
      await firestore.collection(collectionName).doc(id).update(map);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<T>> fetchByIds(
      List<String> ids, T Function(Map<String, dynamic>) mapper) async {
    if (ids.isEmpty) return [];
    try {
      const chunkSize = 30;
      final results = <T>[];
      for (var i = 0; i < ids.length; i += chunkSize) {
        final chunk = ids.sublist(i, (i + chunkSize).clamp(0, ids.length));
        final snapshot = await firestore
            .collection(collectionName)
            .where(FieldPath.documentId, whereIn: chunk)
            .get();
        results.addAll(
          snapshot.docs.map((e) => mapper({...e.data(), 'id': e.id})),
        );
      }
      return results;
    } catch (e) {
      rethrow;
    }
  }
}

final firebaseFirestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);
