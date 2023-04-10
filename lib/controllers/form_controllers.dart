import 'package:flutter/material.dart';

class FormControllers{
  final TextEditingController housePriceController = TextEditingController();
  final TextEditingController bedroomsController = TextEditingController();
  final TextEditingController streetInfoController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController squareMetersController = TextEditingController();
  final TextEditingController imagePathController = TextEditingController();

  resetController(){
    housePriceController.clear();
    bedroomsController.clear();
    streetInfoController.clear();
    descriptionController.clear();
    squareMetersController.clear();
    imagePathController.clear();
  }
}