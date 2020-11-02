import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workload_allocation/Screens/Auth/signin.dart';
import 'package:workload_allocation/Screens/Auth/signup.dart';
import 'package:workload_allocation/Screens/Home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    /*return MultiProvider(
        providers: [
          Provider(
            create: (_) => AuthService(FirebaseAuth.instance)
          ),

          StreamProvider(
            create: (context) => context.read<AuthService>().authStateChanges,
          )
        ],
        child: MaterialApp(
          home: Home(),
          debugShowCheckedModeBanner: false,
        ));*/
    return  MaterialApp(
      home: SignIn(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/*class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if(firebaseUser != null){
      return Home();
    }
    return SignIn();
  }
}*/

