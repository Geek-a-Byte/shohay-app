import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../global/global.dart';
import '../widgets/progress_dialog.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();

  validateForm() {
    if (nameTextEditingController.text.length < 3) {
      Fluttertoast.showToast(msg: "name must be at least 2 characters long");
    } else if (!emailTextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "email address is not valid");
    } else if (phoneTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "phone number is mandatory");
    } else if (passwordTextEditingController.text.length < 6) {
      Fluttertoast.showToast(
          msg: "password must be at least 6 characters long");
    } else {
      saveDriverInfoNow();
    }
  }

  saveDriverInfoNow() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(message: "processing, please wait...",);
        });
    final User? firebaseUser = (await fAuth.createUserWithEmailAndPassword(
      email: emailTextEditingController.text.trim(),
      password: passwordTextEditingController.text.trim(),
    ).catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error: " + msg.toString());
    })).user;

    if (firebaseUser != null) {
      Map driverMap = {
        "id": firebaseUser.uid,
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
      };

      DatabaseReference driversRef =
          FirebaseDatabase.instance.ref().child("drivers");
      driversRef.child(firebaseUser.uid).set(driverMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has been created.");
      Navigator.push(context, MaterialPageRoute(builder: (c) => const LoginScreen()));

    } else {

      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account has not been created.");

    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05,
                    bottom: MediaQuery.of(context).size.height * 0.05,
                    left: MediaQuery.of(context).size.height * 0.03,
                    right: MediaQuery.of(context).size.height * 0.03,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset('images/logo.png', width: w * 0.5, height: h * 0.3),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "নিবন্ধন করুন",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                        controller: nameTextEditingController,
                        style: const TextStyle(color: Colors.grey),
                        decoration: const InputDecoration(
                            labelText: "নাম*",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 10),
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 14))),
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
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 10),
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 14))),
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
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 10),
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 14))),
                    TextField(
                        controller: phoneTextEditingController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(color: Colors.grey),
                        decoration: const InputDecoration(
                            labelText: "ফোন নম্বর*",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 10),
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 14))),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        validateForm();
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (c) => CarInfoScreen()));
                      },
                      child: const Text(
                        "নিবন্ধন করুন",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    TextButton(
                        child: const Text(
                          "অ্যাকাউন্ট আছে? লগইন করুন",
                          style: TextStyle(color: Colors.grey),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => const LoginScreen()));
                        }),
                  ],
                ),
              ),
            )));
  }
}
