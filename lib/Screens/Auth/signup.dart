import 'package:flutter/material.dart';
import 'package:workload_allocation/Screens/Auth/signin.dart';
import 'package:workload_allocation/Screens/Home/home.dart';
import 'package:workload_allocation/Screens/widgets/widgets.dart';
import 'package:workload_allocation/Services/authenticate.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String u_name, email, password, confirm_pwd;
  AuthService authService;
  bool _isLoading = false;

  signUp() async {
    if(_formKey.currentState.validate()){
      setState(() {
        _isLoading = true;
      });
      /*Map<String, String> userData = {
        "username": u_name,
        "email": email,
        "password": password
      };*/
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
      await authService.createUser(email, password).then((value) {
        if(value != null){
          setState(() {
            _isLoading = false;
          });
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
      body:  _isLoading
          ? Container(
          child: Center(
            child: CircularProgressIndicator(),
          ))
          : Form(
        key: _formKey,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Spacer(),
                TextFormField(
                  validator: (val) {
                    return val.isEmpty ? "Please fill this field" : null;
                  },
                  decoration: InputDecoration(hintText: "Username"),
                  onChanged: (val) {
                    u_name = val;
                  },
                ),
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
                    //should register the user
                    signUp();
                  },
                  child: blueButton(context: context, label:"SignUp"),
                ),
                SizedBox(height: 16),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already registered?",
                          style: TextStyle(fontSize: 15)),
                      GestureDetector(
                        onTap: () {
                          //tap this to go to signin screen
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn()));
                        },
                        child: Text("SignIn",
                            style: TextStyle(
                                fontSize: 15,
                                decoration: TextDecoration.underline)),
                      ),
                    ]),
                SizedBox(height: 80)
              ],
            )),
      ),
    //here,
    );
  }
}
