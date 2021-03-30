import 'package:firebaseauthentification/setup/login.dart';
import 'package:firebaseauthentification/setup/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// We can check if the user is logged in  or not and redirect to  the approp page.
class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // displaying welcome message
            Text(
              "Welcome to Breakout Room 2 Application",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 100,
            ),
            //button leading to signup page
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                },
                child: Container(
                    height: 50,
                    width: 70,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("SignUp"),
                    ))),
            SizedBox(
              height: 30,
            ),
            // button leading to login page
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LogIn()));
                },
                child: Container(
                    height: 50,
                    width: 70,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("Login"),
                    )))
          ],
        ),
      ),
    );
  }
}

