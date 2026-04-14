import 'package:delivery_app/domain/entities/calculator_price_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PriceCalculatorFormField extends FormField<CalculatorPriceData> {
  PriceCalculatorFormField({
    super.key,
    super.initialValue,
    super.onSaved,
    super.validator,
    this.isEnabled = true
  }) : super(
          builder: (state) {
            return _PriceCalculatorField(state: state, isEnabled: isEnabled,);
          },
        );
  final bool isEnabled;
}

class _PriceCalculatorField extends StatefulWidget {
  final FormFieldState<CalculatorPriceData> state;
  final bool isEnabled;
  const _PriceCalculatorField({required  this.state, required this.isEnabled});

  @override
  State<_PriceCalculatorField> createState() => _PriceCalculatorFieldState();
}

class _PriceCalculatorFieldState extends State<_PriceCalculatorField> {
  late double priceBase, priceTotal, ivaPercentage, ivaValue;
  late TextEditingController priceBaseController, priceTotalController, ivaPercentageController, ivaValueController;
  late final bool isEnabled;

  @override
  void initState() {
    super.initState();
    priceBase = widget.state.value?.priceBase ?? 0;
    priceTotal = widget.state.value?.priceTotal ?? 0;
    ivaPercentage = widget.state.value?.ivaPercentage ?? 0;
    ivaValue = widget.state.value?.ivaValue ?? 0;

    priceBaseController = TextEditingController(text: priceBase.toString());
    priceTotalController = TextEditingController(text: priceTotal.toString());
    ivaPercentageController = TextEditingController(text: ivaPercentage.toString());
    ivaValueController = TextEditingController(text: ivaValue.toString());

    isEnabled = widget.isEnabled;
  }

  void _update() {
      String price = priceBaseController.text.trim().isEmpty ? '0' : priceBaseController.text;
      String iva = ivaPercentageController.text.trim().isEmpty ? '0' : ivaPercentageController.text;

      priceBase = double.parse(price);
      ivaPercentage= double.parse(iva);
      ivaValue = (priceBase * ivaPercentage /100).roundToDouble();
      priceTotal = (priceBase + ivaValue).roundToDouble();
      ivaValueController.text = ivaValue.toString();
      priceTotalController.text = priceTotal.toString();
    widget.state.didChange(
      CalculatorPriceData(
        priceBase: priceBase,
        priceTotal: priceTotal,
        ivaPercentage: ivaPercentage,
        ivaValue: ivaValue
      ),
    );
    Form.of(context).validate();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        TextField(
          controller: priceBaseController,
          enabled: isEnabled,
          keyboardType: const TextInputType.numberWithOptions(decimal: false),
          onChanged: (_) => _update(),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            ],
          decoration: InputDecoration(
            errorText: widget.state.errorText,
            label: Text('Precio base (COP)')
          ),
        ),
        TextField(
          controller: ivaPercentageController,
          enabled: isEnabled,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
            ],
          onChanged: (_) => _update(),
          decoration: InputDecoration(
            errorText: widget.state.errorText,
            label: Text('% IVA')
          ),
        ),
        TextField(
          controller: ivaValueController,
          enabled: false,
          decoration: InputDecoration(
            errorText: widget.state.errorText,
            label: Text('Valor IVA (COP)')
          ),
        ),
        TextField(
          controller: priceTotalController,
          enabled: false,
          decoration: InputDecoration(
            errorText: widget.state.errorText,
            label: Text('Precio Total (COP)')
          ),
        ),
      ],
    );
  }
}