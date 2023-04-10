import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterWidget extends StatefulWidget {
  final String filterText;
  final bool isClicked;

  const FilterWidget({Key? key, required this.filterText, required this.isClicked}) : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        decoration: BoxDecoration(
            color: widget.isClicked ? Colors.black87 : Colors.deepOrangeAccent,
            borderRadius: BorderRadius.circular(16)
        ),
        height: 50,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.filterText,
              style: GoogleFonts.acme(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: widget.isClicked ? Colors.deepOrange : Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
