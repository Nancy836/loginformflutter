import 'package:firebaseauthentification/setup/home.dart';
import 'package:firebaseauthentification/setup/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _checked = false;
  bool _isHidden2 = true;
  bool _isHidden = true;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordMatch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFE1F5FE),
        // sign up page app bar
        appBar: AppBar(title: Text("Sign up")),
        body: SingleChildScrollView(
          child: Align(
            child: Column(children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 100)),
              Padding(padding: EdgeInsets.only(top: 30)),
              // welcome message
              Text(
                "Welcome to Break out room 2 Application",
                style: GoogleFonts.ptSans(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .3),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Text(
                "Create an account with us",
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  color: Colors.black54,
                  letterSpacing: .3,
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.75,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        // creating login textform fields
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            controller: nameController,
                            style: GoogleFonts.ptSans(
                              color: Colors.black,
                              fontSize: 18,
                              letterSpacing: .3,
                            ),
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              hintText: "Name",
                              hintStyle: GoogleFonts.roboto(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                            // if name input field is empty, message prompt is returned
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter your Name here";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: TextFormField(
                            style: GoogleFonts.ptSans(
                              color: Colors.black,
                              fontSize: 18,
                              letterSpacing: .3,
                            ),
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: "Email Address",
                              hintStyle: GoogleFonts.roboto(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                            validator: (value) {
                              // if email input field is left empty, message prompt is returned
                              if (value.isEmpty) {
                                return 'Mandatory Field!, Enter an Email Address';
                              } else if (!value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: TextFormField(
                            style: GoogleFonts.ptSans(
                              color: Colors.black,
                              fontSize: 18,
                              letterSpacing: .3,
                            ),
                            controller: passwordController,
                            obscureText: _isHidden,
                            decoration: InputDecoration(
                              suffix: InkWell(
                                onTap: _togglePasswordView,
                                child: Icon(Icons.visibility),
                              ),
                              hintText: "Password",
                              hintStyle: GoogleFonts.roboto(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                            validator: (value) {
                              // if password input field is left empty, message prompt is returned
                              if (value.isEmpty) {
                                return 'Mandatory Field, Enter Password';
                              } else if (value.length < 8) {
                                return 'Password must be at least 8 characters!';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: TextFormField(
                            style: GoogleFonts.ptSans(
                              color: Colors.black,
                              fontSize: 18,
                              letterSpacing: .3,
                            ),
                            controller: passwordMatch,
                            obscureText: _isHidden2,
                            decoration: InputDecoration(
                              suffix: InkWell(
                                onTap: _togglePasswordView2,
                                child: Icon(Icons.visibility),
                              ),
                              hintText: "Confirm Password",
                              hintStyle: GoogleFonts.ptSans(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                            //checking whether the two passwords match
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please confirm your password';
                              } else if (value != passwordController.text) {
                                return 'Passwords do not match, try again';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 30)),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: isLoading
                              ? CircularProgressIndicator()
                              : SizedBox(
                                  width: 300,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        // calling _signupandsave() 
                                        _signupandsave();
                                      }
                                    },
                                    child: Text(
                                      "Sign Up",
                                      style: GoogleFonts.ptSans(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }


// Create account with the details provided 
  Future registerToFb(String email, String name, String password) async {
    //creating user in Firebase database
    try {

      UserCredential results = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User user = results.user;
      return true;
    } catch (e) {
      return Expando();
    }
  }
   
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _togglePasswordView2() {
    setState(() {
      _isHidden2 = !_isHidden2;
    });
  }

  void _signupandsave() async {
    dynamic result = await registerToFb(
        emailController.text, nameController.text, passwordController.text);
    var user = FirebaseAuth.instance.currentUser;
    
    // printing success message if sucessful
    if (result == true) {
      print("Successfully Signed Up");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    userid: user.uid,
                  )));

      //TO DO add uid
      // if it fails, print error message
    } else {
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
    @override
    void dispose() {
      super.dispose();
      nameController.dispose();
      emailController.dispose();
      passwordController.dispose();
    }
  }
}

