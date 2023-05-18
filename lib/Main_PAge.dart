
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpgroceroyadmin/Categories_Lists_Page.dart';
import 'package:jpgroceroyadmin/Chtas-Page/User_chats_Lists_Page.dart';
import 'package:jpgroceroyadmin/New_arrivals_Products_Stream.dart';
import 'package:jpgroceroyadmin/New_arrivals_products.dart';
import 'package:jpgroceroyadmin/Notification_Main_PAge.dart';
import 'package:jpgroceroyadmin/OrdersPage2.dart';
import 'package:jpgroceroyadmin/Userlists2.dart';
import 'package:jpgroceroyadmin/Users%20Lists/UserLists.dart';
import 'package:jpgroceroyadmin/Users_chatlist2.dart';
import 'package:jpgroceroyadmin/Users_orders_lists.dart';
import 'package:jpgroceroyadmin/const-Page.dart';
import 'package:jpgroceroyadmin/const_PAge.dart';
import 'package:jpgroceroyadmin/updates%20Notification_Page.dart';



class Main_PAge extends StatefulWidget {
  const Main_PAge({Key? key}) : super(key: key);

  @override
  State<Main_PAge> createState() => _Main_PAgeState();
}

class _Main_PAgeState extends State<Main_PAge> {
  @override
  Widget build(BuildContext context) {

    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor:Color(0xffD4EBC6),
      body:
      SingleChildScrollView(
        child: Container(
          color: Colors.black12,
          child: Stack(
            children: [
              Padding(
                padding:  EdgeInsets.only(top: height/15.12),
                child: Container(
                  child: Image.network(logo,
                  fit: BoxFit.contain,
                    height: height/3.78,
                    width: width/0.9,
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(height: height/2.606,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: width/24,),
                        Text("Welcome Back \n Jp Stores",

                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize:width/18,
                          color: Colors.black
                        ),),
                      ],
                    ),

                    SizedBox(height: height/75.6,),
                    Text("(Add a Products Page)",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        fontSize:width/36.0,
                        color: Colors.black
                    ),),
                    SizedBox(height: height/37.8,),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //add arrivals and categeries
                            Row(

                              children: [
                                SizedBox(width: width/27.692,),

                                //add product container
                                GestureDetector(
                                  onTap:(){

                                    Navigator.push(context, MaterialPageRoute(builder:  (context) => NewAriivalStream(),));

                                  },
                                  child: Container(
                                    height: height/5.9,
                                    width: width/3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                    child:  Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Center(
                                        child: Padding(
                                          padding:  EdgeInsets.symmetric(
                                            horizontal: width/27.692,
                                            vertical: height/58.153
                                          ),
                                          child: Column(
                                            children: [
                                              Icon(Icons.production_quantity_limits_sharp),
                                              SizedBox(height: 5,),
                                              Text("Add New Arrivals Products",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                ),
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black, fontSize: width/25.0
                                              ),),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: width/18,),

                                //add category container
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => CAtegories_list_PAge(),));
                                  },
                                  child: Container(
                                    height: height/5.9,
                                    width: width/3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                    child:  Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Center(
                                        child: Padding(
                                          padding:  EdgeInsets.symmetric(
                                            horizontal: width/27.692,
                                            vertical: height/58.153
                                          ),
                                          child: Column(
                                            children: [

                                              Icon(Icons.production_quantity_limits_sharp),
                                              SizedBox(height: 5,),
                                              Text("Add Categories Products",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black, fontSize: width/25.0
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
                            SizedBox(height: height/50.4,),


                            //Chats and chats Lists
                            Row(
                              children: [
                                SizedBox(width: width/27.692,),


                                //userlistss
                                GestureDetector(
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Userlist2(),));

                                  },
                                  child: Container(
                                    height: height/7.56,
                                    width: width/3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                    child:  Center(
                                      child: Padding(
                                        padding:  EdgeInsets.symmetric(
                                          horizontal: width/27.692,
                                          vertical: height/58.153
                                        ),
                                        child: Column(
                                          children: [
                                            Icon(Icons.person),
                                            SizedBox(height:15),

                                            Text("Users Lists",style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black, fontSize: width/25.0
                                            ),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: width/18,),

                                //userchats list
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Userchatlist(),));
                                  },
                                  child: Container(
                                    height: height/7.56,
                                    width: width/3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                    child:  Center(
                                      child: Padding(
                                        padding:  EdgeInsets.symmetric(
                                          horizontal: width/27.692,
                                          vertical: height/58.153
                                        ),
                                        child: Column(
                                          children: [
                                            Icon(Icons.message),
                                            SizedBox(height:15),

                                            Text("User Chats",style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                              fontSize: width/25.0
                                            ),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),



                              ],
                            ),
                            SizedBox(height: height/50.4,),

                            Row(
                              children: [
                                SizedBox(width: width/27.692,),

                                //orders button
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder:
                                        (context) => OrderPage2(),));
                                  },
                                  child: Container(
                                    height: height/8.45,
                                    width: width/3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                    child:  Center(
                                      child: Padding(
                                        padding:  EdgeInsets.symmetric(
                                          horizontal: width/27.692,
                                          vertical: height/58.153
                                        ),
                                        child: Column(
                                          children: [

                                            Icon(Icons.shopping_cart_outlined),
                                            SizedBox(height: 15,),
                                            Text("Orders",style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                              fontSize: width/25
                                            ),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: width/18,),



                                //notofication button
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder:
                                        (context) => Notificatiomainpage(),));

                                  },
                                  child: Container(
                                    height: height/8.45,
                                    width: width/3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                    child:  Center(
                                      child: Padding(
                                        padding:  EdgeInsets.symmetric(
                                          horizontal: width/27.692,
                                          vertical: height/58.153
                                        ),
                                        child: Column(
                                          children: [
                                            Icon(Icons.notifications),
                                            SizedBox(height: 15,),
                                            Text("Notification",style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                              fontSize: width/25
                                            ),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),


                              ],
                            ),
                            SizedBox(height: height/50.4,),

                          ],
                        ),
                      ),
                    ],
                  )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
