import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpgroceroyadmin/Users_orders_lists.dart';

class OrderPage2 extends StatefulWidget {
  const OrderPage2({Key? key}) : super(key: key);

  @override
  State<OrderPage2> createState() => _OrderPage2State();
}

class _OrderPage2State extends State<OrderPage2> {
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Userorderlists("Individual"),));
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Userorderlists("Shop"),));

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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Userorderlists("SuperMarket"),));
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Userorderlists("School"),));
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Userorderlists("others"),));
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Userorderlists("All"),));
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
