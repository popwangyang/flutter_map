import 'package:flutter/material.dart';

AppBar appTitle({String title,}){
  return AppBar(
    elevation: 10.0,
    backgroundColor: Colors.white,
    title: Text(title),
    brightness: Brightness.light,
    textTheme: TextTheme(
        title: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600
        )
    ),
    iconTheme: IconThemeData(
        color: Colors.black
    ),
    centerTitle: true,
  );
}