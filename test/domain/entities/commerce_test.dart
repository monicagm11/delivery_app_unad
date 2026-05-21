import 'package:delivery_app/data/models/commerce_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {
  test('Verify properties of CommerceModel created correctly', () {
    CommerceModel model = Mocks.commerceModelMock;
    expect(model.id, 'ADGF234');
    expect(model.name, 'Pizzeria MyG');
    expect(model.document, '123456');
    expect(model.identificationType, 'NIT');
    expect(model.phone, '3001234567');
    expect(model.address, 'CL 1 2-3');
    expect(model.email, 'ejemplo@gmail.com');
    expect(model.department, 'ATLANTICO');
    expect(model.city, 'BARRANQUILLA');
    expect(model.status, 'ACTIVO');
    expect(model.contactName, 'Samanta Collazos');
    expect(model.urlImage, 'http://www.ejemplo.com/ejemplo.jpg');
    expect(model.urlImageQR, 'http://www.ejemplo.com/logo.jpg');
    expect(model.fullDocument, 'NIT 123456');
  });

  test('Verify properties of CommerceModel created correctly', () {
    Map<String, dynamic> map = Mocks.mapCommerceMock;

    CommerceModel model = CommerceModel.fromMap(map);
    expect(model.id, 'ADGF234');
    expect(model.name, 'Pizzeria MyG');
    expect(model.document, '123456');
    expect(model.identificationType, 'NIT');
    expect(model.phone, '3001234567');
    expect(model.address, 'CL 1 2-3');
    expect(model.email, 'ejemplo@gmail.com');
    expect(model.department, 'ATLANTICO');
    expect(model.city, 'BARRANQUILLA');
    expect(model.status, 'ACTIVO');
    expect(model.contactName, 'Samanta Collazos');
    expect(model.urlImage, 'http://www.ejemplo.com/ejemplo.jpg');
    expect(model.urlImageQR, 'http://www.ejemplo.com/logo.jpg');
    expect(model.fullDocument, 'NIT 123456');
  });

  test('Verify properties of Map created from CommerceModel', () {
    CommerceModel model = Mocks.commerceModelMock;
    Map<String, dynamic> map = model.toMap();
    expect(map['id'], 'ADGF234');
    expect(map['name'], 'Pizzeria MyG');
    expect(map['document'], '123456');
    expect(map['identificationType'], 'NIT');
    expect(map['phone'], '3001234567');
    expect(map['address'], 'CL 1 2-3');
    expect(map['email'], 'ejemplo@gmail.com');
    expect(map['department'], 'ATLANTICO');
    expect(map['city'], 'BARRANQUILLA');
    expect(map['status'], 'ACTIVO');
    expect(map['contactName'], 'Samanta Collazos');
    expect(map['urlImage'], 'http://www.ejemplo.com/ejemplo.jpg');
    expect(map['urlImageQR'], 'http://www.ejemplo.com/logo.jpg');
    expect(map['fullDocument'], 'NIT 123456');
  });
}