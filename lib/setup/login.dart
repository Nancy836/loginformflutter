import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauthentification/setup/home.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFE1F5FE),
        appBar: AppBar(title: Text("Login In")),
        body: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 40)),
              Padding(padding: EdgeInsets.only(top: 30)),
              Padding(padding: EdgeInsets.only(bottom: 30)),
              //creating textform fields for login page
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email Address",
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Mandatory Field, Enter Your Email Address';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email address!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Mandatory Field, Enter Your Password';
                    } else if (value.length < 8) {
                      return 'Password must be atleast 8 characters!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {
                    print("Login Pressed");
                    print(emailController.text);
                    print(passwordController.text);
                    _loginandsave();
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ])));
  }

  void _loginandsave() async {
    print("Home");
    // getting user uid
    dynamic result = await loginwithEmailandpass(
        emailController.text, passwordController.text);
    var user = await FirebaseAuth.instance.currentUser;
    print(user.uid);

    print(result);

    // if login successful, print success message
    if (result == true) {
      print("Logged in successfully!");
      Navigator.push(
          context,
          MaterialPageRoute(
            // navigating user to home page
              builder: (context) => HomePage(
                    userid: user.uid,
                  )));
    }//if not, print error message
     else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(result.toString()),
              actions: [
                ElevatedButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
      setState(() => isLoading = false);
    }
  }
  
  //passing the user's email address and password
  Future loginwithEmailandpass(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print("Login succesful");
      return true;
    } catch (e) {
      print(e.toString());
      return e;
    }
  }
}
