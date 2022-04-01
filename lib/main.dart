import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posterized/const/color.dart';
import 'package:posterized/pages/opening_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MaterialColor colorCustom = MaterialColor(0xFFFF00DD, color);
    return MaterialApp(
      title: 'Posterized',
      theme: ThemeData(
        primarySwatch: colorCustom,
        accentColor: ColorsConsts.sky,
        cursorColor: ColorsConsts.sky
      ),
      home: const OpeningPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

