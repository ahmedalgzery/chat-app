// ignore_for_file: unused_local_variable

import 'package:chat/componantes/componantes.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:chat/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constatns.dart';

class LoginScreen extends StatefulWidget {
   const LoginScreen({super.key});
  static String id = 'login screen';
 
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   String? email;

  String? password;

  final GlobalKey<FormState> globalKey = GlobalKey();

  bool isLoding = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoding,
      child: Scaffold(
        backgroundColor:KPrimaryColor,
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
                    // crossAxisAlignment: CrossAxisAlignment.center,
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
                          'Sign In',
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
                          keyboardType: TextInputType.emailAddress),
                      const SizedBox(
                        height: 8.0,
                      ),
                      customTextFormField(
                        obscureText: true,
                          hintText: 'Password',
                          onChanged: (data) {
                            password = data;
                          },
                          keyboardType: TextInputType.visiblePassword),
                          
                      const SizedBox(
                        height: 15.0,
                      ),
                      customTextButton(
                          onPressed: () async {
                            if (globalKey.currentState!.validate()) {
                              isLoding = true;
                              setState(() {});
                              try {
                                await loginUser();
                                Navigator.pushNamed(context, ChatScreen.id, arguments: email);
                              } on FirebaseAuthException catch (ex) {
                                if (ex.code == 'user-not-found') {
                                  showSnackBar(context, 'user not found');
                                } else if (ex.code == 'wrong-password') {
                                  showSnackBar(context, 'wrong password');
                                }
                              } catch (ex) {
                                showSnackBar(context, 'there was an error');
                              }
                            } else {}
                            isLoding = false;
                            setState(() {});
                          },
                          text: 'LOGIN'),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('don\'t have an account ? '),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, RegisterScreen.id);
                            },
                            child: const Text(
                              ' Sign Up',
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

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
