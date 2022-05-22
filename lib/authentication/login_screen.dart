import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/progress_dialog.dart';
import '../global/global.dart';
import '../mainScreens/main_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm() {
    if (!emailTextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "email address is not valid");
    } else if (passwordTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "password is required");
    } else {
      LoginDriverNow();
    }
  }

  LoginDriverNow() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(message: "processing, please wait...",);
    });
    final User? firebaseUser = (await fAuth.signInWithEmailAndPassword(
      email: emailTextEditingController.text.trim(),
      password: passwordTextEditingController.text.trim(),
    ).catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error: " + msg.toString());
    })).user;

    if (firebaseUser != null) {
      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Login Successful");
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => const MainScreen()));
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "error occured during login");
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.05,
          bottom: MediaQuery.of(context).size.height * 0.05,
          left: MediaQuery.of(context).size.height * 0.05,
          right: MediaQuery.of(context).size.height * 0.05,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Image.asset('images/logo.png', width: w * 0.5, height: h * 0.3),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "লগইন করুন",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.grey),
                decoration: const InputDecoration(
                    labelText: "ইমেইল*",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 14))),
            TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.grey),
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: "পাসওয়ার্ড*",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 14))),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // validateForm();
                Navigator.push(context,MaterialPageRoute(builder: (c) => const MainScreen()));
              },
              child: const Text(
                "লগইন",
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 18),
              ),
            ),
            TextButton(
                child: const Text(
                  "অ্যাকাউন্ট নেই? নিবন্ধন করুন",
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (c) => const SignupScreen()));
                }),
          ],
        ),
      ),
    ));
  }
}
