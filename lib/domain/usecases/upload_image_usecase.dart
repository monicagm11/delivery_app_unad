import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadImageUseCase {
  final FirebaseStorage storage;

  UploadImageUseCase({required this.storage});

  /// [path]   : ruta local en móvil o nombre de archivo en web
  /// [bytes]  : bytes de la imagen (requerido en web, opcional en móvil)
  /// [folder] : carpeta destino en Storage, ej: 'products'
  /// Retorna la URL de descarga pública.
  Future<String> call({
    required String path,
    Uint8List? bytes,
    String folder = 'images',
  }) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}_${path.split('/').last}';
    final ref = storage.ref().child('$folder/$fileName');

    if (kIsWeb) {
      if (bytes == null) throw ArgumentError('bytes requerido en web');
      await ref.putData(bytes, SettableMetadata(contentType: 'image/jpeg'));
    } else {
      await ref.putFile(File(path));
    }

    return await ref.getDownloadURL();
  }
}

final firebaseStorageProvider =
    Provider<FirebaseStorage>((ref) => FirebaseStorage.instance);

final uploadImageUseCaseProvider = Provider<UploadImageUseCase>((ref) {
  return UploadImageUseCase(storage: ref.read(firebaseStorageProvider));
});
