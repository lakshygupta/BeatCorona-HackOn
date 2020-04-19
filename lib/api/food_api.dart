import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutternewsapp/api/auth_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutternewsapp/model/user.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';


final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
Position _currentPosition;
String _currentAddress = " ";

_getCurrentLocation() {
  geolocator
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
      .then((Position position) {
      _currentPosition = position;
    _getAddressFromLatLng();
  }).catchError((e) {
    print(e);
  });
}

_getAddressFromLatLng() async {
  try {
    List<Placemark> p = await geolocator.placemarkFromCoordinates(
        _currentPosition.latitude, _currentPosition.longitude);

    Placemark place = p[0];

    _currentAddress =
    "${place.thoroughfare},\n ${place.subAdministrativeArea}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
  } catch (e) {
    print(e);
  }
}
void _showDialog(BuildContext context,String er) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("LogIn"),
        content: new Text(er),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
void _showemailDialog(BuildContext context) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Email error"),
        content: new Text("Email Already Exists"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
void showAlert(context)
{

  Widget continueButton = Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      CircularProgressIndicator(),
    ],
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: Text("Please Wait"),
    actions: [
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
      builder: (context) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.pop(context);
        });
        return alert;}
  );
}
login(User user, AuthNotifier authNotifier,BuildContext context) async {

  AuthResult authResult = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: user.email, password: user.password)
      .catchError((error)
  {
      String er = error.toString();
    _showDialog(context,er);
  });
  showAlert(context) ;
  if (authResult != null) {
    FirebaseUser firebaseUser = authResult.user;
    if (firebaseUser != null) {
      print("Log In: $firebaseUser");
      authNotifier.setUser(firebaseUser);
    }
  }
}

signup(User user, AuthNotifier authNotifier,String shopname,String type,BuildContext context) async {

  AuthResult authResult = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(
          email: user.email, password: user.password)
      .catchError((error)
  {
    String er = error.toString();
    _showDialog(context,er);
  });
  showAlert(context) ;
  if (authResult != null) {
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = user.displayName;
    FirebaseUser firebaseUser = authResult.user;


    if (firebaseUser != null) {
      await firebaseUser.updateProfile(updateInfo);
      await firebaseUser.reload();
      print("Sign up: $firebaseUser");
      FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
      authNotifier.setUser(currentUser);
      final DBRef = FirebaseDatabase.instance.reference().child('Users');
      _getCurrentLocation();
      print('current address'+_currentAddress);
      print(_currentAddress);

      DBRef.child(authNotifier.user.uid).set(
          {
            'username':authNotifier.user.displayName,
            'id': authNotifier.user.uid,
            'email':authNotifier.user.email,
            'type' :type,
            'shopname':shopname,
            'location':_currentAddress,
          }
      );
    }
  }
}



signout(AuthNotifier authNotifier) async {
  await FirebaseAuth.instance
      .signOut()
      .catchError((error) => print(error.code));
  authNotifier.setUser(null);
}

initializeCurrentUser(AuthNotifier authNotifier) async {
  FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();

  if(firebaseUser != null)
    {
      print(firebaseUser);
      authNotifier.setUser(firebaseUser);
    }
}
