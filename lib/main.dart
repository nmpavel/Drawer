import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? image;
  bool showTextField = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 250,
                child: image != null
                    ? Image.file(
                        image!,
                        fit: BoxFit.cover,
                      )
                    : Center(),
              ),
              showTextField
                  ? Container(
                      height: 200,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      padding: EdgeInsets.all(15),
                      child: TextFormField(
                        decoration: InputDecoration(border: InputBorder.none),
                        maxLines: 7,
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : Center(),
            ],
          ),
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          backgroundColor: Colors.black,
          overlayColor: Colors.black,
          overlayOpacity: 0.4,
          children: [
            SpeedDialChild(
              child: Icon(Icons.brush),
            ),
            SpeedDialChild(
                child: Icon(Icons.text_fields),
                onTap: () {
                  setState(() {
                    showTextField = true;
                  });
                }),
            SpeedDialChild(
                child: Icon(Icons.camera),
                onTap: () {
                  pickImageC();
                }),
            SpeedDialChild(
                child: Icon(Icons.photo),
                onTap: () {
                  pickImage();
                }),
          ],
        ),
      );

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
}
