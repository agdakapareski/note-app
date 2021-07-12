import 'package:flutter/material.dart';
import 'Page/my_home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        'homepage': (BuildContext context) => MyHomePage(),
      },
      title: 'My Note',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
