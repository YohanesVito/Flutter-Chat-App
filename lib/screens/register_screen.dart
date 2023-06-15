import 'package:flutter/material.dart';
import 'package:flutter_chat_app/constants/image_strings.dart';
import 'package:flutter_chat_app/constants/sizes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../constants/text_string.dart';
import '../providers/auth_provider.dart';
import '../service/firebase_service.dart';
import 'contact_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void navigateToContactScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ContactScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              // Bagian Header
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Image(
                    image: AssetImage(tRegisterScreenImage),
                    height: size.height * 0.2),
                Text(tRegisterTitle,
                    style: Theme.of(context).textTheme.headline6),
                Text(
                  tRegisterSubtitle,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ]),

              // Bagian Form
              Container(
                padding: EdgeInsets.symmetric(vertical: tFormHeight - 10),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: tEmail,
                            hintText: tEmail,
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder()),
                        onChanged: (value) {
                          // Update the email value using the provider
                          Provider.of<AuthProvider>(context, listen: false)
                              .setEmail(value);
                        },
                      ),
                      const SizedBox(
                        height: tFormHeight - 20,
                      ),
                      TextFormField(
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.fingerprint),
                            labelText: tPassword,
                            hintText: tPassword,
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: _togglePasswordVisibility,
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            )),
                        onChanged: (value) {
                          // Update the password value using the provider
                          Provider.of<AuthProvider>(context, listen: false)
                              .setPassword(value);
                        },
                      ),
                      const SizedBox(
                        height: tFormHeight - 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            // Get the email and password from the provider
                            final authProvider =
                            Provider.of<AuthProvider>(context, listen: false);
                            String emailAddress = authProvider.email;
                            String password = authProvider.password;

                            // Validate the email and password
                            if (emailAddress.isNotEmpty &&
                                password.isNotEmpty) {
                              // Call the sign-in function with the entered email and password
                              bool success =
                              await FirebaseService().createUserWithEmailAndPassword(context);

                              if (success) {
                                Fluttertoast.showToast(
                                    msg: "Register Berhasil",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    textColor: Colors.white,
                                    fontSize: 16.0);

                                // Handle the case when sign-in is successful, e.g., navigate to the next screen
                                navigateToContactScreen(context);
                              } else {
                                // Handle the case when sign-in fails, e.g., display an error message
                                Fluttertoast.showToast(
                                    msg: "Register Gagal",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            } else {
                              // Handle the case when the email or password is empty
                              Fluttertoast.showToast(
                                  msg: "Semua kolom wajib diisi!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(),
                              padding: EdgeInsets.symmetric(
                                  vertical: tButtonHeight)),
                          child: Text(tRegister.toUpperCase()),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
