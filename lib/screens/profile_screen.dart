
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/constants/image_strings.dart';
import 'package:flutter_chat_app/constants/sizes.dart';
import 'package:flutter_chat_app/constants/text_string.dart';
import 'package:flutter_chat_app/screens/contact_screen.dart';
import 'package:flutter_chat_app/screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  //navigation
  void navigateToContactScreen(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ContactScreen(),
      ),
    );
  }

  //navigation
  void navigateToLoginScreen(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          navigateToContactScreen(context);
        },
          icon: Icon(Icons.arrow_back),),
        title: Text(tProfile),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200), child: const Image(image: AssetImage(tProfileImage)),
                ),

              ),
              const SizedBox(height: 10,),
              Text(tProfileHeading,style: Theme.of(context).textTheme.headlineLarge,),
              Text(tProfileSubHeading,style: Theme.of(context).textTheme.bodyMedium,),
              const SizedBox(height: 20,),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    side: BorderSide.none,
                    shape: const StadiumBorder(),
                  ),
                  child: Text(tEditProfile.toUpperCase(),),
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: 200,
                child: OutlinedButton(
                    onPressed: () {
                      navigateToLoginScreen(context);
                    },
                    style: OutlinedButton.styleFrom(
                        side: BorderSide.none,
                        shape: const StadiumBorder(),
                        ),
                    child: Text(tLogout.toUpperCase()))
              ),
              const SizedBox(height: 30,),
              const Divider(),
              const SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }
}
