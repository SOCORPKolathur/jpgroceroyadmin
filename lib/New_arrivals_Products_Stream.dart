
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jpgroceroyadmin/New_arrivals_products.dart';
import 'package:jpgroceroyadmin/const_PAge.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';

class NewAriivalStream extends StatefulWidget {
  const NewAriivalStream({Key? key}) : super(key: key);

  @override
  State<NewAriivalStream> createState() => _NewAriivalStreamState();
}

class _NewAriivalStreamState extends State<NewAriivalStream> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Arrivals Item Lists"),
        backgroundColor: Primarycolor,
        centerTitle: true,
      ),
      body: Column(
        children: [
        SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              GestureDetector(

                onTap: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context) =>Arrival_Products() ,));

                },
                child: Container(
                  height: 30,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Primarycolor,
                    borderRadius: BorderRadius.circular(7)
                  ),
                  child: Center(child: Text("Add Product",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.white),)),
                ),
              ),
              SizedBox(width: 15,)

            ],
          ),
          SizedBox(height: 15,),

          Container(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("New Arrivals").snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasData==null){
                  return Center(child: CircularProgressIndicator(),);
                }
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator(),);
                }
                return ListView.builder(
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
                                    onTap: ()=>deleteshowpop(newaarivals.id),
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
              },
            ),
          ),
        ],
      ),
    );

  }


  deteletenewaarivals(docid){

    FirebaseFirestore.instance.collection("New Arrivals").doc(docid).delete();

  }


  //delete popup
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


//edit popup

  TextEditingController productname=TextEditingController();
  TextEditingController productsubname=TextEditingController();
  TextEditingController productprice=TextEditingController();
  TextEditingController productorgprice=TextEditingController();
  TextEditingController productdescription=TextEditingController();
  TextEditingController productQuvantity=TextEditingController();
  TextEditingController productminQuvantity=TextEditingController();
  String imges="";

  editshowpop(docid)async{
    setvalue(docid);
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;

      showDialog(context: context, builder:
        (context) {

      return
        Scaffold(
          body:  Container(
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

              SizedBox(height: 20,),
              Column(
                children: [

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
                                    Image.network(imges)
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            Padding(
                              padding: const EdgeInsets.only(left: 9.0),
                              child: Text("Product Name",style: GoogleFonts.poppins(color: Colors.white),),
                            ),
                            SizedBox(height: height/75.6),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: width/36.0,),
                                Container(
                                  height: height/15.12,
                                  width: width/2.3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: Colors.white38
                                  ),
                                  child: TextField(
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: width/30,
                                        color: Colors.black
                                    ),
                                    cursorColor: Colors.indigo,
                                    controller: productname,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(left: width/18),
                                        hintText: "Enter the product name",
                                        hintStyle: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: width/30,
                                            color: Colors.black
                                        )
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 15,),

                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Product Tittle-1
                            Text("Product Subname",style: GoogleFonts.poppins(color: Colors.white),),
                            SizedBox(height: height/75.6),

                            Container(
                              height: height/15.12,
                              width: width/2.3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.white38
                              ),
                              child: TextField(
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: width/30,
                                    color: Colors.black
                                ),
                                cursorColor: Colors.indigo,
                                controller: productsubname,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: width/18),
                                    hintText: "Enter the product Subname",
                                    hintStyle: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: width/30,
                                        color: Colors.black
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                      )

                    ],
                  ),

                  SizedBox(height: height/75.6),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10,),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Product Price",style: GoogleFonts.poppins(color: Colors.white),),
                            SizedBox(height: height/75.6),

                            Container(
                              height: height/15.12,
                              width: width/2.3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.white38
                              ),
                              child: TextField(
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: width/30,
                                    color: Colors.black
                                ),
                                cursorColor: Colors.indigo,
                                controller: productprice,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: width/18),
                                    hintText: "Enter the product Price",
                                    hintStyle: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: width/30,
                                        color: Colors.black
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 15,),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Product OrgPrice",style: GoogleFonts.poppins(color: Colors.white),),
                            SizedBox(height: height/75.6),

                            Container(
                              height: height/15.12,
                              width: width/2.3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.white38
                              ),
                              child: TextField(
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: width/30,
                                    color: Colors.black
                                ),
                                cursorColor: Colors.indigo,
                                controller: productorgprice,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: width/18),
                                    hintText: "Enter the product OrgPrice",
                                    hintStyle: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: width/30,
                                        color: Colors.black
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                      )

                    ],
                  ),

                  SizedBox(height: height/75.6),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10,),

                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Product Quvantity",style: GoogleFonts.poppins(color: Colors.white),),
                            SizedBox(height: height/75.6),

                            Container(
                              height: height/15.12,
                              width: width/2.3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.white38
                              ),
                              child: TextField(
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: width/30,
                                    color: Colors.black
                                ),
                                cursorColor: Colors.indigo,
                                controller: productQuvantity,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: width/18),
                                    hintText: "Enter the product Quvantity",
                                    hintStyle: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: width/30,
                                        color: Colors.black
                                    )
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(width: 15,),

                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Minimum Quantity",style: GoogleFonts.poppins(color: Colors.white),),
                            SizedBox(height: height/75.6),

                            Container(
                              height: height/15.12,
                              width: width/2.3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.white38
                              ),
                              child: TextField(
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: width/30,
                                    color: Colors.black
                                ),
                                cursorColor: Colors.indigo,
                                controller: productminQuvantity,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: width/18),
                                    hintText: "Enter the product minimum quantity",
                                    hintStyle: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: width/30,
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


                  SizedBox(height: height/75.6),

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
                              color: Colors.black
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
                          showdialog(docid);
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
              )

            ],
          ),
        ),);
    },);

  }

  setvalue(docid)async{
    var docs=await FirebaseFirestore.instance.collection("New Arrivals").doc(docid).get();
    Map<String,dynamic>?value=docs.data();
    setState(() {
      productname.text=value!["name"];
      productsubname.text=value["name2"];
      productprice.text=value["price"].toString();
      productorgprice.text=value["orgprice"].toString();
      productdescription.text=value["des"].toString();
      productQuvantity.text=value["quvantity"].toString();
      productminQuvantity.text=value["minimum_quvantity"].toString();
      imges=value["img"];

    });

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

  showdialog(docid){
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
                Text("Add Product Edit Successfully",style: GoogleFonts.poppins(
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

                    submitthedate(docid);
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

  submitthedate(docid){
    FirebaseFirestore.instance.collection("New Arrivals").doc(docid).update({
      "des":productdescription.text,
      "img":imgUrl,
      "name":productname.text,
      'name2':productsubname.text,
      'price':int.parse(productprice.text),
      'orgprice':int.parse(productorgprice.text),
      "quantity":int.parse(productQuvantity.text),
      "minimum_quvantity":int.parse(productminQuvantity.text)
    });

  }

}
