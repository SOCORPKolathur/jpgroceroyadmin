
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpgroceroyadmin/const_PAge.dart';

class User_chatperson_Page extends StatefulWidget {
String?docid;
String?name;
User_chatperson_Page(this.docid,this.name);

  @override
  State<User_chatperson_Page> createState() => _User_chatperson_PageState();
}

class _User_chatperson_PageState extends State<User_chatperson_Page> {


  TextEditingController chatMessage=TextEditingController();
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {

    final double height=MediaQuery.of(context).size.height;
    final double width=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Primarycolor,
        title: Text(
          widget.name.toString(),style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w700
        ),),
      ),
      body:  Container(
        child:
        StreamBuilder<QuerySnapshot>(
          stream:FirebaseFirestore.instance.collection("Users").doc(widget.docid).
          collection("Chats").orderBy("timestamp",descending: false).snapshots(),
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
            return  Container(

              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(vertical:height/37.95 ,
                  horizontal:width/19.6 ),
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: SingleChildScrollView(
                      reverse: true,
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          scrollDirection: Axis.vertical,
                          controller: _scrollController,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context,index) {

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
                                      child:snapshot.data!.docs[index]["From"]=="Admin"?
                                      Align(
                                        alignment:  Alignment.topRight,
                                        child: Container(
                                          child: Text(snapshot.data!.docs[index]["Message"].toString(),
                                            style:TextStyle(color: Colors.white,
                                              fontSize:width/24.5,),),
                                          decoration: BoxDecoration(
                                              color: Primarycolor,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(12),
                                                  topRight: Radius.circular(15),
                                                  topLeft: Radius.circular(15)
                                              )
                                          ),
                                          padding: EdgeInsets.only(
                                              top: height/75.9,
                                              bottom: height/75.9,
                                              left: width/39.2,
                                              right: width/39.2
                                          ),
                                        ),
                                      ):
                                      Align(
                                        alignment:  Alignment.topLeft,
                                        child: GestureDetector(
                                          child: Container(
                                            child: Column(
                                              children: [
                                                Text(snapshot.data!.docs[index]["Message"].toString(),
                                                  style:TextStyle(color: Colors.white,
                                                    fontSize:width/24.5, ),),
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                                color: Primarycolor,
                                                borderRadius: BorderRadius.only(
                                                    bottomRight: Radius.circular(12),
                                                    topRight: Radius.circular(15),
                                                    topLeft: Radius.circular(15)
                                                )
                                            ),
                                            padding: EdgeInsets.only(
                                                top: height/75.9,
                                                bottom: height/75.9,
                                                left: width/39.2,
                                                right: width/39.2
                                            ),
                                          ),
                                          onTap: (){

                                          },
                                        ),
                                      )
                                  ),
                                ),
                              ],
                            );
                          }
                      ),
                    ),
                  ),
                  SizedBox(height: height/15.18,)
                ],
              ),
            );

          },),
      ),
        bottomSheet: BottomAppBar(
          elevation: 0,
          child: Container(
            margin: EdgeInsets.only(left: width/72,right: width/72,bottom: height/75.6),
            decoration: BoxDecoration(
                color:Primarycolor,
                borderRadius: BorderRadius.circular(7)
            ),
            padding: EdgeInsets.only(
              left: width/19.6,
              right: width/19.6,),
            child: TextField(
              style: GoogleFonts.poppins(
                  color: Colors.white
              ),
              controller: chatMessage,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter your message here!",
                hintStyle: GoogleFonts.poppins(
                    color: Colors.white
                ),
                suffixIcon:  IconButton(
                    icon: Icon(Icons.send,color: Colors.white,),
                    onPressed: () {
                      print("i'm work");
                      chatfuntion();
                      clearall();

                    }),
              ),
            ),
          ),
        ),
    );
  }

  //craete a chat function
  chatfuntion() {
    FirebaseFirestore.instance.collection("Users").doc(widget.docid).collection("Chats").doc().set({
      "Message": chatMessage.text,
      "time": '${DateTime.now().hour}:${DateTime.now().minute}',
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "From": "Admin",
    });
  }

  clearall(){
    chatMessage.clear();
  }


}
