/*//system package
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
import 'package:lostandfound/parametre.dart';
import 'package:lostandfound/home.dart';
import 'package:lostandfound/register.dart';
import 'package:lostandfound/main.dart';
import 'package:lostandfound/signin.dart';
import 'package:lostandfound/register.dart';
import 'package:lostandfound/profile.dart';
import 'package:lostandfound/button.dart';
import 'package:lostandfound/searcharticle.dart';
import 'package:lostandfound/listearticle.dart';
import 'package:lostandfound/ui/bottomnavigation.dart';
import 'package:lostandfound/article.dart';








Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Article_ui(
                            titre: 'article 1',
                            image: 'https://picsum.photos/250?image=9'),
                        Article_ui(
                            titre: 'article 2',
                            image: 'https://picsum.photos/250?image=9'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Article_ui(
                            titre: 'article 3',
                            image: 'https://picsum.photos/250?image=9'),
                        Article_ui(
                            titre: 'article 4',
                            image: 'https://picsum.photos/250?image=9'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Article_ui(
                            titre: 'article 5',
                            image: 'https://picsum.photos/250?image=9'),
                        Article_ui(
                            titre: 'article 6',
                            image: 'https://picsum.photos/250?image=9'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Article_ui(
                            titre: 'article 7',
                            image: 'https://picsum.photos/250?image=9'),
                        Article_ui(
                            titre: 'article 8',
                            image: 'https://picsum.photos/250?image=9'),
                      ],
                    ),
*/
/*import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File _imageFile;

  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();

    Future pickImage() async {
      final pickedFile = await picker.getImage(source: ImageSource.camera);

      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }

    Future uploadImageToFirebase(BuildContext context) async {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("image1" + DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(_imageFile);
      uploadTask.then((res) {
        res.ref.getDownloadURL().then(
              (value) => print("Done: $value"),
            );
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Edit Profile'),
      ),
      body: Builder(
        builder: (context) => Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: Color(0xff476cfb),
                      child: ClipOval(
                        child: new SizedBox(
                          width: 180.0,
                          height: 180.0,
                          child: (_image != null)
                              ? Image.file(
                                  _image,
                                  fit: BoxFit.fill,
                                )
                              : Image.network(
                                  "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 60.0),
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.camera,
                        size: 30.0,
                      ),
                      onPressed: () {
                        getImage();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Username',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 18.0)),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Michelle James',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      child: Icon(
                        FontAwesomeIcons.pen,
                        color: Color(0xff476cfb),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Birthday',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 18.0)),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('1st April, 2000',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      child: Icon(
                        FontAwesomeIcons.pen,
                        color: Color(0xff476cfb),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Location',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 18.0)),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Paris, France',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      child: Icon(
                        FontAwesomeIcons.pen,
                        color: Color(0xff476cfb),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('Email',
                        style:
                            TextStyle(color: Colors.blueGrey, fontSize: 18.0)),
                    SizedBox(width: 20.0),
                    Text('michelle123@gmail.com',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Color(0xff476cfb),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    elevation: 4.0,
                    splashColor: Colors.blueGrey,
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                  RaisedButton(
                    color: Color(0xff476cfb),
                    onPressed: () {
                      uploadPic(context);
                    },
                    elevation: 4.0,
                    splashColor: Colors.blueGrey,
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
*/
/*
uploadImage(
        String _titre,
        String _category,
        String _periode,
        String _location,
        String _reward,
        String _description,
        String _lostfound,
        String _tags,
        String _phone) async {
      final _storage = FirebaseStorage.instance;

      final _picker = ImagePicker();

      PickedFile image;

      //check permission
      await Permission.photos.request();

      var permissionStatus = await Permission.photos.status;

      if (permissionStatus.isGranted) {
        //Selected Image
        image = await _picker.getImage(source: ImageSource.gallery);

        var file = File(image.path);

        if (image != null) {
          //Upload to Firebase
          String imageFileName =
              DateTime.now().millisecondsSinceEpoch.toString();
          //Upload to Firebase
          var snapshoat = await _storage
              .ref()
              .child('image/' + imageFileName)
              .putFile(file);
          var doenloadUrl = await snapshoat.ref.getDownloadURL();

          setState(() {
            _image = doenloadUrl;
          });
        } else {
          print("no Path  Received");
        }
      } else {
        print("Grant Permission And try Again");
      }
    }
    */
/*
                  TextFormField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.broken_image,
                        color: Colors.grey,
                      ),
                      hintText: ' image',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      } else {
                        _image = value;
                        return null;
                      }
                    },
                  ),*/

/*TextFormField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintText: 'lost w ela found ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      } else {
                        _lostfound = value;
                        return null;
                      }
                    },
                  ),*/
// Image.network('https://picsum.photos/250?image=9'),
/*SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintText: 'birthday  ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      } else {
                        _birthday = value;
                        return null;
                      }
                    },
                  ),*/
/*Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(' facebook'),
                    Text(" google"),
                    Text(" huawei"),
                  ],
                ),
              ],
            ),*/
/*Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(' facebook'),
                    Text(" google"),
                    Text(" huawei"),
                  ],
                ),
              ],
            ),*/
/*final db = FirebaseDatabase.instance.reference().child("article");
      db.once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) {
          print(values["category"]);
        });
      });*/
//DatabaseReference _messagesRef = ;
//FirebaseDatabase.instance.reference().child('article');
/*Image.network(
                image,
                width: 300.0,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace stackTrace) {
                  return Text('😢');
                },
              ),*/

/*Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.date_range,
                          color: Colors.grey,
                        ),
                        hintText: 'periode mmeli dha3t ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'periode n est pas vide';
                        } else {
                          _periode = value;
                          return null;
                        }
                      },
                    ),
                  ),*/
