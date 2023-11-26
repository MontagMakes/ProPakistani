import 'package:flutter/material.dart';


 
const kCardTextColor = TextStyle(color: Colors.white);

void scrollToTopInstantly (ScrollController controller){
  controller.animateTo(0, duration: const Duration(microseconds: 1), curve: Curves.linear);
}

