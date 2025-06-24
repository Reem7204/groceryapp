import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:groceryapp/Home.dart';
import 'package:groceryapp/bottomnotification.dart';
import 'package:groceryapp/forgotpassword.dart';
import 'package:groceryapp/signup.dart';
import 'package:groceryapp/toast_meaasage.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<void> signInWithGoogle() async {
   try {
      final GoogleSignInAccount? googleSignInAccount= await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication= await googleSignInAccount!.authentication;

      final AuthCredential credential=GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken
      );

      final UserCredential userCredential= await auth.signInWithCredential(credential);
      final User? user= userCredential.user;
      if (user!=null) {
        Navigator.push(context, MaterialPageRoute(builder: (_)=>Bottomnotification()));
        ToastMessage().toastmessage(message: 'succusfully completed');
      }
    } catch (e) {
      ToastMessage().toastmessage(message: e.toString());
    }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Text(
              'Login',
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
            padding: const EdgeInsets.fromLTRB(8, 150, 8, 0),
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
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Forgotpassword()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: const Color(0xFF181725),
                      fontSize: 14,
                      fontFamily: 'Gilroy-Medium',
                      fontWeight: FontWeight.w400,
                      height: 1.08,
                      letterSpacing: 0.70,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                auth
                    .signInWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    )
                    .then(
                      (value) => {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext a) => Home(),
                          ),
                        ),
                      },
                    )
                    .onError(
                      (error, stackTrace) => ToastMessage().toastmessage(
                        message: error.toString(),
                      ),
                    );
              },
              child: Container(
                width: 364.w,
                height: 30.h,
                decoration: ShapeDecoration(
                  color: const Color(0xFF53B175),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19.r),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Log In',
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
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don’t have an account? ',
                style: TextStyle(
                  color: const Color(0xFF181725),
                  fontSize: 14,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w600,
                  height: 1.08,
                  letterSpacing: 0.70,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Signup()),
                  );
                },
                child: Text(
                  'Signup',
                  style: TextStyle(
                    color: const Color(0xFF53B175),
                    fontSize: 14,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w600,
                    height: 1.08,
                    letterSpacing: 0.70,
                  ),
                ),
              ),
            ],
          ),
          TextButton(onPressed: () {
                                         signInWithGoogle();
                                       }, child: Text('Login with google'))
        ],
      ),
    );
  }
}
