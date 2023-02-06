import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

InputDecoration loginTextDecoration(String hintText) {
  return InputDecoration(
    border: InputBorder.none,
    contentPadding: const EdgeInsets.only(top: 14),
    prefixIcon: const Icon(
      Icons.perm_contact_cal,
      color: Color(0xFFA51C1C),
    ),
    hintText: hintText,
    hintStyle: const TextStyle(
      color: Color.fromARGB(156, 255, 255, 255),
    ),
  );
}

BoxDecoration loginTextFieldBackground() {
  return BoxDecoration(
      color: const Color.fromRGBO(0, 0, 0, .5),
      borderRadius: BorderRadius.circular(45),
      boxShadow: const [
        BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
      ]);
}

String makeToken(String password, String salt) =>
    md5.convert(utf8.encode(password + salt)).toString().toLowerCase();

String generateRandomString(int len) {
  var r = Random();
  return String.fromCharCodes(
      List.generate(len, (index) => r.nextInt(33) + 89));
}