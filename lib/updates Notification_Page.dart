import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jpgroceroyadmin/ViewNotification_Page.dart';
import 'package:jpgroceroyadmin/app/modules/home/controllers/home_controller.dart';
import 'package:jpgroceroyadmin/const_PAge.dart';
import 'package:uuid/uuid.dart';

class UpdateNotification_Page extends StatefulWidget {
  const UpdateNotification_Page({Key? key}) : super(key: key);

  @override
  State<UpdateNotification_Page> createState() =>
      _UpdateNotification_PageState();
}

class _UpdateNotification_PageState extends State<UpdateNotification_Page> {
  final homecontroller = Get.put(HomeController());
  bool visible=false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Primarycolor,
        title: Text(
          "General Notification",
          style: GoogleFonts.poppins(),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [

          GestureDetector(
            onTap: (){
              _getFromGallery();
              setState(() {
                visible=true;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Color(0xff263646),
                child: Row(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      child: visible&&imgUrl != ""
                          ? Image.network(imgUrl)
                          : Container(),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    visible&&imgUrl != ""
                        ? Text(
                            "Image Selected  ",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: width / 30),
                          )
                        : Text(
                            "Select Image",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: width / 30),
                          ),
                  ],
                ),
              ),
            ),
          ),

          Card(
            child: Container(
              width: width / 1.1,
              height: height / 13.14,
              child: TextField(
                controller: homecontroller.title,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: width / 68.3),
                    hintText: "Title"),
              ),
            ),
          ),

          SizedBox(
            width: width / 136.6,
          ),

          Card(
            child: Container(
              width: width / 1.1,
              height: height / 13.14,
              child: TextField(
                controller: homecontroller.body,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: width / 68.3),
                    hintText: "Subtitle"),
              ),
            ),
          ),

          SizedBox(
            height: height / 16.6,
          ),

          GestureDetector(
            onTap: (){
              dailyupdate(imgUrl);
              homecontroller.findusers();
            }, child:
          Container(
            height: 40,
            width: 120,
            decoration: BoxDecoration
              (
              borderRadius: BorderRadius.circular(7),
              color: Color(0xff263646)
            ),
            child: Center(
              child: Text("Send",style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                color: Colors.white
              ),),
            ),
          ),
          ),

          SizedBox(height: 25,),

          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>Notifiocation_view_Page(),));
            },
            child: Container(
              height: 40,
              width: 250,
              decoration: BoxDecoration
                (
                  borderRadius: BorderRadius.circular(7),
                  color: Color(0xff263646)
              ),
              child: Center(
                child: Text("View Previous Notification",style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                ),),
              ),
            ),
          ),

        ],
      ),
    );
  }

  clearcontroller() {
    homecontroller.title.clear();
    homecontroller.body.clear();
    setState(() {
      imgUrl="";
    });
  }


  String fileName = Uuid().v1();
  String imgUrl = '';
  int status = 0;
  File? imageFile;

  _getFromGallery() async {
    PickedFile? pickedFile = (await ImagePicker().getImage(
      source: ImageSource.gallery,
    ));
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      print(imageFile);
    }

    var ref = FirebaseStorage.instance
        .ref()
        .child('NewFiles')
        .child("$imageFile.jpg");
    var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
      status = 0;
      print("error");
    });
    String imageUrl = await uploadTask.ref.getDownloadURL();
    print(imageUrl);
    setState(() {
      imgUrl = imageUrl;
    });
    print(imgUrl);
  }


  dailyupdate(url)async{

    var user=await FirebaseFirestore.instance.collection("Users").get();
    String fileName = Uuid().v1();

    for(int i=0;i<user.docs.length;i++) {
      FirebaseFirestore.instance
        ..collection("Users").doc(user.docs[i].id)
            .collection("dailyupdates")
            .doc(fileName)
            .set(
            {
              'update_image': url,
              'update_top_title': homecontroller.title.text,
              'updatestitle': homecontroller.body.text,
              "Read": false,
              "timestamp": DateTime
                  .now()
                  .millisecondsSinceEpoch,
            }
        );
    }
      FirebaseFirestore.instance.collection("dailyupdates").doc(fileName).set({
        'update_image':url,
        'update_top_title':homecontroller.title.text,
        'updatestitle':homecontroller.body.text,
        "Read":false,
        "timestamp":DateTime.now().millisecondsSinceEpoch,
      });



  }
}
