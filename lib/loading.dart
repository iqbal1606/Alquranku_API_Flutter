import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './home.dart';
import './index.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkUserLoginStatus();
  }

  void checkUserLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLogin = prefs.getString('authToken') != null ? true : false;

    if (isLogin) {
      Timer(const Duration(seconds: 5), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Myhome()));
      });
    } else {
      Timer(const Duration(seconds: 5), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Index()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
            child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.start, // Letakkan di bawah tengah
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: const Text(
                  "AYO BACA Al'QURAN",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: const Text(
                  "Rasulullah SAW bersabda, Bacalah Alquran, maka sesungguhnya ia akan datang di hari kiamat memberi syafaat kepada pembacanya",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        )),
      ]),
    );
  }
}
