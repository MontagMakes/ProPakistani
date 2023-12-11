import 'package:flutter/material.dart';


 
const kCardTextColor = TextStyle(color: Colors.white);

void scrollToTopInstantly (ScrollController controller){
  controller.animateTo(0, duration: const Duration(microseconds: 1), curve: Curves.linear);
}



const kColorPrimary = Color.fromRGBO(29, 122, 116, 1.0);

final kFabShadow = BoxShadow(
  color: Colors.grey.withOpacity(0.8),
  spreadRadius: 1,
  blurRadius: 5,
  offset: const Offset(0, 0), // changes the position of the shadow
);