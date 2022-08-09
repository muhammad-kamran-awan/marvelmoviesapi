import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mcu_api/home_screen.dart';

void main() {
  runApp(MCUAPI());
}

class MCUAPI extends StatelessWidget {
  const MCUAPI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData(primarySwatch: Colors.blueGrey),
    );
  }
}
