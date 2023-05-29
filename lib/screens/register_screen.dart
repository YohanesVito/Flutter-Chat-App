import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/constants/image_strings.dart';
import 'package:flutter_chat_app/constants/sizes.dart';

import '../constants/text_string.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              //Bagian Header
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Image(
                    image: AssetImage(tRegisterScreenImage),
                    height: size.height * 0.2),
                Text(tRegisterTitle,
                    style: Theme.of(context).textTheme.headlineLarge),
                Text(
                  tRegisterSubtitle,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ]),

              //Bagian Form
              Container(
                padding: EdgeInsets.symmetric(vertical: tFormHeight -10),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text(tUsername),
                          prefixIcon: Icon(Icons.person_outline_rounded,),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0,)
                          )
                        ),
                      ),
                      const SizedBox(height: tFormHeight-20,),
                      TextFormField(
                        decoration: InputDecoration(
                            label: Text(tEmail),
                            prefixIcon: Icon(Icons.email_outlined,),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2.0,)
                            )
                        ),
                      ),
                      const SizedBox(height: tFormHeight-20,),
                      TextFormField(
                        decoration: InputDecoration(
                            label: Text(tPassword),
                            prefixIcon: Icon(Icons.fingerprint,),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2.0,)
                            )
                        ),
                      ),
                      const SizedBox(height: tFormHeight-20,),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {

                          },
                          child: Text(tRegister.toUpperCase()),
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(),
                              padding: EdgeInsets.symmetric(vertical: tButtonHeight)),
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
