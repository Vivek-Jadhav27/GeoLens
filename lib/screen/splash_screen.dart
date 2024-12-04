import 'package:flutter/material.dart';

import '../config/router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Routes.home);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: screenWidth * 0.8,
            width: screenWidth*0.8,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/GeoLens.png'), fit: BoxFit.fill)),
          ),
          SizedBox(
            height: screenWidth * 0.05,
          ),
          Text(
            'GeoLens',
            style: TextStyle(
                fontSize: screenWidth * 0.1,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ],
      )),
    );
  }
}
