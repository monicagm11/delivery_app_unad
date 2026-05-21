import 'package:delivery_app/domain/entities/calculator_price_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Verify properties of CalculatorPriceData created correctly', () {
    CalculatorPriceData model = CalculatorPriceData(priceBase: 10000, priceTotal: 11900, ivaPercentage: 19, ivaValue: 1900);
    expect(model.priceBase, 10000);
    expect(model.priceTotal, 11900);
    expect(model.ivaPercentage, 19);
    expect(model.ivaValue, 1900);
  });
}