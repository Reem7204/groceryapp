import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/Home.dart';
import 'package:groceryapp/bottomnotification.dart';
import 'package:groceryapp/loginpage.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  void isLogin(){
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user!= null) {
      Timer(Duration(seconds: 3),()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Bottomnotification())));
    }
    else {
      Timer(Duration(seconds: 3),() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Loginpage())));
    }
  }
  @override
  void initState() { // this is called when the class is initialized or called for the first time
    super.initState(); // this is the material super constructor for init state to link your instance initState to the global initState context
    isLogin();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}