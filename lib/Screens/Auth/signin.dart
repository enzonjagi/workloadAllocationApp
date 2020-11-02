import 'package:flutter/material.dart';
import 'package:workload_allocation/Screens/Auth/signup.dart';
import 'package:workload_allocation/Screens/Home/home.dart';
import 'package:workload_allocation/Screens/widgets/widgets.dart';
import 'package:workload_allocation/Services/authenticate.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //Identify the form
  final _formKey = GlobalKey<FormState>();
  String email, password;
  bool _isLoading = false;

  AuthService authService;

  void signIn() async{
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
      //TODO: LINK TO AUTHSERVICE FUNCTION
      await authService.signInWithEmailandPass(email, password).then((value) {
        if (value != null) {
          //TODO add the check for email and password correctness
          setState(() {
            _isLoading = false;
          });
          //HelperFunctions.saveUserLoggedInDetails(isLoggedIn: true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      });

    }
    _formKey.currentState.save();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context, "kazi", "Manager"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        centerTitle: true,
      ),
      body: _isLoading ? Container(
          child: Center(
            child: CircularProgressIndicator(),
          )
      ) :Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Spacer(),
              TextFormField(
                validator: (val) {
                  return val.isEmpty && !RegExp(
                      "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*")
                      .hasMatch(val) ? 'Valid email is required' : null;
                },
                decoration: InputDecoration(hintText: "Email"),
                onChanged: (val) {
                  email = val;
                },
              ),
              SizedBox(height: 6),
              TextFormField(
                validator: (val) {
                  return val.isEmpty ? "Enter correct password" : null;
                },
                decoration: InputDecoration(hintText: "password"),
                onChanged: (val) {
                  password = val;
                },
                obscureText: true,
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  //sign in button; logs user in

                  signIn();
                },
                child: blueButton(context: context, label:"Login"),
              ),
              SizedBox(height: 16),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not registered?",
                        style: TextStyle(fontSize: 15)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUp() ));
                      },
                      child: Text("SignUp",
                          style: TextStyle(
                              fontSize: 15,
                              decoration: TextDecoration.underline)),
                    ),
                  ]),
              SizedBox(height: 80)
            ],
          ),
        ),
      ),
    );
  }
}
