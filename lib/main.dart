import 'package:flutter/material.dart';
import 'package:ucp1/datapiketpage.dart';
import 'package:ucp1/homepage.dart';
import 'package:ucp1/loginpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) =>  HomePage(nama: '',),
        '/piket' : (context) => const DataPiket(nama:''),
      },
    );
  }
}
