import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils{
  static DateFormat format = DateFormat('d MMM yy -').add_jm();
  static String capitalize(String str) {
    return "${str[0].toUpperCase()}${str.substring(1)}";
  }
  static Size size;
  Utils(BuildContext context){
     size = MediaQuery.of(context).size;
  }
}