import 'package:flutter/material.dart';


 
const kCardTextColor = TextStyle(color: Colors.white);

void scrollToTopInstantly (ScrollController controller){
  controller.animateTo(0, duration: const Duration(microseconds: 1), curve: Curves.linear);
}

const kColorSecondary = Color.fromARGB(255, 38, 0, 77);
const kColorPrimary = Color.fromARGB(255, 13, 0, 26);