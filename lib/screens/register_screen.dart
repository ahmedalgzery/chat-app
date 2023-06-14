// ignore_for_file: must_be_immutable, unused_local_variable, use_build_context_synchronously

import 'package:chat/componantes/componantes.dart';
import 'package:chat/constatns.dart';
import 'package:chat/cubits/register_cubit/register_cubit.dart';
import 'package:chat/cubits/register_cubit/register_state.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  static String id = 'register screen';

  String? email;

  String? password;

  final GlobalKey<FormState> globalKey = GlobalKey();

  bool isLoding = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
          if (state is RegisterLoading) {
          isLoding = true;
        } else if (state is RegisterSuccess) {
          Navigator.pushNamed(context, ChatScreen.id, arguments: email);
          isLoding = false;
        } else if (state is RegisterFailure) {
          showSnackBar(context, state.errMessage);
          isLoding = false;
        }
      },
      builder: (context, state) {
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
                                  BlocProvider.of<RegisterCubit>(context)
                                      .registerUser(
                                          email: email!, password: password!);
                                } else {}
                                isLoding = false;
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
      },
    );
  }
}
