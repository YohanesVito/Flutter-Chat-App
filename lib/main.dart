import 'package:flutter/material.dart';
import 'package:flutter_chat_app/providers/user_provider.dart';
import 'package:flutter_chat_app/screens/chat_screen.dart';
import 'package:flutter_chat_app/screens/contact_screen.dart';
import 'package:flutter_chat_app/screens/login_screen.dart';
import 'package:flutter_chat_app/screens/main_tab_screen.dart';
import 'package:flutter_chat_app/screens/profile_screen.dart';
import 'package:flutter_chat_app/screens/register_screen.dart';
import 'package:flutter_chat_app/screens/tab_layout_screen.dart';
import 'package:flutter_chat_app/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

import 'constants/colors.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
    ],
    child: const ChatApp(),
  ));
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
        colorScheme: darkColorScheme,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),

      ),
      theme: ThemeData(
        colorScheme: lightColorScheme,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
      ),
      initialRoute: '/',
      title: 'Chat-App',

      routes: {
        '/': (context) => const WelcomeScreen(),
        '/main': (context) => const TabLayoutScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/contact': (context) => const ContactScreen(),
        '/chat': (context) => const ChatScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
