import 'package:admin_project/constants/constant_colors.dart';
import 'package:admin_project/services/authenticate_service.dart';
import 'package:admin_project/views/pages/admin_page.dart';
import 'package:admin_project/views/pages/user_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SingIn extends StatefulWidget {
  const SingIn({
    Key? key,
  }) : super(key: key);

  @override
  State<SingIn> createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  late int _role;
  final AuthenticateService _auth = AuthenticateService();
  final bool _isLogin = true;
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _role = 0;
  }

  void onRoleChanged(int newRole) {
    setState(() {
      _role = newRole;
    });
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.value.text;
    final password = _passwordController.value.text;

    setState(() => _loading = true);

    try {
      // Check if is login or register
      if (_role == 2) {
        if (_loading) {
          print(email);
          print(password);
          await AuthenticateService()
              .signInWithEmailAndPassword(email, password);
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AdminHomePage()),
          );
        } else {
          await AuthenticateService()
              .registerWithEmailAndPassword(email, password);
        }
      } else if (_role == 1) {
        if (_loading) {
          print(email);
          print(password);
          await AuthenticateService()
              .signInWithEmailAndPassword(email, password);
          // AuthenticateService().addUserDetails(email, password);
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => UserHomePage()),
          );
        } else {
          await AuthenticateService()
              .registerWithEmailAndPassword(email, password);
        }
      }

      // Revert to the initial state
      setState(() => _loading = false);
    } catch (e) {
      print('Error: $e');
      setState(() => _loading = false);
    }
  }

  String _buttonText() {
    if (_role == 1) {
      return 'Log in as User';
    } else if (_role == 2) {
      return 'Log in as Admin';
    } else {
      return 'Log in';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(
          'Log in 🏕 CasaLoco',
          style: GoogleFonts.acme(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: Colors.deepOrangeAccent,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        'Log in',
                        style: GoogleFonts.acme(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    // Assign email controller
                    controller: _emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email!';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email address!';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      focusColor: Colors.black54,
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.deepOrange, width: 2),
                      ),
                    ),
                  ),
                  TextFormField(
                    // Assign password controller
                    controller: _passwordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password!';
                      }
                      if (value.length < 6) {
                        return 'Your password must be at least 6 characters long!';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      focusColor: Colors.black54,
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.deepOrange, width: 2),
                      ),
                    ),
                  ),
                  RadioListTile(
                    title: const Text('User'),
                    value: 1,
                    groupValue: _role,
                    onChanged: (value) {
                      setState(() {
                        _role = value as int;
                        onRoleChanged(_role);
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Admin'),
                    value: 2,
                    groupValue: _role,
                    onChanged: (value) {
                      setState(() {
                        _role = value as int;
                        onRoleChanged(_role);
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                    ),
                    onPressed: () => handleSubmit(),
                    child: _loading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.black87,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(_buttonText()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
