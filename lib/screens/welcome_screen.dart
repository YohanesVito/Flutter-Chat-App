import 'package:flutter/material.dart';
import 'package:flutter_chat_app/constants/image_strings.dart';
import 'package:flutter_chat_app/constants/sizes.dart';
import 'package:flutter_chat_app/constants/text_string.dart';
import 'package:flutter_chat_app/screens/login_screen.dart';
import 'package:flutter_chat_app/screens/main_tab_screen.dart';
import 'package:flutter_chat_app/screens/register_screen.dart';
import 'package:flutter_chat_app/screens/tab_layout_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  //navigation
  void navigateToMainScreen(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TabLayoutScreen(),
      ),
    );
  }

  void navigateToRegisterScreen(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterScreen(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(tDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: AssetImage(tWelcomeScreenImage),
              height: height * 0.6,
            ),
            Column(
              children: [
                Text(
                  tWelcomeTitle,
                  style: Theme.of(context).textTheme.headline3,
                ),
                Text(
                  tWelcomeSubTitle,
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: OutlinedButton(
                        onPressed: () {
                          navigateToMainScreen(context);
                        },
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(),
                            padding:
                            EdgeInsets.symmetric(vertical: tButtonHeight)),
                        child: Text(tLogin.toUpperCase()))),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      navigateToRegisterScreen(context);
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
          ],
        ),
      ),
    );
  }
}

