import 'dart:math';

import 'package:admin_project/constants/constant_colors.dart';
import 'package:admin_project/models/house_model.dart';
import 'package:admin_project/views/authenticate/sing_in.dart';
import 'package:admin_project/views/widgets/filter_widget.dart';
import 'package:admin_project/views/widgets/product_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<UserHomePage> {
  final _ref = FirebaseFirestore.instance.collection('products');
  late Stream<QuerySnapshot> _streamHouseItems;
  final filterList = ['<\$100.000', '1 bedroom', '2 bedrooms', '2 kitchens'];
  List<House> houseList = [];

  bool isClicked = false;

  onPressed() {
    setState(() {
      isClicked = !isClicked;
    });
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    super.initState();
    _streamHouseItems = _ref.snapshots();
  }

  Future<void> _loadHouses() async {
    QuerySnapshot snapshot = await _ref.get();
    final List<House> houses = [];
    snapshot.docs.forEach((doc) {
      final house = House.fromJson(doc.data() as Map<String, dynamic>);
      houses.add(house);
    });
    setState(() {
      houseList = houses;
    });
    print('House length: ${houseList.length}');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
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
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pressed menu button')));
            },
            icon: const Icon(
              Icons.menu_open,
              color: ConstantColors.secondary,
            ),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pressed refresh button')));
            },
            icon: const Icon(
              Icons.refresh,
              color: ConstantColors.secondary,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SingIn()),
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black12),
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 32, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(5, 5),
                      )
                    ]),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      hintText: 'City',
                      hintStyle: TextStyle(color: ConstantColors.primary),
                      fillColor: Colors.black12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Divider(
                color: Colors.black54,
                thickness: .8, //grosimea
              ),
              //Scroll orizontal
              SizedBox(
                height: 30,
                // adaugam mai multe obiecte
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filterList.length,
                  itemBuilder: (context, index) {
                    return FilterWidget(
                      filterText: filterList[index],
                      isClicked: isClicked ? true : false,
                    );
                  },
                ),
              ),
              // const SizedBox(height: 2),
              StreamBuilder<List<House>>(
                stream: _ref.snapshots().map((querySnapshot) =>
                    querySnapshot.docs.map((doc) => House.fromJson(doc.data())).toList()
                ),
                builder: (BuildContext context, AsyncSnapshot<List<House>> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }
                  if (snapshot.connectionState == ConnectionState.active) {
                    List<House> houseList = snapshot.data ?? [];
                    return Column(
                      children: [
                        for (House house in houseList)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ProductWidget(house: house),
                          ),
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
