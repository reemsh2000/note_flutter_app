import 'package:flutter/material.dart';
import 'dart:async';

import 'package:reem_notes/screens/home.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  navigateHome(context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return const Home();
    }));
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      navigateHome(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Image.network(
                "https://st4.depositphotos.com/20923550/26755/v/450/depositphotos_267556552-stock-illustration-worker-document-search-jobs-blue.jpg"),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 140,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo,
                ),
                onPressed: (() => {navigateHome(context)}),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
