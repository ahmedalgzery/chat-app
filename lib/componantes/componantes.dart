// ignore_for_file: non_constant_identifier_names

import 'package:chat/constatns.dart';
import 'package:chat/models/message.dart';
import 'package:flutter/material.dart';

Widget customTextFormField({
  Function(String)? onChanged,
  required String hintText,
  required TextInputType keyboardType,
  bool? obscureText=false,
}) {
  return TextFormField(
    obscureText:obscureText! ,
    validator: (value) {
      if (value!.isEmpty) {
        return 'field is required';
      }
      return null;
    },
    keyboardType: keyboardType,
    decoration: InputDecoration(
      border: const OutlineInputBorder(),
      hintText: hintText,
      label: Text(hintText),
      hintStyle: const TextStyle(
        color: Colors.white,
      ),
      labelStyle: const TextStyle(
        color: Colors.white,
      ),
    ),
    onChanged: onChanged,
  );
}

Widget customTextButton({
  required VoidCallback onPressed,
  required String text,
}) {
  return TextButton(
    style: ButtonStyle(
      minimumSize: const MaterialStatePropertyAll(Size(double.infinity, 30.0)),
      alignment: Alignment.center,
      backgroundColor: MaterialStateProperty.all(
        Colors.white,
      ),
    ),
    onPressed: onPressed,
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 30.0,
        color: Colors.black,
      ),
    ),
  );
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

Widget ChatBuble({required Message message}) {
  return  Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          color: KPrimaryColor,
        ),
        child: Text(
          message.message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
}

Widget ChatBubleForFriend({required Message message}){
  return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
          color: Color(0xff006D84),
        ),
        child: Text(
          message.message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
}
