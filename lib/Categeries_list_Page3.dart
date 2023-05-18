
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jpgroceroyadmin/add%20product_Page/Categories%20add_Product%20_Page.dart';
import 'package:jpgroceroyadmin/const_PAge.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';

class categeries_List_Page3 extends StatefulWidget {
  String?docid;
  String?id;
  String?name;
  categeries_List_Page3(this.docid,this.id,this.name);

  @override
  State<categeries_List_Page3> createState() => _categeries_List_Page3State();
}

class _categeries_List_Page3State extends State<categeries_List_Page3> {

  bool category3=false;
  @override
  Widget build(BuildContext context) {

    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Primarycolor,
        title: Text("${widget.name} - Products  Lists",style: GoogleFonts.poppins(color: Colors.white,fontSize: 16,

            fontWeight: FontWeight.bold),),
      ),
      body:
      Column(
        children: [
          SizedBox(height: height/37.8,),
          Row(
            children: [
              SizedBox(width: width/1.44,),

              InkWell(
                onTap: (){
                  //add prodicy navigation
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Categories_add_Page(widget.docid,widget.id,),));
                },
                child: Container(
                  height: height/25.2,
                  width: width/3.60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Primarycolor,
                  ),
                  child: Center(
                    child: Text("Add Product",style: GoogleFonts.poppins(
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

                vertical: height/75.6
            ),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Categories")
                  .doc(widget.docid).collection("products").doc(widget.id).collection("products2").snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasData==null){
                  return Center(child: CircularProgressIndicator(),);
                }
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator(),);
                }
                return  ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var newaarivals=snapshot.data!.docs[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            tileColor: Colors.grey[50],
                            leading: Container(
                              height: 50,
                              width: 50,
                              child: Image.network(newaarivals["img"]),
                            ),
                            title: Row(
                              children: [
                                Text("Product Name :"),
                                Container(
                                    height: 25,
                                    width: 120,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 5.0,left: 2),
                                      child: Text(newaarivals["name"],
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 14
                                        ),),
                                    )),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("WholeSale Price :"),
                                    Container(
                                        width: 130,
                                        height: 25,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 5.0,left: 2),
                                          child: Text(newaarivals["orgprice"].toString(),style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 14
                                          ),),
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Price:"),
                                    SizedBox(width: 2,),
                                    Container(
                                        width: 50,
                                        child: Text(newaarivals["price"].toString(),style: TextStyle(
                                            overflow: TextOverflow.ellipsis
                                        ),)),
                                    SizedBox(width: 20,),

                                    //edit button
                                    InkWell(
                                      onTap: (){
                                        editshowpop(newaarivals.id);
                                        print("fdgdrgdfgdrg");
                                      },
                                      child: Container(
                                        height:25,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: Color(0xff263646),
                                            borderRadius: BorderRadius.circular(7)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Center(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.edit,color: Colors.white,size: 20,),
                                                SizedBox(width: 5,),
                                                Text("Edit",style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white
                                                ),),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width:5,),

                                    //delete button
                                    GestureDetector(
                                      onTap: ()=>deleteshowpop(widget.id,newaarivals.id),
                                      child: Tooltip(
                                        message: "Delete",
                                        child: Container(
                                          height:25,
                                          width: 72,
                                          decoration: BoxDecoration(
                                              color: Color(0xff263646),
                                              borderRadius: BorderRadius.circular(7)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Center(
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.delete,color: Colors.white,size: 20,),
                                                  SizedBox(width: 2,),
                                                  Text("Delete",style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.white
                                                  ),),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),



                                  ],
                                ),
                              ],
                            ),

                          ),
                          Divider()
                        ],
                      ),
                    );
                  },);
              },),
          )
        ],
      )
    );
  }
  
  //delete functiom
  deteletenewaarivals(id,id2){
    FirebaseFirestore.instance.collection("Categories").doc(widget.docid).collection("products").doc(id).collection("products2").doc(id2).delete();
  }
  deleteshowpop(docid,docid2){

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

                  deteletenewaarivals(docid,docid2);
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

  //edit popup

  TextEditingController product_name=TextEditingController();
  TextEditingController product_subname=TextEditingController();
  TextEditingController product_orgprice=TextEditingController();
  TextEditingController product_price=TextEditingController();
  TextEditingController product_quvantity=TextEditingController();
  TextEditingController mininmumproduct_quvantity=TextEditingController();
  TextEditingController type=TextEditingController();


    Create(id2){
      FirebaseFirestore.instance.collection("Categories").doc(widget.docid).collection("products").doc(widget.id)
          .collection("products2").doc(id2)
          .update({
        "img":imgUrl,
        "name":product_name.text,
        "name2":product_subname.text,
        "orgprice":int.parse(product_orgprice.text),
        "price":int.parse(product_price.text),
        "quvantity":int.parse(product_quvantity.text),
        "minimum_quvantity":int.parse(mininmumproduct_quvantity.text),


      });

      FirebaseFirestore.instance.collection("All").doc().set({
        "img":imgUrl,
        "name":product_name.text,
        "name2":product_subname.text,
        "orgprice":int.parse(product_orgprice.text),
        "price":int.parse(product_price.text),
        "quvantity":int.parse(product_quvantity.text),
        "minimum_quvantity":int.parse(mininmumproduct_quvantity.text),
        "type":type.text
      });


    }

    setvalue(id2)async{
      var doc=await  FirebaseFirestore.instance.collection("Categories").doc(widget.docid).collection("products").doc(widget.id)
          .collection("products2").doc(id2).get();
      Map<String,dynamic>?value=doc.data();
      setState(() {
         product_name.text=value!["name"].toString();
         product_subname.text=value["name2"].toString();
         product_orgprice.text=value["quvantity"].toString();
         product_price.text=value["quvantity"].toString();
         product_quvantity.text=value["quvantity"].toString();
         mininmumproduct_quvantity.text=value["minimum_quvantity"].toString();
         imgUrl=value["img"];
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

                SingleChildScrollView(
                  child: Container(
                    width: width/0.9,
                    decoration: BoxDecoration(
                        color: Primarycolor.withOpacity(0.8)

                    ),
                    child: Column(
                      children: [
                        SizedBox(height:height/75.6),
                        //categeries textfield
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Container(
                              child: Column(
                                children: [
                                  Text("Enter the Categories Name",style: GoogleFonts.poppins(color: Colors.white),),
                                  SizedBox(height:height/151.2),
                                  Container(
                                    height:height/15.12,
                                    width:width/1.8,
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
                                          hintText: "Enter the product name",
                                          hintStyle: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize:width/30,
                                              color: Colors.black
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

                        //select image
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Text("Select the Image",style: GoogleFonts.poppins(color: Colors.white),),
                                  SizedBox(height:height/151.2),
                                  InkWell(
                                    onTap: (){
                                      _getFromGallery();
                                    },
                                    child: Container(
                                      height:height/15.12,
                                      width:width/1.8,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(7),
                                          color: Colors.white38
                                      ),
                                      child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text("Select Image",style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize:width/30
                                          ),),
                                          SizedBox(width: width/72,),
                                          Container(
                                            height: height/15.12,
                                            width: width/14.4,
                                            child: Icon(Icons.ac_unit_rounded,color: imgUrl==""?Colors.
                                            black:Colors.white,),
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

                        //Product subtitle textfield
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Container(
                              child: Column(
                                children: [
                                  //Product Tittle-1
                                  Text("Enter the Product Subname",style: GoogleFonts.poppins(color: Colors.white),),
                                  SizedBox(height:height/151.2),
                                  Container(
                                    height:height/15.12,
                                    width:width/1.8,
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
                                          hintText: "Enter the product Subname",
                                          hintStyle: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize:width/30,
                                              color: Colors.black
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
                                children: [
                                  //Product Tittle-1
                                  Text("Enter the Product Price",style: GoogleFonts.poppins(color: Colors.white),),
                                  SizedBox(height:height/151.2),
                                  Container(
                                    height:height/15.12,
                                    width:width/1.8,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: Colors.white38
                                    ),
                                    child: TextField(
                                      controller: product_price,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize:width/30,
                                          color: Colors.black
                                      ),
                                      cursorColor: Colors.indigo,

                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(left:width/18),
                                          hintText: "Enter the product price",
                                          hintStyle: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize:width/30,
                                              color: Colors.black
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

                        //Product pricre retailer price textfield
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  //Product Tittle-1
                                  Text("Enter the Product Retailer-Price",style: GoogleFonts.poppins(color: Colors.white),),
                                  SizedBox(height:height/151.2),
                                  Container(
                                    height:height/15.12,
                                    width:width/1.8,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: Colors.white38
                                    ),
                                    child: TextField(
                                      controller: product_orgprice,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize:width/30,
                                          color: Colors.black
                                      ),
                                      cursorColor: Colors.indigo,

                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(left:width/18),
                                          hintText: "Enter the  retailerprice",
                                          hintStyle: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize:width/30,
                                              color: Colors.black
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        //Product Quvantity textfield
                        SizedBox(height:height/75.6),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  //Product Tittle-1
                                  Text("Enter the Product Quvantity",style: GoogleFonts.poppins(color: Colors.white),),
                                  SizedBox(height:height/151.2),
                                  Container(
                                    height:height/15.12,
                                    width:width/1.8,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: Colors.white38
                                    ),
                                    child: TextField(
                                      controller: product_quvantity,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize:width/30,
                                          color: Colors.black
                                      ),
                                      cursorColor: Colors.indigo,

                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(left:width/18),
                                          hintText: "Enter the product quvantity",
                                          hintStyle: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize:width/30,
                                              color: Colors.black
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
                        Text("Enter the Product Minimum Quvantity",style: GoogleFonts.poppins(color: Colors.white),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  //Product Tittle-1
                                  SizedBox(height:height/151.2),
                                  Container(
                                    height:height/15.12,
                                    width:width/1.8,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: Colors.white38
                                    ),
                                    child: TextField(
                                      controller: mininmumproduct_quvantity,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize:width/30,
                                          color: Colors.black
                                      ),
                                      cursorColor: Colors.indigo,

                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(left:width/18),
                                          hintText: "Enter the product minimum quvantity",
                                          hintStyle: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize:width/30,
                                              color: Colors.black
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
                                  Text("Enter the Product Type",style: GoogleFonts.poppins(color: Colors.white),),
                                  SizedBox(height:height/151.2),

                                  Container(
                                    height:height/15.12,
                                    width:width/1.8,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: Colors.white38
                                    ),
                                    child: TextField(
                                      controller: type,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize:width/30,
                                          color: Colors.black
                                      ),
                                      cursorColor: Colors.indigo,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(left:width/18),
                                          hintText: "Enter the product Type",
                                          hintStyle: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize:width/30,
                                              color: Colors.black
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
                                showdialog(docid);
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

              ],
            ),
          ),),
        );
    },);

  }


  showdialog(id){
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

                SizedBox(height:  height/50.4,),

                InkWell(
                  onTap: (){
                    Create(id);
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
