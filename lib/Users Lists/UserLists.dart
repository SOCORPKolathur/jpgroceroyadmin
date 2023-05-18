import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpgroceroyadmin/const_PAge.dart';
import 'package:url_launcher/url_launcher.dart';

class UserLists extends StatefulWidget {
  String?type;
  UserLists(this.type);

  @override
  State<UserLists> createState() => _UserListsState();
}

class _UserListsState extends State<UserLists> {
  @override
  Widget build(BuildContext context) {

    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Primarycolor,
        title: Text("User Lists",style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w700,
        ),),
      ),
      body:
      widget.type=="All"?
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot){

          if(snapshot.hasData==null){

            return Center(
                child: Container(
                    child: CircularProgressIndicator()
                ));
          }

          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),);
          }

          return
            ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var user=snapshot.data!.docs[index];
                return
                  Padding(
                    padding:  EdgeInsets.only(
                        top:height/94.5,
                        bottom: height/94.5,
                        left: width/180,
                        right: width/180),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Primarycolor,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: ListTile(
                        trailing: Icon(Icons.call),
                        onTap: (){
                          launch("tel:‎+91 ${user['phone']}");
                        },
                        leading: Icon(Icons.person,size: width/9,),
                        title:Text(user['name'],style: GoogleFonts.poppins(
                            color: Colors.white),),
                        subtitle: Text("+91 ${user['phone']}",style:
                        GoogleFonts.poppins(color: Colors.white),),
                      ),
                    ),
                  );
              },);

        },
      ):StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Users").where("type",isEqualTo:widget.type).snapshots(),
        builder: (context, snapshot){

          if(snapshot.hasData==null){

            return Center(
                child: Container(
                    child: CircularProgressIndicator()
                ));
          }

          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),);
          }

          return
            ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var user=snapshot.data!.docs[index];
                return
                  Padding(
                    padding:  EdgeInsets.only(
                        top:height/94.5,
                        bottom: height/94.5,
                        left: width/180,
                        right: width/180),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Primarycolor,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: ListTile(
                        trailing: Icon(Icons.call),
                        onTap: (){
                          launch("tel:‎+91 ${user['phone']}");
                        },
                        leading: Icon(Icons.person,size: width/9,),
                        title:Text(user['name'],style: GoogleFonts.poppins(
                            color: Colors.white),),
                        subtitle: Text("+91 ${user['phone']}",style:
                        GoogleFonts.poppins(color: Colors.white),),
                      ),
                    ),
                  );
              },);

        },
      ),
    );
  }
}
