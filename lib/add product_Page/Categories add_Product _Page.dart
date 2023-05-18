

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jpgroceroyadmin/const_PAge.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';

class Categories_add_Page extends StatefulWidget {

 String?docid;
 String?id;
 Categories_add_Page(this.docid,this.id,);

  @override
  State<Categories_add_Page> createState() => _Categories_add_PageState();
}

class _Categories_add_PageState extends State<Categories_add_Page> {

  //controllers


  TextEditingController product_name=TextEditingController();
  TextEditingController product_subname=TextEditingController();
  TextEditingController product_orgprice=TextEditingController();
  TextEditingController product_price=TextEditingController();
  TextEditingController product_quvantity=TextEditingController();
  TextEditingController mininmumproduct_quvantity=TextEditingController();
  TextEditingController type=TextEditingController();

@override
  void initState() {
  setState(() {
     product_name.clear();
     product_subname.clear();
     product_orgprice.clear();
     product_price.clear();
     product_quvantity.clear();
     mininmumproduct_quvantity.clear();
     type.clear();
  });
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    
    final double height=MediaQuery.of(context).size.height;
    final double width=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Primarycolor,
        title:  Text("Add New Categories Products",style: GoogleFonts.poppins(
            fontSize: width/24,
            fontWeight: FontWeight.w600,
            color: Colors.white
        ),),
      ),
      body:
      SingleChildScrollView(
        child: Center(
          child: Container(
            width: width/0.9,
            height: 750,
            decoration: BoxDecoration(
                color: Primarycolor.withOpacity(0.8)

            ),
            child: Column(
              children: [
                SizedBox(height:height/25.6),
                //select image
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Select the Image",style: GoogleFonts.poppins(color: Colors.white),),
                            ],
                          ),
                          SizedBox(height:height/151.2),
                          InkWell(
                            onTap: (){
                              _getFromGallery();
                            },
                            child: Container(
                              height:height/10.12,
                              width:width/1.1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.white38
                              ),
                              child:
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  imgUrl!=""?
                                  Text("Image Selected",style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize:width/30
                                  ),):
                                  Text("Select Image",style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize:width/30
                                  ),),
                                  SizedBox(width: width/72,),
                                  Container(
                                    height: 90,
                                    width: 90,
                                    child:
                                    imgUrl!=""?Image.network(imgUrl):SizedBox(),
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
                SizedBox(height:height/75.6),
                //categeries textfield
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
                              controller: product_name,
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
                          Text("Product MRP",style: GoogleFonts.poppins(color: Colors.white),),
                          SizedBox(height:height/151.2),
                          Container(
                            height:height/15.12,
                            width:width/2.3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.white38
                            ),
                            child: TextField(
                              controller: product_subname,
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
                              controller: product_price,
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
                              controller: product_quvantity,
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
                              controller: product_orgprice,
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
                              controller: mininmumproduct_quvantity,
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
                SizedBox(height:height/25.2),


                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    //cancel button
                    InkWell(
                      onTap: (){

                        claerall();

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
                    SizedBox(width: width/36.0,),

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
                          width:width/3.60,
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
      ),

    );
  }



//firestore create data function

  Create(){
    FirebaseFirestore.instance.collection("Categories").doc(widget.docid).collection("products").doc(widget.id)
        .collection("products2").doc()
        .set({
      "img":imgUrl,
      "name":product_name.text,
      "name2":"MRP - ${product_subname.text}",
      "orgprice":int.parse(product_orgprice.text),
      "price":int.parse(product_price.text),
      "quvantity":int.parse(product_quvantity.text),
      "minimum_quvantity":int.parse(mininmumproduct_quvantity.text),


    });

    FirebaseFirestore.instance.collection("All").doc().set({
      "img":imgUrl,
      "name":product_name.text,
      "name2":"MRP - ${product_subname.text}",
      "orgprice":int.parse(product_orgprice.text),
      "price":int.parse(product_price.text),
      "quvantity":int.parse(product_quvantity.text),
      "minimum_quvantity":int.parse(mininmumproduct_quvantity.text),


    });


  }

  claerall(){
    product_subname.clear();
    product_name.clear();
    product_orgprice.clear();
    product_price.clear();
    product_quvantity.clear();
    mininmumproduct_quvantity.clear();
    type.clear();
    setState(() {
      imgUrl="";
    });
  }

  //dialog box

  showdialog(){
    final double height=MediaQuery.of(context).size.height;
    final double width=MediaQuery.of(context).size.width;

    return showDialog(context: context, builder: (context) {
      return
        AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            height: height/2.52,
            width: width/1.2,
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

                SizedBox(height:  height/50.4,),

                InkWell(
                  onTap: (){

                      Create();
                      claerall();
                      Navigator.pop(context);
                      Navigator.pop(context);

                  },
                  child: Container(
                    height: height/18.9,
                    width: width/4,
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







}
