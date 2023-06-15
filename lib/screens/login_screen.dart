import 'package:flutter/material.dart';
import 'package:flutter_chat_app/constants/image_strings.dart';
import 'package:flutter_chat_app/constants/sizes.dart';
import 'package:flutter_chat_app/constants/text_string.dart';
import 'package:flutter_chat_app/service/auth_service.dart';
import 'package:flutter_chat_app/service/firebase_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'contact_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Bagian 1
              LoginHeaderWidget(size, context),
              //  End of bagian 1

              //  Bagian 2 - Form
              LoginForm(),
              //End of Bagian 2

              //Bagian 3
              LoginFooterWidget(context),
              //End of Bagian 3
            ],
          ),
        ),
      )),
    );
  }

  Column LoginFooterWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR"),
        const SizedBox(
          height: tFormHeight - 20,
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
              icon: const Image(
                image: AssetImage(tSignInWithGoogleImage),
                width: 20.0,
              ),
              style: OutlinedButton.styleFrom(
                  shape: const RoundedRectangleBorder(),
                  padding: EdgeInsets.symmetric(vertical: tButtonHeight)),
              onPressed: () async {
                await AuthService().signInWithGoogle(context);
                navigateToContactScreen(context);
              },
              label: Text(tSignInWithGoogle)),
        ),
        const SizedBox(
          height: tFormHeight - 20,
        ),
        TextButton(
          onPressed: () {},
          child: Text.rich(
            TextSpan(
                text: tDontHaveAnAccount,
                style: Theme.of(context).textTheme.bodyText1,
                children: const [
                  TextSpan(text: tSignup, style: TextStyle(color: Colors.blue))
                ]),
          ),
        ),
      ],
    );
  }

  Column LoginHeaderWidget(Size size, BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Image(image: AssetImage(tLoginScreenImage), height: size.height * 0.2),
      Text(tLoginTitle, style: Theme.of(context).textTheme.headlineLarge),
      Text(
        tLoginSubtitle,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    ]);
  }

  Form LoginForm() {
    return Form(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: tEmail,
                hintText: tEmail,
                border: OutlineInputBorder()),
            onChanged: (value) {
              // Update the email value using the provider
              Provider.of<AuthProvider>(context, listen: false).setEmail(value);
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
                border: const OutlineInputBorder(),
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
              Provider.of<AuthProvider>(context, listen: false).setPassword(value);
            },
          ),
          const SizedBox(
            height: tFormHeight - 20,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: () {}, child: const Text(tForgetPassword)),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                // Get the email and password from the provider
                final authProvider = Provider.of<AuthProvider>(context, listen: false);
                String emailAddress = authProvider.email;
                String password = authProvider.password;

                // Validate the email and password
                if (emailAddress.isNotEmpty && password.isNotEmpty) {
                  // Call the sign-in function with the entered email and password
                  bool success = await FirebaseService().signInWithEmailAndPassword(context);

                  if (success) {
                    // Handle the case when sign-in is successful, e.g., navigate to the next screen
                    Fluttertoast.showToast(
                        msg: "Login Berhasil",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                    navigateToContactScreen(context);
                  } else {
                    // Handle the case when sign-in fails, e.g., display an error message
                    Fluttertoast.showToast(
                        msg: "Login Gagal",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                } else {
                  // Handle the case when the email or password is empty
                  Fluttertoast.showToast(
                      msg: "Semua kolom wajib diisi!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(),
                  padding: const EdgeInsets.symmetric(vertical: tButtonHeight)),
              child: Text(tLogin.toUpperCase()),
            ),
          )
        ],
      ),
    ));
  }
}
