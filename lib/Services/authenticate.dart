import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  //Sign in anon
  Future<String> signInAnon() async {
    UserCredential userCredential = await _firebaseAuth.signInAnonymously();
    return "Signed in anonymously";
  }

  //SINGNIN
  Future<String> signInWithEmailandPass(String email, password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return ("Signed in");

    }on FirebaseAuthException catch(e){
      if (e.code == 'user-not-found') {
        return ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return ('Wrong password provided for that user.');
      }
    }
  }

  //SIGNUP
  Future<String> createUser(String email, password) async {
    //await _initialization;
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return ('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //VERIFY EMAIL
  dynamic verifyEmail() async {
    User user = _firebaseAuth.currentUser;
    if (!user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  //SIGNOUT
  Future<void> signOut() async {

    await _firebaseAuth.signOut();
  }




}