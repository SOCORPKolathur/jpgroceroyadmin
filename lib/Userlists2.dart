import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpgroceroyadmin/Users%20Lists/UserLists.dart';

class Userlist2 extends StatefulWidget {
  const Userlist2({Key? key}) : super(key: key);

  @override
  State<Userlist2> createState() => _Userlist2State();
}

class _Userlist2State extends State<Userlist2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserLists("Individual"),));
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserLists("Shop"),));

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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserLists("SuperMarket"),));
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserLists("School"),));
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserLists("others"),));
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserLists("All"),));
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
