import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpgroceroyadmin/app/modules/home/controllers/home_controller.dart';
import 'package:jpgroceroyadmin/const.dart';
import 'package:jpgroceroyadmin/const_PAge.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:random_string/random_string.dart';

class userorderviewlist_page extends StatefulWidget {
   userorderviewlist_page(this.docid,this.usercid,this.name,this.phone,this.adress,this.lang,this.long);
   String?docid;
   String?usercid;
   String?name;
   String?phone;
   String?adress;
   double?lang;
   double?long;

  @override
  State<userorderviewlist_page> createState() => _userorderviewlist_pageState();
}

class _userorderviewlist_pageState extends State<userorderviewlist_page> {
  @override
  Widget build(BuildContext context) {

    final double height=MediaQuery.of(context).size.height;
    final double width=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Primarycolor,
        title: Text(
          "Orders View Page",style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w700
        ),),
      ),
      body:  StreamBuilder<QuerySnapshot>(
        stream:FirebaseFirestore.instance.collection("Orders").doc(widget.docid).collection(widget.docid.toString()).orderBy("timestamp",descending: false).snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData)
          {
            return Center(
                child: CircularProgressIndicator()
            );
          }
          if(snapshot.hasData==null)
          {
            return Center(
                child:
                CircularProgressIndicator()
            );
          }
          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(

              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context,index) {
                          var order=snapshot.data!.docs[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: height/151.8,),
                              Padding(
                                padding:  EdgeInsets.only(
                                  top: height/82.125,
                                  bottom:height/82.125,
                                ),
                                child: Container(
                                  decoration:BoxDecoration(
                                      color:Primarycolor.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                    ListTile(
                                      leading:Container(
                                          height:70,
                                          width:70,
                                          child:
                                      order["url"]==""?
                                          Image.network(image,fit: BoxFit.cover,)
                                          :
                                          Image.network(order["url"])),
                                      title: Column(
                                        children: [
                                          //orderid
                                          Row(
                                            children: [
                                              Container(
                                                width:90,
                                                child: Text("Product id",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                  width:120,
                                                  height:20,
                                                  child: Text(":  ${order["productid"]}",
                                                    )),
                                            ],
                                          ),

                                          //name
                                          Row(
                                            children: [
                                              Container(
                                                width:90,
                                                child: Text("Name",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                width:120,
                                                child: Text(":  ${order["name"]}",
                                                    style: TextStyle(
                                                        overflow: TextOverflow.ellipsis
                                                    )),
                                              ),
                                            ],
                                          ),

                                          //org price
                                          Row(
                                            children: [
                                              Container(
                                                width:90,
                                                child: Text("Org Price",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                  width:120,
                                                  child: Text(":  ${order["orgprice"]}",style: TextStyle(
                                                      overflow: TextOverflow.ellipsis
                                                  ))),
                                            ],
                                          ),

                                          //date
                                          Row(
                                            children: [
                                              Container(
                                                width:90,
                                                child: Text("Date",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                width: 120,
                                                child: Text(":  ${order["date"]}",style: TextStyle(
                                                    overflow: TextOverflow.ellipsis
                                                )),
                                              ),
                                            ],
                                          ),

                                          //time

                                          Row(
                                            children: [
                                              Container(
                                                width:90,
                                                child: Text("Time",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                width: 120,
                                                child: Text(":  ${order["time"].toString()}",style: TextStyle(
                                                    overflow: TextOverflow.ellipsis
                                                )),
                                              ),

                                            ],
                                          ),

                                          Row(
                                            children: [
                                              Container(
                                                width:90,
                                                child: Text("Quvantity",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                width: 120,
                                                child: Text(":  ${order["quantity"].toString()}",style: TextStyle(
                                                    overflow: TextOverflow.ellipsis
                                                )),
                                              ),

                                            ],
                                          ),

                                          //total
                                          Row(
                                            children: [
                                              Container(
                                                width:90,
                                                child: Text("Price",
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                              ),
                                              Container(
                                                  width: 120,
                                                  child: Text(":  ${order["price"].toString()}",style: TextStyle(
                                                      overflow: TextOverflow.ellipsis
                                                  ))),


                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                    ),
                  ),
                  SizedBox(height: height/15.18,)
                ],
              ),
            ),
          );

        },),
      floatingActionButton: GestureDetector(
        onTap: (){
          chatfuntion();
          showdialog();

        },
        child: Material(
          borderRadius: BorderRadius.circular(5),
          elevation: 2,
          child: Container(
              width: 120,
              height:40,
              decoration: BoxDecoration(color: Primarycolor,
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Center(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(Icons.message,color: Colors.white,),
                    ),
                    Text("Send OTP",style:
                    GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                    )),
                  ],
                ),
              )),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  showalert();
                },
                child: Container(
                  height: 40,
                  width: 160,
                  color: Primarycolor,
                  child: Center(child: Text("Delivered",style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1
                  ),)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  launch("https://wa.me/918939107382?text=Orderid:${widget.docid},Name:${widget.name},Phone:${widget.phone},Address:${widget.adress},Loaction: https://maps.google.com/?q=${widget.lang.toString()},${widget.long.toString()},%20");
                },
                child: Container(
                  height: 40,
                  width: 160,
                  color: Primarycolor,
                  child: Center(child: Text("Share Location",style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1
                  ),)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  update(){
    FirebaseFirestore.instance.collection("Orders").doc(widget.docid).update({
      "status":"Delivered"
    });

    FirebaseFirestore.instance.collection("Users").doc(widget.usercid).collection("Orders").doc(widget.docid).update({
      "status":"Delivered"
    });

  }



  showalert(){
    return showDialog(context: context, builder:
    (context) {

      return
        Padding(
          padding: const EdgeInsets.only(top: 108.0,bottom: 108),
          child: AlertDialog(
            content: Container(
              height: 300,
              width: 300,
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Text("Are your sure Delivered the items",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: 16),),
                  SizedBox(height: 20,),


                  Container(
                    height: 160,
                  width: 160,
                  child: Lottie.network("https://assets9.lottiefiles.com/packages/lf20_fbwbq3um.json"),
                  ),
                  GestureDetector(
                    onTap: (){
                      update();

                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 35,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius:  BorderRadius.circular(5),
                        color: Primarycolor,
                      ),
                      child: Center(
                        child:  Text("Okay",
                          style: GoogleFonts.poppins(fontWeight: FontWeight.normal,fontSize: 15,color: Colors.white),),
                      ),
                    ),
                  )
                ],

              ),
            ),
          ),
        );
    },);
  }
  String OTPgen="";
  final homecontroller = Get.put(HomeController());
  chatfuntion() {
    setState(() {
      OTPgen =randomNumeric(4).toString();
      homecontroller.title.text="Your OTP for Order ID: ${widget.docid} is";
      homecontroller.body.text="${OTPgen}";
    });

    homecontroller.findusers();

    FirebaseFirestore.instance.collection("Users").doc(widget.usercid).collection("Chats").doc().set({
      "Message": "Your OTP for Order ID: ${widget.docid} is \n ${OTPgen}",
      "time": '${DateTime.now().hour}:${DateTime.now().minute}',
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "From": "Admin",
    });
  }
  showdialog(){
    final double height=MediaQuery.of(context).size.height;
    final double width=MediaQuery.of(context).size.width;

    return showDialog(context: context, builder: (context) {
      return
        AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            height: height/2.6,
            width: width/1.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Color(0xff263646),
            ),
            child: Column(
              children: [
                SizedBox(height:height/25.2,),
                Text("Enter the OTP",style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: width/24
                ),),
                SizedBox(height: height/50.4,),
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
                              controller: otp,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: width/18),
                                  hintText: "Enter the OTP",
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

                SizedBox(height:  height/50.4,),

                InkWell(
                  onTap: (){
                    if(OTPgen==otp.text){
                      Navigator.pop(context);
                     return showalert();
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invalid OTP')));
                    }

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
                        "Check",style: GoogleFonts.poppins(color: Colors.black,
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
  TextEditingController otp=TextEditingController();


}
