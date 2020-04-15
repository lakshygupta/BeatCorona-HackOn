import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'model/message.dart';

class MessagingWidget extends StatefulWidget {
  @override
  _MessagingWidgetState createState() => _MessagingWidgetState();
}

class _MessagingWidgetState extends State<MessagingWidget> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];

  @override
  void initState(){
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String,dynamic> message) async {
        print('onMessage: $message');
        final notification = message['notification'];
        setState(() {
          messages.add(Message(
            title:notification['Title'],body: notification['body']
          ));
        });
      },
      onLaunch: (Map<String,dynamic> message) async {
        print('onMessage: $message');
        final notification = message['notification'];
        setState(() {
          messages.add(Message(
              title:notification['Title'],body: notification['body']
          ));
        });
      },
      onResume: (Map<String,dynamic> message) async {
        print('onMessage: $message');
        final notification = message['notification'];
        setState(() {
          messages.add(Message(
              title:notification['Title'],body: notification['body']
          ));
        });
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound:true,badge: true,alert: true)
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(children: messages.map(buildMessage).toList());
  }

  Widget buildMessage(Message message) => ListTile(
    title: Text(message.title),
    subtitle: Text(message.body),
  );
}
