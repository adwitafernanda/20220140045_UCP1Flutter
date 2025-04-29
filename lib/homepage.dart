import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String nama;

  const HomePage({Key? key, required this.nama}) : super(key: key);
  

  @override
  State<HomePage> createState() => _HomePageState();
}