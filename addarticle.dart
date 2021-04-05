import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lostandfound/ui/textme.dart';
import 'dart:async';
import 'dart:io' show File, Platform;
import 'package:path/path.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home.dart';
import 'ui/bottomnavigation.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

class AddArticle extends StatefulWidget {
  AddArticle({this.app});
  final FirebaseApp app;
  @override
  _AddArticleState createState() => _AddArticleState();
}

class _AddArticleState extends State<AddArticle> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _image;
  String _titre;
  String _category;
  String _periode;
  String _location;
  String _reward;
  String _description;
  String _lostfound;
  String _tags;
  String _phone;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      FirebaseAuth auth = FirebaseAuth.instance;
      if (auth.currentUser == null) {
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => new Home()));
      }
    });
    void insertionbd(
        String _image,
        String _titre,
        String _category,
        String _periode,
        String _location,
        String _reward,
        String _description,
        String _lostfound,
        String _tags,
        String _phone) {
      DateTime now = new DateTime.now();
      DateTime date = new DateTime(
          now.year, now.month, now.day, now.hour, now.minute, now.second);
      String dateadd = date.toString();
      FirebaseAuth auth = FirebaseAuth.instance;
      String _email = auth.currentUser.email;
      final databaseReference = FirebaseDatabase.instance.reference();
      databaseReference.child("article").update({
        'A$_titre': {
          'image': '$_image',
          'titre': '$_titre',
          'category': '$_category',
          'periode': '$_periode',
          'location': '$_location',
          'reward': '$_reward',
          'description': '$_description',
          'lostfound': '$_lostfound',
          'tags': '$_tags',
          'all': 'all',
          'dateadd': '$dateadd',
          'email': '$_email',
          'phone': '$_phone'
        }
      });
      Fluttertoast.showToast(
          msg: "article ajouter",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => new Home()),
      );
    }

    File _imageFile;

    Future pickImage() async {
      //final pickedFile = await picker.getImage(source: ImageSource.camera);
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
          Fluttertoast.showToast(
              msg: "upload succes picture",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);
          String imageFileName =
              DateTime.now().millisecondsSinceEpoch.toString();
          var snapshoat = await _storage
              .ref()
              .child('image/' + imageFileName)
              .putFile(file);
          var doenloadUrl = await snapshoat.ref.getDownloadURL();
          print(imageFileName);
          setState(() {
            _image = doenloadUrl;
          });
        } else {
          Fluttertoast.showToast(
              msg: "no Path  Received",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        Fluttertoast.showToast(
            msg: "Grant Permission And try Again",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }

    Future uploadImageToFirebase(BuildContext context) async {
      String fileName = basename(_imageFile.path);
      print(fileName);
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("image1" + DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(_imageFile);
      uploadTask.then((res) {
        res.ref.getDownloadURL().then(
              (value) => print("Done: $value"),
            );
        return basename;
      });
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Add Article'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        bottomNavigationBar: BotmNavigate(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      onPressed: () {
                        pickImage();
                      },
                      child: Text("choisir une image "),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.title,
                          color: Colors.grey,
                        ),
                        hintText: 'titre ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'titre n est pas vide';
                        } else {
                          _titre = value;
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: DropdownButton<String>(
                      value: _lostfound,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 30, //this inicrease the size
                      elevation: 16,
                      style: TextStyle(color: Colors.black),
                      underline: Container(),
                      onChanged: (String newValue) {
                        setState(() {
                          _lostfound = newValue;
                        });
                      },
                      items: <String>['Choose the id proof!', 'lost', 'found']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  Textme(texte: 'date'),
                  DatePickerWidget(
                    looping: false, // default is not looping
                    firstDate: DateTime(2021),
                    lastDate: DateTime.now(),
                    initialDate: DateTime(2021),
                    dateFormat: "dd-MMM-yyyy",
                    locale: DatePicker.localeFromString('en'),
                    onChange: (DateTime newDate, _) =>
                        _periode = newDate.toString(),
                    pickerTheme: DateTimePickerTheme(
                      itemTextStyle:
                          TextStyle(color: Colors.black, fontSize: 19),
                      dividerColor: Colors.blue,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.location_on,
                          color: Colors.grey,
                        ),
                        hintText: 'location ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'location n est pas vide';
                        } else {
                          _location = value;
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
                          Icons.monetization_on,
                          color: Colors.grey,
                        ),
                        hintText: 'reward ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'reward n est pas vide';
                        } else {
                          _reward = value;
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
                          Icons.description,
                          color: Colors.grey,
                        ),
                        hintText: 'description ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'description n est pas vide';
                        } else {
                          _description = value;
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: DropdownButton<String>(
                      value: _category,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 30, //this inicrease the size
                      elevation: 16,
                      style: TextStyle(color: Colors.black),
                      underline: Container(),
                      onChanged: (String newValue) {
                        setState(() {
                          _category = newValue;
                        });
                      },
                      items: <String>[
                        'Choose the id proof!',
                        'pets',
                        'people',
                        'mobile',
                        'voiture',
                        'document'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
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
                        hintText: 'tags ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'tags n est pas vide';
                        } else {
                          _tags = value;
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
                          Icons.local_phone,
                          color: Colors.grey,
                        ),
                        hintText: 'phone ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'phone n est pas vide';
                        } else {
                          _phone = value;
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
                child: Text("ajouter "),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    insertionbd(_image, _titre, _category, _periode, _location,
                        _reward, _description, _lostfound, _tags, _phone);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
