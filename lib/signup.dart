import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:groceryapp/loginpage.dart';
import 'package:groceryapp/toast_meaasage.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController(); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(onTap: () => Navigator.pop(context),child: Icon(Icons.arrow_back_ios_new)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70.0),
            child: Text(
              'Sign Up',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF181725),
                fontSize: 26.sp,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w600,
                height: 1.12.h,
              ),
            ),
          ),
          
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20.0,
                ),
                labelText: 'Email',
                border: InputBorder.none,
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.fromLTRB(8,0,8,0),
            child: TextField(
              controller: password,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20.0,
                ),
                labelText: 'Password',
                border: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 364.w,
              height: 30.h,
              decoration: ShapeDecoration(
                color: const Color(0xFF53B175),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19.r),
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  auth.
                  createUserWithEmailAndPassword(
                    email: email.text, 
                    password: password.text)
                  .then((value) => {
                    ToastMessage().toastmessage(message: 'Successfully registerd'),
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Loginpage()))
                  })
                  .onError((error, stackTrace) => ToastMessage()
                          .toastmessage(message: error.toString()));
                },
                child: Center(
                  child: Text(
                    'Sign Up',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFFFFF9FF),
                      fontSize: 18.sp,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w600,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}