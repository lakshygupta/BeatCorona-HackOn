import 'package:firebase_database/firebase_database.dart';
import 'package:flutternewsapp/api/auth_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutternewsapp/model/user.dart';

login(User user, AuthNotifier authNotifier) async {
  AuthResult authResult = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: user.email, password: user.password)
      .catchError((error) => print(error.code));

  if (authResult != null) {
    FirebaseUser firebaseUser = authResult.user;
    if (firebaseUser != null) {
      print("Log In: $firebaseUser");
      authNotifier.setUser(firebaseUser);
    }
  }
}

signup(User user, AuthNotifier authNotifier,String shopname,String type,String location) async {
  AuthResult authResult = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(
          email: user.email, password: user.password)
      .catchError((error) => print(error.code));

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
      DBRef.child(authNotifier.user.uid).set(
          {
            'username':authNotifier.user.displayName,
            'id': authNotifier.user.uid,
            'email':authNotifier.user.email,
            'type' :type,
            'shopname':shopname,
            'location':location,
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
