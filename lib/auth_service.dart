import 'package:firebase_auth/firebase_auth.dart';
class AuthService
{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
      (FirebaseUser user) => user?.uid,
  );
  //signup
  Future<String> createUserWithEmailPassword(String email, String password,String name)
  async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    //update the username
  }
}