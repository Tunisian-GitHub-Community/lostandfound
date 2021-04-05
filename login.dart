//system package
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
//me package
import 'package:lostandfound/register.dart';
import 'package:lostandfound/profile.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email;
  String _motdepasse;

  void _signInWithEmailAndPassword(String _email, String _motdepasse) async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _motdepasse,
      ))
          .user;
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return Profile(
          user: user,
        );
      }));
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Failed to sign in with Email & Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Failed to sign in with Email & Password"),
      ));
    }
  }

  void _signOut() async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      FirebaseAuth auth = FirebaseAuth.instance;
      if (auth.currentUser != null) {
        print("auth user id :" + auth.currentUser.uid);
        print("auth user id :" + auth.currentUser.email);
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new Profile()));
      }
    });

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.alternate_email,
                          color: Colors.grey,
                        ),
                        hintText: ' email ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      validator: (value) {
                        if ((value.isEmpty) || (value.length < 6)) {
                          return 'Please enter email';
                        } else {
                          _email = value;
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      maxLines: 1,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.no_encryption,
                          color: Colors.grey,
                        ),
                        hintText: ' mot de passe ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter mot de passe';
                        } else {
                          _motdepasse = value;
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text("Login"),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _signInWithEmailAndPassword(_email, _motdepasse);
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: ElevatedButton(
                  child: Text("Register"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Register()),
                    );
                  },
                ),
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
