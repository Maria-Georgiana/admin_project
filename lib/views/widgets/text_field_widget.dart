import 'package:admin_project/constants/constant_colors.dart';
import 'package:admin_project/constants/constant_strings.dart';
import 'package:admin_project/views/pages/admin_page.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLength, maxLines;
  final TextInputType inputType;

  const TextFieldWidget(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.maxLength,
      required this.maxLines,
      this.inputType = TextInputType.text})
      : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      keyboardType: widget.inputType,
      style: const TextStyle(
        color: ConstantColors.primary,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      decoration: InputDecoration(
          errorText: _getErrorText,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: ConstantColors.textColor.withAlpha(80))),
      onChanged: (text) => setState(() {
        // setState o apelam pentru a putea actualiza si ui-ul, altfel nu o sa vedem pe ecran schimbartile doar daca oprim aplicatia si o pornim din nou
        if (_getErrorText == null) {
          //Acualizam o variabila pagina home, care indica faptul ca valoarea introdusa este valida
          validateInput(true);
        } else {
          validateInput(false);
        }
      }),
    );
  }

  validateInput(bool boolValue) {
    switch (widget.hintText) {
      case ConstantStrings.housePriceHint:
        AdminHomePage.isPriceValid = boolValue;
        break;
      case ConstantStrings.houseBedrooms:
        AdminHomePage.areBedroomValid = boolValue;
        break;
      case ConstantStrings.houseStreetHint:
        AdminHomePage.isStreetValid = boolValue;
        break;
      case ConstantStrings.houseDescription:
        AdminHomePage.isDescriptionValid = boolValue;
        break;
      case ConstantStrings.houseSquareMeters:
        AdminHomePage.isSquareMetersValid = boolValue;
        break;
    }
  }

  String? get _getErrorText {
    final text = widget.controller.value
        .text; // accesam valoaarea din interiorul controllerului

    if (text.isEmpty || text.trim().isEmpty) {
      return 'Filed can\'t be empty';
    }

    if (widget.inputType == TextInputType.number) {
      //tryParse ne return null daca a fost un caracter special/litera si nu poate fi convertit in int
      if (int.tryParse(text) == null) {
        return 'Field can\'t contain letters';
      }
      if (widget.hintText == ConstantStrings.housePriceHint) {
        if (int.parse(text) > 15000000) {
          return 'House price can\'t be higher than \$15.000.000';
        }
      }
    }
    return null;
  }
}
