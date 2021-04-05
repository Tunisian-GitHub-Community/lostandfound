//system package
import 'dart:core';

//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:lostandfound/ui/article_ui.dart';

//me package

import 'package:lostandfound/ui/bottomnavigation.dart';
//import 'package:lostandfound/article.dart';

import 'home.dart';

class ListeArticle extends StatelessWidget {
  final DatabaseReference messagesRef;
  final String orderbyme;
  final String equalchnoi;
  ListeArticle({this.messagesRef, this.orderbyme, this.equalchnoi});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      if (equalchnoi == null) {
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => new Home()));
      }
    });

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Liste Article'),
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => new Home())),
              ),
            ),
            bottomNavigationBar: BotmNavigate(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 800,
                    child: FirebaseAnimatedList(
                      key: ValueKey<bool>(false),
                      query: messagesRef
                          .orderByChild(orderbyme)
                          .equalTo(equalchnoi),
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        return SizeTransition(
                          sizeFactor: animation,
                          child: ListTile(
                              title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                Article_ui(
                                  periode: snapshot.value['periode'].toString(),
                                  location:
                                      snapshot.value['location'].toString(),
                                  reward: snapshot.value['reward'].toString(),
                                  description:
                                      snapshot.value['description'].toString(),
                                  lostfound:
                                      snapshot.value['lostfound'].toString(),
                                  tags: snapshot.value['tags'].toString(),
                                  phone: snapshot.value['phone'].toString(),
                                  titre: snapshot.value['titre'].toString(),
                                  image: snapshot.value['image'].toString(),
                                  category:
                                      snapshot.value['category'].toString(),
                                ),
                              ])),
                        );
                      },
                      reverse: true,
                      /*sort: false
                          ? (DataSnapshot a, DataSnapshot b) =>
                              b.key.compareTo(a.key)
                          : null,*/
                    ),
                  ),
                ],
              ),
            )));
  }
}
