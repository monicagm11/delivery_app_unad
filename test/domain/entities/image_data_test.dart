import 'package:delivery_app/domain/entities/image_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Verify properties of ImageData created correctly', () {
    ImageData model = ImageData(path: 'src/image.jpg', folder: 'tickets');
    expect(model.path, 'src/image.jpg');
    expect(model.folder, 'tickets');
    expect(model.bytes, isNull);
  });
}