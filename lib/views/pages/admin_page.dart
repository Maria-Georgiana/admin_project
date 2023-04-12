import 'package:admin_project/constants/constant_colors.dart';
import 'package:admin_project/constants/constant_strings.dart';
import 'package:admin_project/controllers/form_controllers.dart';
import 'package:admin_project/models/house_model.dart';
import 'package:admin_project/views/authenticate/sing_in.dart';
import 'package:admin_project/views/pages/user_page.dart';
import 'package:admin_project/views/widgets/text_field_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AdminHomePage extends StatefulWidget {
  static bool isPriceValid = false,
      isStreetValid = false,
      areBedroomValid = false,
      isDescriptionValid = false,
      isSquareMetersValid = false;

  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final FormControllers _formControllers = FormControllers();
  final _ref = FirebaseFirestore.instance.collection('products');

  List<XFile> images = [];
  List<String> houseIDs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        // schimbati culoarea fundalului dupa preferinte
        title: Text(
          'CasaLoco~Admin',
          style: GoogleFonts.acme(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.deepOrangeAccent,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AdminHomePage()),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pressed refresh button')));
            },
            icon: const Icon(
              Icons.refresh,
              color: ConstantColors.secondary,
            ),
          ),
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const UserHomePage()),
              );
            },
            icon: const Icon(
              Icons.format_list_bulleted_rounded,
              color: ConstantColors.secondary,
            ),
          ),
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SingIn()),
              );
            },
            icon: const Icon(
              Icons.logout_rounded,
              color: ConstantColors.secondary,
            ),
          ),
        ],
      ),
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextFieldWidget(
              controller: _formControllers.housePriceController,
              hintText: ConstantStrings.housePriceHint,
              maxLength: 10,
              maxLines: 1,
              inputType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextFieldWidget(
              controller: _formControllers.bedroomsController,
              hintText: ConstantStrings.houseBedrooms,
              maxLength: 3,
              maxLines: 1,
              inputType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextFieldWidget(
              controller: _formControllers.streetInfoController,
              hintText: ConstantStrings.houseStreetHint,
              maxLength: 30,
              maxLines: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextFieldWidget(
              controller: _formControllers.descriptionController,
              hintText: ConstantStrings.houseDescription,
              maxLength: 30,
              maxLines: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextFieldWidget(
              controller: _formControllers.squareMetersController,
              hintText: ConstantStrings.houseSquareMeters,
              maxLength: 30,
              maxLines: 1,
              inputType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30, left: 30, right: 30),
            child: TextFieldWidget(
              controller: _formControllers.imagePathController,
              hintText: ConstantStrings.houseImagePath,
              maxLength: 200,
              maxLines: 1,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                //button
                onTap: () {
                  if (areFieldsValid()) {
                    setState(() {
                      addHome();
                    });
                  }
                },
                child: Container(
                  color: ConstantColors.secondary,
                  height: 50,
                  width: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text(
                        "ADD",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white54),
                      ),
                      Icon(
                        Icons.add_business_outlined,
                        size: 32,
                        color: Colors.white54,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  bool areFieldsValid() {
    return AdminHomePage.isPriceValid &&
        AdminHomePage.isStreetValid &&
        AdminHomePage.areBedroomValid &&
        AdminHomePage.isDescriptionValid &&
        AdminHomePage.isSquareMetersValid;
  }

  void addHome() async {
    try {
      // Creează un obiect House pe baza valorilor introduse
      House house = House(
        price: int.parse(_formControllers.housePriceController.text),
        address: _formControllers.streetInfoController.text,
        description: _formControllers.descriptionController.text,
        bedrooms: int.parse(_formControllers.bedroomsController.text),
        squareMeters: int.parse(_formControllers.squareMetersController.text),
        imagePath: _formControllers.imagePathController.text,
      );
      _formControllers.resetController();
      // Add object in Firebase database
      await _ref.add(house.toJson());
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('House added successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Failed to add house')));
    }
  }

  void resetBoolFields() {
    AdminHomePage.isPriceValid = false;
    AdminHomePage.isStreetValid = false;
    AdminHomePage.isDescriptionValid = false;
    AdminHomePage.areBedroomValid = false;
    AdminHomePage.isSquareMetersValid = false;
  }
//
// void pickAnImage() async {
//   var image = await ImagePicker().pickImage(source: ImageSource.gallery);
//
//   image != null ? images.add(image) : null;
// }
}
