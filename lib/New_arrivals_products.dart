
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jpgroceroyadmin/const_PAge.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';

class Arrival_Products extends StatefulWidget {
  const Arrival_Products({Key? key}) : super(key: key);

  @override
  State<Arrival_Products> createState() => _Arrival_ProductsState();
}

class _Arrival_ProductsState extends State<Arrival_Products> {

  TextEditingController productname=TextEditingController();
  TextEditingController productsubname=TextEditingController();
  TextEditingController productprice=TextEditingController();
  TextEditingController productorgprice=TextEditingController();
  TextEditingController productdescription=TextEditingController();
  TextEditingController productQuvantity=TextEditingController();
  TextEditingController productminQuvantity=TextEditingController();


  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;

    return
      Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Primarycolor,
          title:  Text("Add New Categories Products",style: GoogleFonts.poppins(
              fontSize: width/24,
              fontWeight: FontWeight.w600,
              color: Colors.white
          ),),
        ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
              shadowColor:Primarycolor,
              elevation: 55,
              child: Container(
                width: width/0.9,
                height: 756,
                decoration: BoxDecoration(
                  color: Primarycolor,
                  borderRadius: BorderRadius.circular(10)
                ),
                child:
                Column(
                  children: [



                    SizedBox(height: height/45.6),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        SizedBox(width: width/36.0,),
                        InkWell(

                          onTap: (){

                            _getFromGallery();

                          },
                          child: Container(
                            height: height/10.12,
                            width: width/1.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.white38
                            ),
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      child:
                                      imgUrl!=""?Image.network(imgUrl):
                                      Container()
                                      ,
                                    ),
                                    SizedBox(width: 15,),
                                    imgUrl!=""?
                                    Text("Image Selected  ",style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: width/30
                                    ),)
                                    :Text("Select Image",style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontSize: width/30
                                    ),),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),

                    //Product Tittle  and Product subTittle
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
                          child: Column(

                            children: [
                              Text("Product Name",style: GoogleFonts.poppins(color: Colors.white),),
                              SizedBox(height:height/151.2),
                              Container(
                                height:height/15.12,
                                width:width/2.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.white38
                                ),
                                child: TextField(
                                  controller: productname,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize:width/30,
                                      color: Colors.black
                                  ),
                                  cursorColor: Colors.indigo,

                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(left:width/18),
                                      hintText: "Apple",
                                      hintStyle: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize:width/30,
                                          color: Colors.black54
                                      )
                                  ),
                                ),
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                        SizedBox(width: 10,),

                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Product Tittle-1
                              Text("MRP Price",style: GoogleFonts.poppins(color: Colors.white),),
                              SizedBox(height:height/151.2),
                              Container(
                                height:height/15.12,
                                width:width/2.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.white38
                                ),
                                child: TextField(
                                  controller: productsubname,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize:width/30,
                                      color: Colors.black
                                  ),
                                  cursorColor: Colors.indigo,

                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(left:width/18),
                                      hintText: "0.00",
                                      hintStyle: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize:width/30,
                                          color: Colors.black54
                                      )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height:height/75.6),





                    //Product price textfield
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Product Tittle-1
                              Text("Product Price",style: GoogleFonts.poppins(color: Colors.white),),
                              SizedBox(height:height/151.2),
                              Container(
                                height:height/15.12,
                                width:width/2.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.white38
                                ),
                                child: TextField(
                                  controller: productprice,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize:width/30,
                                      color: Colors.black54
                                  ),
                                  cursorColor: Colors.indigo,

                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(left:width/18),
                                      hintText: "0.00",
                                      hintStyle: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize:width/30,
                                          color: Colors.black54
                                      )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Product Tittle-1
                              Text("Product Quantity",style: GoogleFonts.poppins(color: Colors.white),),
                              SizedBox(height:height/151.2),
                              Container(
                                height:height/15.12,
                                width:width/2.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.white38
                                ),
                                child: TextField(
                                  controller: productQuvantity,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize:width/30,
                                      color: Colors.black54
                                  ),
                                  cursorColor: Colors.indigo,

                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(left:width/18),
                                      hintText: "0.00",
                                      hintStyle: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize:width/30,
                                          color: Colors.black54
                                      )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:height/75.6),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Column(

                            children: [
                              //Product Tittle-1
                              Text("Whole Sale Price",style: GoogleFonts.poppins(color: Colors.white),),
                              SizedBox(height:height/151.2),
                              Container(
                                height:height/15.12,
                                width:width/2.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.white38
                                ),
                                child: TextField(
                                  controller: productorgprice,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize:width/30,
                                      color: Colors.black54
                                  ),
                                  cursorColor: Colors.indigo,

                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(left:width/18),
                                      hintText: "0.00",
                                      hintStyle: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize:width/30,
                                          color: Colors.black54
                                      )
                                  ),
                                ),
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Product Tittle-1
                              Text("Whole Sale Quantity",style: GoogleFonts.poppins(color: Colors.white),),
                              SizedBox(height:height/151.2),

                              Container(
                                height:height/15.12,
                                width:width/2.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.white38
                                ),
                                child: TextField(
                                  controller: productminQuvantity,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize:width/30,
                                      color: Colors.black54
                                  ),
                                  cursorColor: Colors.indigo,

                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(left:width/18),
                                      hintText: "0.00",
                                      hintStyle: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize:width/30,
                                          color: Colors.black54
                                      )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:height/75.6),


                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Text("Enter the Product Description",style: GoogleFonts.poppins(color: Colors.white),),
                      ],
                    ),
                    SizedBox(height: height/75.6),

                    Container(
                      height: height/7.8,
                      width: width/1.05,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.white38
                      ),
                      child: TextField(
                        maxLines: 5,
                        minLines: 1,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: width/30,
                            color: Colors.black
                        ),
                        cursorColor: Colors.indigo,
                        controller: productdescription,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: width/28),
                            hintText: "Enter the product description",
                            hintStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: width/30,
                                color: Colors.black54
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: height/17.8,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        //cancel button
                        InkWell(
                          onTap: (){

                            clearallcontroll();

                          },
                          child: Container(
                            height: height/18.9,
                            width: width/3.6,
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
                        SizedBox(width: width/12,),

                        //Submit button
                        InkWell(
                          onTap: (){
                            showdialog();
                          },
                          child: Material(
                            elevation: 25,
                            color: Colors.transparent,
                            child: Container(
                              height: height/18.9,
                              width: width/3.6,
                              decoration: BoxDecoration(
                                  color: Color(0xff22c1c3),
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
                        SizedBox(width: width/12,),


                      ],
                    ),

                    SizedBox(height:height/25.2),


                  ],
                ),


              ),
            ),
          ],
        ),
      ),

    );
  }

  clearallcontroll(){

    productprice.clear();
    productdescription.clear();
    productsubname.clear();
    productname.clear();
    productorgprice.clear();
    productQuvantity.clear();
    productminQuvantity.clear();
    setState(() {
      imgUrl="";
    });

  }



  submitthedate(){
    FirebaseFirestore.instance.collection("New Arrivals").doc().set({
      "des":productdescription.text,
      "img":imgUrl,
      "name":productname.text,
      'name2':"MRP - ${productsubname.text}",
      'price':int.parse(productprice.text),
      'orgprice':int.parse(productorgprice.text),
      "quantity":int.parse(productQuvantity.text),
      "minimum_quvantity":int.parse(productminQuvantity.text)
    });

  }


  //dialog box

  showdialog(){
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;

    return showDialog(context: context, builder: (context) {
      return
        AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
        height: height/2.52,
            width: width/120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Color(0xff263646),
            ),
            child: Column(
              children: [

                SizedBox(height: height/25.2,),
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
                    submitthedate();
                    clearallcontroll();
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: height/18.9,
                    width: width/2.1,
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

  String fileName = Uuid().v1();
  String imgUrl='';
  int status=0;
  File?imageFile;

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

}
