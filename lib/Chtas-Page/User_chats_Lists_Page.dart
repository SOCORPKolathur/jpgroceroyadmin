import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpgroceroyadmin/Chtas-Page/User_chatPerson_Page.dart';
import 'package:jpgroceroyadmin/const_PAge.dart';
import 'package:lottie/lottie.dart';

class User_chat_List_Page extends StatefulWidget {
   User_chat_List_Page(this.type);
   String?type;

  @override
  State<User_chat_List_Page> createState() => _User_chat_List_PageState();
}

class _User_chat_List_PageState extends State<User_chat_List_Page> {

  TextEditingController message=TextEditingController();

  @override
  Widget build(BuildContext context) {

    final double height=MediaQuery.of(context).size.height;
    final double width=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Primarycolor,
        title: Text("User Chat Page",style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w700
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
                padding:
                EdgeInsets.only(
                    top:height/94.5,
                    bottom: height/94.5,
                    left: width/180,
                    right:  width/180),
                child: Container(
                  decoration: BoxDecoration(
                      color: Primarycolor,
                    borderRadius: BorderRadius.circular(5)
                  ),

                  child: ListTile(
                    onTap: (){
                      ischatfuntion(user.id);
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>User_chatperson_Page(user.id,user['name']) ,));
                    },
                    leading: Icon(Icons.person,size: width/9,),
                    title:Text(user['name'],style: GoogleFonts.poppins(color: Colors.white),),
                    trailing:
                    user['ischat']==true?
                    Icon(Icons.circle,size: width/36.0,color: Colors.white,):SizedBox(),
                    subtitle: Text(user['lastchat'],style: GoogleFonts.poppins(color: Colors.white),),
                  ),
                ),
              );
            },);

        },
      ):
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("Users").where("type",isEqualTo: widget.type).snapshots(),
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
                        padding:
                        EdgeInsets.only(
                            top:height/94.5,
                            bottom: height/94.5,
                            left: width/180,
                            right:  width/180),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Primarycolor,
                              borderRadius: BorderRadius.circular(5)
                          ),

                          child: ListTile(
                            onTap: (){
                              ischatfuntion(user.id);
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>User_chatperson_Page(user.id,user['name']) ,));
                            },
                            leading: Icon(Icons.person,size: width/9,),
                            title:Text(user['name'],style: GoogleFonts.poppins(color: Colors.white),),
                            trailing:
                            user['ischat']==true?
                            Icon(Icons.circle,size: width/36.0,color: Colors.white,):SizedBox(),
                            subtitle: Text(user['lastchat'],style: GoogleFonts.poppins(color: Colors.white),),
                          ),
                        ),
                      );
                  },);

            },
          )
      ,

    );
  }

  ischatfuntion(id){

    FirebaseFirestore.instance.collection("Users").doc(id).update(
        {
          'ischat':false,
        }
    );

  }





}
