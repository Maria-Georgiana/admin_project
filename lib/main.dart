import 'package:admin_project/constants/constant_strings.dart';
import 'package:admin_project/firebase_options.dart';
import 'package:admin_project/views/authenticate/sing_in.dart';
import 'package:admin_project/views/pages/user_page.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'views/pages/admin_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: ConstantStrings.title,
      // home: StreamBuilder<User?>(
        // stream: FirebaseAuth.instance.authStateChanges(),
        // builder: (context, snapshot) {
        //   // if user is logged in
        //   if (snapshot.hasData) {
        //     User? user = snapshot.data;
        //     // Check if user has admin role
        //     if (user != null && user.uid == "admin-uid") {
        //       return AdminHomePage();
        //     }
        //     // Otherwise, user has user role
        //     return UserHomePage();
        //   }
        //   // if user is not logged in
        //   else {
        home: SingIn()
          // }
        // },
      // ),
    );
  }
}