import 'package:flutter/material.dart';

import 'package:calculadora/src/pages/HomePage.dart';

class calculadora extends StatelessWidget {
  const calculadora({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(child: HomePage()),
    );
  }
}
