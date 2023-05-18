


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jpgroceroyadmin/Categeries_list_Page3.dart';
import 'package:jpgroceroyadmin/add%20product_Page/Categories%20add_Product%20_Page.dart';
import 'package:jpgroceroyadmin/const_PAge.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';

class Categerire_Lists_Page2 extends StatefulWidget {

   String?docid;
Categerire_Lists_Page2(this.docid);

  @override
  State<Categerire_Lists_Page2> createState() => _Categerire_Lists_Page2State();
}

class _Categerire_Lists_Page2State extends State<Categerire_Lists_Page2> {

  bool click=false;

  TextEditingController product_name=TextEditingController();
  TextEditingController product_name2=TextEditingController();


  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
         backgroundColor: Primarycolor,
        title: Text("Sub Categories  Lists",style: GoogleFonts.poppins(color: Colors.white,fontSize: 16,

            fontWeight: FontWeight.bold),),
      ),
      body:
      click==false?
      Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          width: width/1.028,
          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            children: [
              SizedBox(height: height/37.8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  InkWell(
                    onTap: (){
                      //add prodicy navigation
                      setState(() {
                        click=true;
                      });
                    },
                    child: Container(
                      height: height/25.2,
                      width: width/2.60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Primarycolor,
                      ),
                      child: Center(
                        child: Text("Add Sub Categories",style: GoogleFonts.poppins(
                          fontWeight:FontWeight.bold,
                          color: Colors.white,
                          fontSize: width/30
                        ),),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: height/25.2,),

              Padding(
                padding:  EdgeInsets.symmetric(
                  horizontal: width/36.0,
                  vertical: height/75.6
                ),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("Categories")
                      .doc(widget.docid).collection("products").orderBy("name",descending: false).snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData==null){
                      return Center(child: CircularProgressIndicator(),);
                    }
                    if(!snapshot.hasData){
                      return Center(child: CircularProgressIndicator(),);
                    }
                    return   GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 5.5/7,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5
                        ),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index){
                          var value=snapshot.data!.docs[index];
                          return InkWell(
                            onTap: (){

                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                  categeries_List_Page3(widget.docid,value.id,value["name"]),));
                            },
                            child: Container(
                              height: height/7.56,
                              width: width/3.60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Primarycolor.withOpacity(0.8)
                              ),
                              child:
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Container(
                                    height: height/15.12,
                                    width: width/7.2,
                                    child: Image.network(value['img']),
                                  ),

                                  SizedBox(height: height/75.6,),

                                  Container(
                                    width: width/4.5,
                                    child: Center(
                                      child: Text(value['name'],style:
                                      GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize:width/30,
                                          textStyle: TextStyle(
                                            overflow: TextOverflow.ellipsis
                                          ),
                                          fontWeight: FontWeight.w700),),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    children: [
                                      SizedBox(width: 7,),

                                      GestureDetector(
                                        onTap:(){
                                          editshowpop(value.id);
                                        },
                                        child: Container(
                                          height: 20,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.blueGrey,
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Icon(Icons.edit,size: 20,color: Colors.white,),
                                        ),
                                      ),

                                      SizedBox(width: 10,),

                                      GestureDetector(
                                        onTap: (){
                                          deleteshowpop(value.id);
                                        },
                                        child: Container(
                                          height: 20,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.blueGrey,
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Icon(Icons.delete,size: 20,color: Colors.white,),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ),
                          );

                        });
                  },),
              )
            ],
          ),




        ),
      ):

      Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(
            horizontal: width/12,
            vertical: height/25.2
          ),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            color: Colors.transparent,

            elevation: 0,
            child: Container(
              height: height/1.89,
              width: width/1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                children: [
                  SizedBox(height:height/25.2),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Add New Categories Products",style: GoogleFonts.poppins(
                          fontSize: width/30,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                      ),),
                    ],
                  ),
                  SizedBox(height:height/37.8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: width/36.0,),
                      Container(
                        child: Column(
                          children: [
                            Text("Categories Name",style:
                            GoogleFonts.poppins(color: Colors.black),),
                            SizedBox(height:height/75.6),
                            Container(
                              height: height/18.9,
                              width: width/1.8,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.green
                              ),
                              child: TextField(
                                controller: product_name2,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: width/25,
                                    color: Colors.white
                                ),
                                cursorColor: Colors.indigo,

                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: width/18,bottom: 15),
                                    hintText: "Enter the product name",
                                    hintStyle: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize:  width/25,
                                        color: Colors.white
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                    ],
                  ),
                  SizedBox(height:height/37.8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       SizedBox(width:width/36.0,),
                       Container(
                         child: Column(
                           children: [
                             Text("Select the Image",style: GoogleFonts.poppins(
                                 color: Colors.black),),
                             SizedBox(height:height/75.6),
                             InkWell(
                               onTap: (){

                                 _getFromGallery2();

                               },
                               child: Container(
                                 height:height/18.9,
                                 width: width/1.8,
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(7),
                                     color: Colors.green
                                 ),
                                 child:
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [

                                     imgUrl2!=""?
                                     Text("Image Selected",style: GoogleFonts.poppins(
                                         fontWeight: FontWeight.w600,
                                         color: Colors.white,
                                         fontSize: width/30
                                     ),):
                                     Text("Select Image",style: GoogleFonts.poppins(
                                         fontWeight: FontWeight.w600,
                                         color: Colors.white,
                                         fontSize: width/30
                                     ),),
                                     SizedBox(width: width/72,),
                                     Container(
                                       height: height/30.24,
                                       width: width/14.4,
                                       child: imgUrl2!=""?Image.network(imgUrl2):SizedBox(),
                                     )
                                   ],
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ),
                     ],
                  ),


                  SizedBox(height:height/15.12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      //cancel button
                      InkWell(
                        onTap: (){
                          clearallcontroll2();
                        },
                        child: Container(
                          height:height/25.2,
                          width:width/3.60,
                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(4)
                          ),
                          child: Center(
                            child: Text("Cancel",style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                color: Colors.black
                            ),),
                          ),
                        ),
                      ),


                      //Submit button
                      InkWell(
                        onTap: (){

                          showdialog();
                        },
                        child: Material(
                          elevation: 25,
                          color: Colors.transparent,
                          child: Container(
                            height:height/25.2,
                            width:width/3.60,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(4)
                            ),
                            child: Center(
                              child: Text("Submit",style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white
                              ),),
                            ),
                          ),
                        ),
                      ),



                    ],
                  )


                ],
              ),


            ),
          ),
        ),
      ),

    );
  }



  //dialog box

  showdialog(){

    return showDialog(context: context, builder: (context) {
      final double width=MediaQuery.of(context).size.width;
      final double height=MediaQuery.of(context).size.height;
      return
        AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            height:height/25.20,
            width: width/0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Color(0xff263646),
            ),
            child: Column(
              children: [

                SizedBox(height:height/25.2,),
                Text("Add Product Successfully",style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: width/24
                ),),
                SizedBox(height: height/50.4,),
                Container(
                  height: height/5.04,
                  width: width/2.4,
                  child: Lottie.network("https://assets10.lottiefiles.com/packages/lf20_xwmj0hsk.json"),
                ),

                SizedBox(height: height/50.4,),

                InkWell(
                  onTap: (){
                      createdata();
                      clearallcontroll2();
                      setState(() {
                        click = false;
                      });



                  },
                  child: Container(
                    height:height/18.9,
                    width: width/9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        "Okay",style: GoogleFonts.poppins(color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      ),
                    ),
                  ),
                )

              ],
            ),

          ),
        );
    },);
  }

  String imgUrl='';
  int status=0;

  File?imageFile;

  String imgUrl2='';


  File?imageFile2;
  String fileName = Uuid().v1();

  _getFromGallery() async {
    PickedFile ?pickedFile = (await ImagePicker().getImage(source: ImageSource.gallery,));
    if (pickedFile != null) {
       imageFile = File(pickedFile.path);
      print(imageFile);
    }

    var ref = FirebaseStorage.instance.ref().child('NewFiles').child("$imageFile.jpg");
    var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
      status = 0;
      print("error");
    });
      String imageUrl = await uploadTask.ref.getDownloadURL();
      print(imageUrl);
      setState(() {
        imgUrl=imageUrl;
      });
    print(imgUrl);

  }

  _getFromGallery2() async {
    PickedFile ?pickedFile = (await ImagePicker().getImage(source: ImageSource.gallery,));
    if (pickedFile != null) {
      imageFile2 = File(pickedFile.path);
      print(imageFile2);
    }

    var ref = FirebaseStorage.instance.ref().child('NewFiles').child("$imageFile2.jpg");
    var uploadTask = await ref.putFile(imageFile2!).catchError((error) async {
      status = 0;
      print("error");
    });
    String imageUrl = await uploadTask.ref.getDownloadURL();
    print(imageUrl);
    setState(() {
      imgUrl2=imageUrl;
    });
    print(imgUrl);

  }
  
  
  //clear all function
  clearallcontroll(){
    product_name.clear();
    setState(() {
      imgUrl="";
    });
    
  }

  //clear all function
  clearallcontroll2(){
    product_name2.clear();
    setState(() {
      imgUrl2="";
    });

  }
  
  
  //firestore create function
  createdata(){
    FirebaseFirestore.instance.collection("Categories").doc(widget.docid).collection("products").doc().set({
      "img":imgUrl2,
      "name":product_name2.text
    });
    
  }


  //edit functions

  editdata(id){
    FirebaseFirestore.instance.collection("Categories").doc(widget.docid).collection("products").doc(id).update({
      "img":imgUrl,
      "name":product_name.text
    });

  }

  setvalue(id)async{
    var doc= await FirebaseFirestore.instance.collection("Categories").doc(widget.docid).collection("products").doc(id).get();
    Map<String,dynamic>?value=doc.data();
    setState(() {
      imgUrl=value!['img'].toString();
      product_name.text=value['name'].toString();
    });


  }


  editshowpop(docid){
    setvalue(docid);
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;

    return showDialog(context: context, builder:
        (context) {

      return
        Padding(
          padding: const EdgeInsets.only(top: 90.0,bottom: 90.0),
          child: Scaffold(body: Container(
            padding: EdgeInsets.all(10),
            color: Color(0xff263646),
            child: Column(
              children: [
                SizedBox(height: 20,),

                Text("Are your Sure want to Edit..",style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 14
                ),),
                SizedBox(height: 15,),

                Center(
                  child: Padding(
                    padding:  EdgeInsets.symmetric(
                        horizontal: width/12,
                        vertical: height/25.2
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent,

                      elevation: 0,
                      child: Container(
                        height: height/1.89,
                        width: width/1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          children: [
                            SizedBox(height:height/25.2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Text("Add New Categories Products",style: GoogleFonts.poppins(
                                    fontSize: width/30,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white
                                ),),
                              ],
                            ),
                            SizedBox(height:height/37.8),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: width/36.0,),
                                Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text("Categories Name",style:
                                          GoogleFonts.poppins(color: Colors.white),),
                                        ],
                                      ),
                                      SizedBox(height:height/75.6),
                                      Container(
                                        height: height/18.9,
                                        width: width/1.5,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(7),
                                            color: Colors.green
                                        ),
                                        child: Center(
                                          child: TextField(
                                            controller: product_name,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: width/20,
                                                color: Colors.white
                                            ),
                                            cursorColor: Colors.indigo,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.only(left: width/18,bottom: 5),
                                                hintText: "Enter the product name",
                                                hintStyle: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize:  width/25,
                                                    color: Colors.white
                                                )
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),


                              ],
                            ),
                            SizedBox(height:height/37.8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width:width/36.0,),
                                Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text("Select the Image",style: GoogleFonts.poppins(
                                              color: Colors.white),),
                                        ],
                                      ),
                                      SizedBox(height:height/75.6),
                                      InkWell(
                                        onTap: (){

                                          _getFromGallery();

                                        },
                                        child: Container(
                                          height:height/10.9,
                                          width: width/1.5,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(7),
                                              color: Colors.green
                                          ),
                                          child:
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [

                                              Container(
                                                height: 90,
                                                width: 90,
                                                child: imgUrl!=""?Image.network(imgUrl):SizedBox(),
                                              ),
                                              imgUrl!=""?
                                              Text("Image Selected",style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                  fontSize: width/30
                                              ),):
                                              Text("Select Image",style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                  fontSize: width/30
                                              ),),
                                              SizedBox(width: width/72,),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),


                            SizedBox(height:height/15.12),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                //cancel button
                                InkWell(
                                  onTap: (){
                                    clearallcontroll();
                                  },
                                  child: Container(
                                    height:height/25.2,
                                    width:width/3.6,
                                    decoration: BoxDecoration(

                                        borderRadius: BorderRadius.circular(4)
                                    ),
                                    child: Center(
                                      child: Text("Cancel",style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white
                                      ),),
                                    ),
                                  ),
                                ),


                                //Submit button
                                InkWell(
                                  onTap: (){
                                    showdialog2(docid);
                                  },
                                  child: Material(
                                    elevation: 25,
                                    color: Colors.transparent,
                                    child: Container(
                                      height:height/25.2,
                                      width:width/3.6,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.circular(4)
                                      ),
                                      child: Center(
                                        child: Text("Edit",style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white
                                        ),),
                                      ),
                                    ),
                                  ),
                                ),



                              ],
                            )


                          ],
                        ),


                      ),
                    ),
                  ),
                )

              ],
            ),
          ),),
        );
    },);

  }

//edit dialog
  showdialog2(id){

    return showDialog(context: context, builder: (context) {
      final double width=MediaQuery.of(context).size.width;
      final double height=MediaQuery.of(context).size.height;
      return
        AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            height:height/25.20,
            width: width/0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Color(0xff263646),
            ),
            child: Column(
              children: [

                SizedBox(height:height/25.2,),
                Text("Edit Product Successfully",style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: width/24
                ),),
                SizedBox(height: height/50.4,),
                Container(
                  height: height/5.04,
                  width: width/2.4,
                  child: Lottie.network("https://assets10.lottiefiles.com/packages/lf20_xwmj0hsk.json"),
                ),

                SizedBox(height: height/50.4,),

                InkWell(
                  onTap: (){

                      editdata(id);
                      clearallcontroll2();
                      setState(() {
                      });



                  },
                  child: Container(
                    height:height/18.9,
                    width: width/9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        "Okay",style: GoogleFonts.poppins(color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      ),
                    ),
                  ),
                )

              ],
            ),

          ),
        );
    },);
  }

  deleteshowpop(docid){

    return showDialog(context: context, builder:
        (context) {

      return AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          padding: EdgeInsets.all(10),
          height: 250,
          width: 350,
          color: Color(0xff263646),
          child: Column(
            children: [
              SizedBox(height: 20,),

              Text("Are your Sure want to Delete..",style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 14
              ),),
              SizedBox(height: 15,),
              Container(
                height: 100,
                width: 100,
                child: Lottie.network("https://assets6.lottiefiles.com/packages/lf20_nux6g0kx.json"),
              ),
              SizedBox(height: 15,),
              GestureDetector(

                onTap: (){

                  deteletenewaarivals(docid);
                },
                child: Container(
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: Center(
                    child: Text(
                      "Okay",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                    ),
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      );
    },);

  }

  deteletenewaarivals(id){
    FirebaseFirestore.instance.collection("Categories").doc(widget.docid).collection("products").doc(id).delete();
  }




  
}

