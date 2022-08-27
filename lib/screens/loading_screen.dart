import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: AspectRatio(
              aspectRatio: 20 / 9,
              child: Center(child: Image.asset('assets/icons/logo.png'))),
        ));
  }
}
