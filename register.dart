//system package
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_auth/firebase_auth.dart';
//me package

import 'package:lostandfound/home.dart';
import 'package:lostandfound/profile.dart';
import 'package:lostandfound/login.dart';

class Register extends StatefulWidget {
  final User user;

  const Register({Key key, this.user}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _firstname;
  String _lastname;
  String _email;
  String _motdepasse;
  String _confirmpass;
  String _telephone;

  FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isSuccess;

  void _registerAccount(
      String _firstname,
      String _lastname,
      String _email,
      String _motdepasse,
      String _confirmpass,
      String _telephone,
      String _birthday) async {
    final databaseReference = FirebaseDatabase.instance.reference();

    databaseReference.child("user").update({
      '$_email': {
        'firstname': '$_firstname',
        'lastname': '$_lastname',
        'email': '$_email',
        'motdepasse': '$_motdepasse',
        'telephone': '$_telephone',
        'birthday': '$_birthday'
      }
    });

    final User user = (await _auth.createUserWithEmailAndPassword(
      email: _email,
      password: _motdepasse,
    ))
        .user;

    if (user != null) {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      await user.updateProfile(displayName: _firstname);
      final user1 = _auth.currentUser;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Home(
                user: user1,
              )));
    } else {
      _isSuccess = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      FirebaseAuth auth = FirebaseAuth.instance;
      if (auth.currentUser != null) {
        print("auth user id :" + auth.currentUser.email);
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new Profile()));
      }
    });

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        hintText: 'first name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        } else {
                          _firstname = value;
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        hintText: 'last name  ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        } else {
                          _lastname = value;
                          return null;
                        }
                      },
                    ),
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
                        if (value.isEmpty) {
                          return 'Please enter some text';
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
                        if ((value.isEmpty) || (value.length < 6)) {
                          return 'Please enter some text';
                        } else {
                          _motdepasse = value;
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
                        hintText: 'confirm mot de passe  ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        } else {
                          _confirmpass = value;
                          if (_confirmpass != _motdepasse) {
                            return 'Please enter some text';
                          } else {
                            return null;
                          }
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        hintText: 'telephone  ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        } else {
                          _telephone = value;
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
                child: Text("register"),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    final databaseReference =
                        FirebaseDatabase.instance.reference();

                    databaseReference.child("user").update({
                      '$_email': {
                        'firstname': '$_firstname',
                        'lastname': '$_lastname',
                        'email': '$_email',
                        'motdepasse': '$_motdepasse',
                        'telephone': '$_telephone',
                        'birthday': 'ssss'
                      }
                    });
                    _registerAccount(_firstname, _lastname, _email, _motdepasse,
                        _confirmpass, _telephone, "birthday");
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  child: Text("Login"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(builder: (context) => new Login()),
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
