import 'package:flutter/material.dart';
import 'package:flutternewsapp/api/auth_notifier.dart';
import 'package:flutternewsapp/homepage.dart';
import 'package:flutternewsapp/login.dart';
import 'model/data.dart';
import 'Drawer/newsfeeds.dart';
import 'Register.dart';
import 'homepage.dart';
import 'Drawer/count.dart';
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