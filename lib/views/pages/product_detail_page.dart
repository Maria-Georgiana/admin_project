import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductWidgetPage extends StatefulWidget {
  final String address;
  final String description;
  final String imagePath;

  const ProductWidgetPage({
    Key? key,
    required this.address,
    required this.description,
    required this.imagePath,
  }) : super(key: key);

  @override
  State<ProductWidgetPage> createState() => _ProductWidgetPageState();
}

class _ProductWidgetPageState extends State<ProductWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          // schimbati culoarea fundalului dupa preferinte
          title: Text(
            'CasaLoco',
            style: GoogleFonts.acme(
              fontSize: 32,
              fontWeight: FontWeight.w400,
              color: Colors.deepOrangeAccent,
            ),
          ),
        ),
        backgroundColor: Colors.grey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Address: ${widget.address}',
                style: GoogleFonts.acme(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(5, 5),
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(widget.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Description: ${widget.description}',
                style: GoogleFonts.acme(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        )
    );
  }
}
