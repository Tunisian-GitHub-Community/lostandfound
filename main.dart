//system package
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
//me package
import 'package:lostandfound/addarticle.dart';
import 'package:lostandfound/home.dart';
import 'package:lostandfound/register.dart';

import 'package:lostandfound/article.dart';

import 'chat.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final FirebaseApp app = await Firebase.initializeApp(
    name: 'db2',
    options: Platform.isIOS || Platform.isMacOS
        ? FirebaseOptions(
            appId: '1:823092957778:android:878eff8f93dfed7fb8058b',
            apiKey: 'AIzaSyAXFnqPubN8BtJecPBkWxIlAVKLBPLd7To',
            projectId: 'flutterprojectme',
            messagingSenderId: '823092957778',
            databaseURL: 'https://flutterprojectme-default-rtdb.firebaseio.com',
          )
        : FirebaseOptions(
            appId: '1:823092957778:android:878eff8f93dfed7fb8058b',
            apiKey: 'AIzaSyAXFnqPubN8BtJecPBkWxIlAVKLBPLd7To',
            messagingSenderId: '823092957778',
            projectId: 'flutterprojectme',
            databaseURL: 'https://flutterprojectme-default-rtdb.firebaseio.com',
          ),
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/article': (context) => Article(),
      '/register': (context) => Register(),
      '/home': (context) => Home(),
      '/addarticle': (context) => AddArticle(),
      /*'/depence': (context) => Parametre(),
      '/category': (context) => Home(),
      '/recette': (context) => Recette_ui(),
      '/MyHomePage': (context) => MyHomePage(),
      '/index': (context) => Index_ui(),
      '/kzr': (context) => Kzr(),
      '/home': (context) => Kzr_ui(),
      '/home': (context) => LoginPage(),
      '/home': (context) => LoginPage(),
      '/home': (context) => Parametre(),
      
      '/home': (context) => Home(),*/
    },
  ));
}
