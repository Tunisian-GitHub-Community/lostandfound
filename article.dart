//system package
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lostandfound/home.dart';
import 'ui/bottomnavigation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ui/textme.dart';

class Article extends StatelessWidget {
  final String title;
  final String image;
  final String periode;
  final String lblassa;
  final String typelost;
  final String reward;
  final String description;
  final String tags;
  final String postedby;
  final String phonenumber;
  Article(
      {this.title,
      this.image,
      this.periode,
      this.lblassa,
      this.typelost,
      this.reward,
      this.description,
      this.tags,
      this.postedby,
      this.phonenumber});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(title),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => new Home())),
          ),
        ),
        bottomNavigationBar: BotmNavigate(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 300, // hard coding child width
                child: CachedNetworkImage(
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  imageUrl: image,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        typelost,
                        style: TextStyle(
                            backgroundColor: Colors.yellow,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(periode),
                      Text(lblassa),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Textme(texte: title),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Location ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(lblassa),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Reward ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(reward),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Textme(texte: description),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(
                        Icons.favorite,
                        color: Colors.pink,
                        size: 24.0,
                        semanticLabel:
                            'Text to announce in accessibility modes',
                      ),
                      IconButton(
                        icon: new Icon(Icons.mail),
                        tooltip: 'mail',
                        onPressed: () {
                          launch('mailto://kamel@mailna.in');
                        },
                      ),
                      IconButton(
                        icon: new Icon(Icons.info_outline),
                        tooltip: 'info',
                        onPressed: () {
                          //launch('mailto://kamel@mailna.in');
                        },
                      ),
                      IconButton(
                        icon: new Icon(Icons.share),
                        tooltip: 'share',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Textme(texte: tags),
              /*Text("send message"),
              SizedBox(
                height: 10.0,
              ),*/
              Textme(texte: phonenumber),
              ElevatedButton(
                  onPressed: () => launch('tel://$phonenumber'),
                  child: new Text("Call me")),
            ],
          ),
        ),
      ),
    );
  }
}
