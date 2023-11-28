import 'package:flutter/material.dart';
import 'package:prova_flutter_bruno_gambeta/screens/captured/captured_info_screen.dart';

import 'screens/login/login_screen.dart';
import 'theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/captured': (context) => const CapturedInfoScreen(),

        //  '/privacy_policy': (context) => PrivacyPolicyPage(),
      },
    );
  }
}
