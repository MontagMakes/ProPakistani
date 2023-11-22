import 'package:flutter/material.dart';


 
const kCardTextColor = TextStyle(color: Colors.white);

void scrollToTopInstantly (ScrollController _controller){
  _controller.animateTo(0, duration: Duration(microseconds: 1), curve: Curves.linear);

}