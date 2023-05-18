import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpgroceroyadmin/NotificationGridpage.dart';
import 'package:jpgroceroyadmin/const_PAge.dart';
import 'package:jpgroceroyadmin/updates%20Notification_Page.dart';

class Notificatiomainpage extends StatefulWidget {
  const Notificatiomainpage({Key? key}) : super(key: key);

  @override
  State<Notificatiomainpage> createState() => _NotificatiomainpageState();
}

class _NotificatiomainpageState extends State<Notificatiomainpage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50,),

          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateNotification_Page(),));
            },
            child: Container(
              height: 50,
              width: 250,
              decoration:BoxDecoration(
                color: Primarycolor,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Center(
                child: Text("General Notification",style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  color: Colors.white
                ),),
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(
                horizontal: width/36.0,
                vertical: height/75.6
            ),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Categories")
                  .orderBy("name",descending: false).snapshots(),
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
                    ) ,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index){
                      var value=snapshot.data!.docs[index];
                      return
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationGridpage(value.id,value['name']),));
                          },
                          child: Container(
                              width: width/3.272,
                              height: height/6.872,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Primarycolor.withOpacity(0.6)
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

                                  Text(value['name'],style:
                                  GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: width/30,
                                      fontWeight: FontWeight.w700),),
                                  SizedBox(height: 5,),

                                ],
                              )
                          ),
                        );

                    });
              },),
          ),
        ],
      ),
    );
  }
}
