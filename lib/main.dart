import 'package:flutter/material.dart';
import 'package:flutternewsapp/auth_notifier.dart';
import 'package:flutternewsapp/homepage.dart';
import 'package:flutternewsapp/login.dart';
import 'data.dart';
import 'newsfeeds.dart';
import 'Register.dart';
import 'homepage.dart';
import 'count.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        builder: (context) => AuthNotifier(),)
    ],
      child: Myapp(),
    ),
  );
}
class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
@override
Widget build(BuildContext context) {
return MaterialApp(
title:'Home Screen',
home: Consumer<AuthNotifier>(
builder:  (context,notifier,child){
  return notifier.user != null ? Need() : Login();
}
) ,
);
}
}

