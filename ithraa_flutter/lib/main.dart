import 'package:flutter/material.dart';
import 'package:ithraa/business/homeLocale.dart';
import 'package:ithraa/components/bottomBarNav.dart';
import 'package:ithraa/home.dart';
import 'package:ithraa/login.dart';
import 'package:ithraa/sign_up.dart';
import 'package:ithraa/test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: Login()));
}
