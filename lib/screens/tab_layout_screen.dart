import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/register_screen.dart';
import 'login_screen.dart';

class TabLayoutScreen extends StatefulWidget {
  const TabLayoutScreen({Key? key}) : super(key: key);

  @override
  State<TabLayoutScreen> createState() => _TabLayoutScreenState();
}

class _TabLayoutScreenState extends State<TabLayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ChatApp'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Login'),
              Tab(text: 'Register'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            LoginScreen(),
            RegisterScreen(),
          ],
        ),
      ),
    );
  }
}
