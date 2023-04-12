import 'package:admin_project/models/house_model.dart';
import 'package:admin_project/views/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterWidget extends StatefulWidget {
  final String filterText;
  final bool isClicked;
  final VoidCallback onTap;

  const FilterWidget({
    Key? key,
    required this.filterText,
    required this.isClicked,
    required this.onTap,
  }) : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  bool _isClicked = false;

  @override
  void initState() {
    super.initState();
    _isClicked = widget.isClicked;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isClicked = !_isClicked;
          });
          widget.onTap();
        },
        child: Container(
          decoration: BoxDecoration(
            color: _isClicked ? Colors.black87 : Colors.deepOrangeAccent,
            borderRadius: BorderRadius.circular(16),
          ),
          height: 50,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.filterText,
                style: GoogleFonts.acme(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: _isClicked ? Colors.deepOrange : Colors.black87,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
