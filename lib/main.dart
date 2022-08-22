import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? image;
  @override
  Widget build(BuildContext context) => Scaffold(

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
        ),
        SpeedDialChild(
          child: Icon(Icons.camera),
          onTap: (){
            pickImageC();
          }
        ),
        SpeedDialChild(
          child: Icon(Icons.browse_gallery),
          onTap: (){
            pickImage();
          }
        ),
      ],
    ),


  );
  Future pickImage() async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch(e){
      print('Failed to pick image: $e');
    }
  }
  Future pickImageC() async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if(image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch(e){
      print('Failed to pick image: $e');
    }
  }

}
