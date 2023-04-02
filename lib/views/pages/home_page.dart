import 'package:admin_project/constants/constant_colors.dart';
import 'package:admin_project/constants/constant_strings.dart';
import 'package:admin_project/views/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static bool isPriceValid = false;
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ConstantStrings.title),
        titleTextStyle: const TextStyle(
            color: ConstantColors.textColor, fontWeight: FontWeight.w700),
        backgroundColor: ConstantColors.secondary,
      ),
      body: Column(
        children: [
          TextFieldWidget(
              controller: controller,
              hintText: ConstantStrings.housePriceHint,
              maxLength: 5,
              maxLines: 1,
              inputType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
