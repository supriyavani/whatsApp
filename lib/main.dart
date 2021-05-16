import 'package:flutter/material.dart';
import 'package:whats_app/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp',
      theme: ThemeData(
        
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(),
     debugShowCheckedModeBanner: false,
    );
  }
}

