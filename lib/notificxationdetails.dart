
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class NotificationDetails extends StatefulWidget {
  String id;
  NotificationDetails(this.id);

  @override
  State<NotificationDetails> createState() => _NotificationDetailsState();
}

class _NotificationDetailsState extends State<NotificationDetails> {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(

      body:
      StreamBuilder<QuerySnapshot>(
        stream:FirebaseFirestore.instance.collection("Categories").doc(widget.id).collection("Updates").orderBy("timestamp").snapshots() ,
        builder:(context, snapshot) {
          if(!snapshot.hasData)
          {
            return Center(
                child: CircularProgressIndicator()
            );
          }


          if(snapshot.hasData==null)
          {
            return Center(
                child: CircularProgressIndicator()
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, int index) {
              return Container(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        new  Container(
                          padding: EdgeInsets.symmetric(
                              vertical: height/75.9,
                              horizontal: width/39.2
                          ),
                          margin: EdgeInsets.symmetric( vertical: height/75.9,
                              horizontal: width/39.2),
                          child:
                          ListTile(
                            trailing:GestureDetector(
                                onTap: (){
                                  showdialog(snapshot.data!.docs[index].id);
                                },
                                child: Tooltip(
                                    message: "Delete",
                                    child: Icon(Icons.delete))),
                            title: Text(snapshot.data!.docs[index]["updatestitle"].toString(),style: GoogleFonts.poppins(color: Colors.black),),
                            subtitle: Text(snapshot.data!.docs[index]["update_top_title"].toString(),style: GoogleFonts.poppins(color: Colors.black,
                                fontSize: 12)),
                            leading: Container(
                                height: height/12.6,
                                width: width/6,
                                child: Image.network(snapshot.data!.docs[index]["update_image"])),
                            onTap: (){

                            },
                          ),
                        ),

                      ],
                    ),
                    Divider(),
                  ],
                ),
              );
            },
          );
        },
      ) ,
    );
  }
  dailyupdat(docid) async {
    FirebaseFirestore.instance.collection("Categories").doc(widget.id).collection("Updates").doc(docid).delete();

  }


  showdialog(docid){
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
                Text("Are you sure want to Delete",style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: width/24
                ),),
                SizedBox(height: height/50.4,),
                Container(
                  height: height/5.04,
                  width: width/2.4,
                  child: Lottie.network("https://assets6.lottiefiles.com/packages/lf20_nux6g0kx.json"),
                ),

                SizedBox(height:  height/50.4,),

                InkWell(
                  onTap: (){
                    dailyupdat(docid);
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
}
