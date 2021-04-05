//system package
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
//me package

import 'package:lostandfound/home.dart';
import 'package:lostandfound/ui/bottomnavigation.dart';

class Profile extends StatefulWidget {
  final User user;

  const Profile({Key key, this.user}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
              context, new MaterialPageRoute(builder: (context) => new Home())),
        ),
      ),
      bottomNavigationBar: BotmNavigate(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      key: _scaffoldKey,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                auth.currentUser.email,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Container(
              child: ElevatedButton(
                child: Text("Settieng"),
                onPressed: () {},
              ),
            ),
            Container(
              child: ElevatedButton(
                child: Text("LogOut"),
                onPressed: () {
                  _signOut().whenComplete(() {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Home()));
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _signOut() async {
    await _auth.signOut();
  }
}
