import 'package:flutter/material.dart';
import 'package:allia_health/ApiManager.dart';
import 'package:allia_health/AuthenticationManager.dart';
import 'package:allia_health/SelfReportQuestionsScreen.dart';
import 'package:allia_health/SubmitAnswersScreen.dart';
import 'package:allia_health/LoginScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationManager()),
        ProxyProvider<AuthenticationManager, ApiManager>(
          update: (_, authManager, __) => ApiManager(),
        ),
      ],
      child: MaterialApp(
        title: 'Your App',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/questions': (context) => SelfReportQuestionsScreen(),
          '/submit': (context) => SubmitAnswersScreen([]),
        },
      ),
    );
  }
}
