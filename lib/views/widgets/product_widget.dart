import 'package:admin_project/models/house_model.dart';
import 'package:admin_project/views/pages/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductWidget extends StatefulWidget {
  final House house;

  const ProductWidget({Key? key, required this.house}) : super(key: key);

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      height: 400,
      decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 2,
              offset: const Offset(5, 5),
            )
          ]
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductWidgetPage(
                    address: widget.house.address,
                    description: widget.house.description,
                    imagePath: widget.house.imagePath,
                  ),
                ),
              );
            },
            child: Container(
              alignment: Alignment.center,
              height: 280,
              width: 280,
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(widget.house.imagePath),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Price:    ${widget.house.price} €',
                          style: GoogleFonts.acme(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white54,
                          ),
                        ),
                        Text(
                          'Bedrooms:   ${widget.house.bedrooms}',
                          style: GoogleFonts.acme(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white54,
                          ),
                        ),
                        Text(
                          'Square Meters:      ${widget.house.squareMeters} m2',
                          style: GoogleFonts.acme(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 2,
                        color: Colors.grey,
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: isFavorited ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          isFavorited = !isFavorited;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
