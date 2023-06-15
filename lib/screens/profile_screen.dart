import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/constants/sizes.dart';
import 'package:flutter_chat_app/constants/text_string.dart';
import 'package:flutter_chat_app/providers/auth_provider.dart';
import 'package:flutter_chat_app/screens/contact_screen.dart';
import 'package:flutter_chat_app/screens/tab_layout_screen.dart';
import 'package:flutter_chat_app/service/firebase_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //navigation
  void navigateToContactScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ContactScreen(),
      ),
    );
  }


  //navigation
  void navigateToLoginScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TabLayoutScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            navigateToContactScreen(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(tProfile),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Consumer<AuthProvider>(
            builder: (context, authProvider, _) {
              return Column(
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: FirebaseAuth.instance.currentUser!.photoURL != null
                          ? Image.network(
                        FirebaseAuth.instance.currentUser!.photoURL!,
                        fit: BoxFit.cover,
                      )
                          : FadeInImage.assetNetwork(
                        image: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                        fit: BoxFit.cover,
                        placeholder: '',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser!.email!.substring(0, FirebaseAuth.instance.currentUser!.email!.indexOf('@')),
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser!.email!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: 200,
                      child: OutlinedButton(
                          onPressed: () {
                            navigateToLoginScreen(context);
                            FirebaseAuth.instance.signOut();
                            GoogleSignIn().signOut();
                            FirebaseService().signOut(context);
                            Fluttertoast.showToast(
                                msg: "Logout Berhasil",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide.none,
                            shape: const StadiumBorder(),
                          ),
                          child: Text(tLogout.toUpperCase()))),
                  const SizedBox(
                    height: 30,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
