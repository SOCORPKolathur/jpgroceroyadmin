import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpgroceroyadmin/Chtas-Page/User_chats_Lists_Page.dart';

class Userchatlist extends StatefulWidget {
  const Userchatlist({Key? key}) : super(key: key);

  @override
  State<Userchatlist> createState() => _UserchatlistState();
}

class _UserchatlistState extends State<Userchatlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => User_chat_List_Page("Individual"),));
                },
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.indigo.shade200
                  ),
                  child: Center(child: Text("Individual",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.black),)),
                ),
              ),

              SizedBox(width: 20,),

              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => User_chat_List_Page("Shop"),));

                },
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.indigo.shade200
                  ),
                  child: Center(child: Text("Shop",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.black),)),
                ),
              )
            ],
          ),

          SizedBox(height: 20,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => User_chat_List_Page("SuperMarket"),));
                },
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.indigo.shade200
                  ),
                  child: Center(child: Text("SuperMarket",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.black),)),
                ),
              ),

              SizedBox(width: 20,),

              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => User_chat_List_Page("School"),));
                },
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.indigo.shade200
                  ),
                  child: Center(child: Text("School",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.black),)),
                ),
              )
            ],
          ),

          SizedBox(height: 20,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => User_chat_List_Page("others"),));
                },
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.indigo.shade200
                  ),
                  child: Center(child: Text("others",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.black),)),
                ),
              ),

              SizedBox(width: 20,),

              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => User_chat_List_Page("All"),));
                },
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.indigo.shade200
                  ),
                  child: Center(child: Text("All",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.black),)),
                ),
              )
            ],
          ),

        ],
      ),
    );
  }
}
