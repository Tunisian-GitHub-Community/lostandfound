//system package
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:lostandfound/profile.dart';
//me package

import 'package:lostandfound/ui/button.dart';
//import 'package:lostandfound/searcharticle.dart';
import 'package:lostandfound/listearticle.dart';
import 'package:lostandfound/ui/article_ui.dart';
import 'package:lostandfound/ui/bottomnavigation.dart';

class Home extends StatefulWidget {
  final User user;
  Home({Key key, this.user}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /*void resulta() {
    print('hi');
    final db = FirebaseDatabase.instance.reference().child("article");
    db.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        print(values["category"]);
      });
    });
  }*/

  @override
  Widget build(BuildContext context) {
    /* resulta();*/
    return MaterialApp(
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text('Lost and Found'),
          ),
          bottomNavigationBar: BotmNavigate(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 20,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(Icons.search),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new SearchArticle()),
                              );
                            },
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 20,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(Icons.info_outline),
                            color: Colors.white,
                            onPressed: () {
                              print('about');
                              /*Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new SearchArticle()),
                              );*/
                            },
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 20,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(Icons.add),
                            color: Colors.white,
                            onPressed: () {
                              print('langue');
                            },
                          ),
                        ),
                      ],
                    ),*/
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 20,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(Icons.pets),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => new ListeArticle(
                                    equalchnoi: 'pets',
                                    orderbyme: 'category',
                                    messagesRef: FirebaseDatabase.instance
                                        .reference()
                                        .child('article'),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 20,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(Icons.people),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => new ListeArticle(
                                        equalchnoi: 'people',
                                        orderbyme: 'category',
                                        messagesRef: FirebaseDatabase.instance
                                            .reference()
                                            .child('article'))),
                              );
                            },
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 20,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(Icons.mobile_screen_share),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => new ListeArticle(
                                        equalchnoi: 'mobile',
                                        orderbyme: 'category',
                                        messagesRef: FirebaseDatabase.instance
                                            .reference()
                                            .child('article'))),
                              );
                            },
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 20,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(Icons.directions_car),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => new ListeArticle(
                                        equalchnoi: 'voiture',
                                        orderbyme: 'category',
                                        messagesRef: FirebaseDatabase.instance
                                            .reference()
                                            .child('article'))),
                              );
                            },
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 20,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(Icons.shopping_bag),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => new ListeArticle(
                                        equalchnoi: 'document',
                                        orderbyme: 'category',
                                        messagesRef: FirebaseDatabase.instance
                                            .reference()
                                            .child('article'))),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Botna_ui(
                            texte: 'all',
                            lostfound: 'all',
                            otherpage: '/listearticle',
                            iconphoto: Icons.account_circle_rounded),
                        Botna_ui(
                            texte: 'lost',
                            lostfound: 'lost',
                            otherpage: '/listearticle',
                            iconphoto: Icons.account_circle_rounded),
                        Botna_ui(
                            texte: 'found',
                            otherpage: '/listearticle',
                            lostfound: 'found',
                            iconphoto: Icons.account_circle_rounded),
                      ],
                    ),
                    /* */
                    SizedBox(
                      height: 800,
                      child: FirebaseAnimatedList(
                        key: ValueKey<bool>(false),
                        query: FirebaseDatabase.instance
                            .reference()
                            .child('article'),
                        itemBuilder: (BuildContext context,
                            DataSnapshot snapshot,
                            Animation<double> animation,
                            int index) {
                          return SizeTransition(
                            sizeFactor: animation,
                            child: ListTile(
                                title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                  Article_ui(
                                    periode:
                                        snapshot.value['periode'].toString(),
                                    location:
                                        snapshot.value['location'].toString(),
                                    reward: snapshot.value['reward'].toString(),
                                    description: snapshot.value['description']
                                        .toString(),
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
              ],
            ),
          )),
    );
  }
}
