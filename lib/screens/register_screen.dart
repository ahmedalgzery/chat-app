// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:chat/componantes/componantes.dart';
import 'package:chat/constatns.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
   const RegisterScreen({super.key});
  static String id = 'register screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
    String? email;

  String? password;

  final GlobalKey<FormState> globalKey = GlobalKey();

  bool isLoding = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoding,
      child: Scaffold(
        backgroundColor: KPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: double.infinity,
            child: Form(
              key: globalKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(KLogo),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        'Scholar Chat',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontFamily: 'Pacifico',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Sign Up',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      customTextFormField(
                        hintText: 'Email',
                        onChanged: (data) {
                          email = data;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      customTextFormField(
                        hintText: 'Password',
                        obscureText: true,
                        onChanged: (data) {
                          password = data;
                        },
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      customTextButton(
                          onPressed: () async {
                            if (globalKey.currentState!.validate()) {
                              isLoding = true;
                              setState(() {});
                              try {
                                await registerUser();
                                Navigator.pushNamed(context, ChatScreen.id, arguments: email);
                              } on FirebaseAuthException catch (ex) {
                                if (ex.code == 'weak-password') {
                                  showSnackBar(context, 'weak password');
                                } else if (ex.code == 'email-already-in-use') {
                                  showSnackBar(context, 'email already exists');
                                }
                              } catch (ex) {
                                showSnackBar(context, ex.toString());
                              }
                            } else {}
                            isLoding = false;
                            setState(() {});
                          },
                          text: 'REGISTER'),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('already have an account ? '),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              ' LogIn',
                              style: TextStyle(
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
