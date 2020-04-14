import 'package:flutter/material.dart';
import 'package:flutternewsapp/auth_notifier.dart';
import 'package:flutternewsapp/homepage.dart';
import 'package:flutternewsapp/login.dart';
import 'data.dart';
import 'newsfeeds.dart';
import 'Register.dart';
import 'homepage.dart';
import 'count.dart';

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

}
}

