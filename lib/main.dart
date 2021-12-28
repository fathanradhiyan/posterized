import 'package:flutter/material.dart';
import 'package:posterized/const/color.dart';
import 'package:posterized/pages/input_page.dart';
import 'package:posterized/pages/opening_page.dart';
import 'package:posterized/pages/poster_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Posterized',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        cursorColor: ColorsConsts.sky
      ),
      home: OpeningPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

