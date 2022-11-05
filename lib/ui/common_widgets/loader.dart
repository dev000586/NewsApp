import 'package:flutter/material.dart';

Widget Loader (){
  return Container(
    alignment: Alignment.topCenter,
    child: const CircularProgressIndicator(
      color: Colors.green,
      strokeWidth: 6,
    ),
  );
}