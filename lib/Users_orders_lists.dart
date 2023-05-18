import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpgroceroyadmin/Userorderviewlist_Page.dart';
import 'package:jpgroceroyadmin/const_PAge.dart';
import 'package:lottie/lottie.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

class Userorderlists extends StatefulWidget {
   Userorderlists(this.type);
   String?type;

  @override
  State<Userorderlists> createState() => _UserorderlistsState();
}

class _UserorderlistsState extends State<Userorderlists> {
  int? _currentSelection = 0;
  final Map<int, Widget> _children = {
    0: Padding(child: Text('Orders'),padding: EdgeInsets.only(top: 5,bottom: 5,right: 35,left: 35),),
    1: Text('Delivered'),
    2: Text('Canceled'),
  };
  List<int> _disabledIndices = [];
  TextEditingController pos1=new TextEditingController();
  TextEditingController pos2=new TextEditingController();
  final DateFormat formatter = DateFormat('dd / M / yyyy');
  int year1 =0;
  int day1= 0;
  int month1=0;
  int year2=0;
  int day2=0;
  int month2=0;
  List<String> mydate =[];
  @override
  Widget build(BuildContext context) {

    final double height=MediaQuery.of(context).size.height;
    final double width=MediaQuery.of(context).size.width;
    ScrollController _scrollController = new ScrollController();
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Primarycolor,
        title: Text(
          "${widget.type} Orders",style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w700
        ),),
      ),


      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15,),
            MaterialSegmentedControl(
              children: _children,
              horizontalPadding: EdgeInsets.symmetric(horizontal: 5.0),

              selectionIndex: _currentSelection,
              borderColor: Colors.grey,
              selectedColor: Primarycolor,
              unselectedColor: Colors.white,
              selectedTextStyle: TextStyle(color: Colors.white),
              unselectedTextStyle: TextStyle(color: Primarycolor),
              borderWidth: 0.7,
              borderRadius: 32.0,
              disabledChildren: _disabledIndices,
              verticalOffset: 8.0,
              onSegmentTapped: (index) {
                setState(() {
                  _currentSelection = index;

                });
                print(_currentSelection);
              },
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Start Date'),
                Text('End Date'),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 150,
                  height: height/25.3,
                  child: TextField(
                    style: GoogleFonts.poppins(
                        fontSize: 12
                    ),
                    controller: pos1,
                    decoration: InputDecoration(


                      prefixIcon: Icon(Icons.calendar_today,size: 15,),
                      hintText: 'Date',
                      filled: true,
                      fillColor: Colors.blueGrey.shade50,

                      contentPadding: EdgeInsets.all(5),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey.shade50),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),//editing controller of this TextField

                    readOnly: true,  //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context, initialDate: DateTime.now(),
                          firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime.now()
                      );

                      if(pickedDate != null ){
                        print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate = DateFormat('dd / M / yyyy').format(pickedDate);
                        print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {

                          year1= pickedDate.year;
                          day1= pickedDate.day;
                          month1= pickedDate.month;
                          pos1.text = formattedDate;
                          //set output date to TextField value.
                        });
                      }else{
                        print("Date is not selected");
                      }
                    },
                  ),
                ),
                Padding(
                  padding:EdgeInsets.only(left:width/75.9),
                  child: Container(
                    width: 150,
                    height: height/25.3,
                    child: TextField(
                      style: GoogleFonts.poppins(
                          fontSize: 12
                      ),
                      controller: pos2,
                      decoration: InputDecoration(

                        prefixIcon: Icon(Icons.calendar_today,size: 15,),
                        hintText: 'Date',
                        filled: true,
                        fillColor: Colors.blueGrey.shade50,
                        contentPadding: EdgeInsets.all(5),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey.shade50),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),//editing controller of this TextField

                      readOnly: true,  //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context, initialDate: DateTime.now(),
                            firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101)
                        );

                        if(pickedDate != null ){
                          print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate = DateFormat('dd / M / yyyy').format(pickedDate);
                          print(formattedDate); //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement

                          setState(() {
                            year2= pickedDate.year;
                            day2= pickedDate.day;
                            month2= pickedDate.month;
                            pos2.text = formattedDate;

                            //set output date to TextField value.
                          });
                          print(year2);
                          print(day2);
                          print(month2);
                          DateTime startDate = DateTime.utc(year1, month1, day1);
                          DateTime endDate = DateTime.utc(year2, month2, day2);
                          print(startDate);
                          print(endDate);
                          getDaysInBetween() {
                            final int difference = endDate.difference(startDate).inDays;
                            print(difference);
                            return difference;
                          }
                          final items = List<DateTime>.generate(getDaysInBetween(), (i) {
                            DateTime date = startDate;
                            return date.add(Duration(days: i));
                          });
                          setState(() {
                            mydate.clear();
                          });

                          for(int i =0;i<items.length;i++) {
                            setState(() {
                              mydate.add(formatter.format(items[i]).toString());

                            });


                          }
                          print(mydate);
                        }else{
                          print("Date is not selected");
                        }
                      },
                    ),
                  ),
                )
              ],
            ),




            _currentSelection==0?
            widget.type==
                "All"?
            Container(
              child: StreamBuilder<QuerySnapshot>(
                stream:FirebaseFirestore.instance.collection("Orders").orderBy("timestamp",descending: true).snapshots(),
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
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context,index) {
                          var order=snapshot.data!.docs[index];
                          return mydate.isEmpty?
                            order["status"]=="ordered"?
                            Container(
                              child: Column(
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
                                        child: Column(
                                          children: [
                                            //orderid
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Order id",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                    width:150,

                                                    child: Text(":  ${order["orderid"]}",
                                                      style: TextStyle(
                                                          overflow: TextOverflow.ellipsis
                                                      ),)),
                                              ],
                                            ),

                                            //name
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Name",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                  width:150,
                                                  child: Text(":  ${order["name"]}",
                                                      style: TextStyle(
                                                          overflow: TextOverflow.ellipsis
                                                      )),
                                                ),
                                              ],
                                            ),

                                            //phone
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Phone",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                    width:100,
                                                    child: Text(":  ${order["phone"]}",style: TextStyle(
                                                        overflow: TextOverflow.ellipsis
                                                    ))),
                                              ],
                                            ),

                                            //date
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Date",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                  width: 150,
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
                                                  width:100,
                                                  child: Text("Time",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                  width: 150,
                                                  child: Text(":  ${order["time"].toString()}",style: TextStyle(
                                                      overflow: TextOverflow.ellipsis
                                                  )),
                                                ),

                                              ],
                                            ),

                                            //total
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Total",
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w600
                                                    ),),
                                                ),
                                                Container(
                                                    width: order["status"]!="Canceled"? order["status"]=="Delivered"?70: 100 : 70,
                                                    child: Text(":  ${order["total"].toString()}",style: TextStyle(
                                                        overflow: TextOverflow.ellipsis
                                                    ))),

                                                order["status"]!="Canceled"? order["status"]=="Delivered"?Container(
                                                  width:150,
                                                  height:35,
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Center(child: Text("Delivered",style:
                                                  GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600
                                                  ))),
                                                ): Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: (){

                                                        Navigator.push(context,MaterialPageRoute(builder: (context) =>userorderviewlist_page(order.id,order['Userid'],order['name'].toString(),order['phone'].toString(),order['address'].toString(),order['latitude'],order['longitude']) ,));
                                                      },
                                                      child: Material(
                                                        borderRadius: BorderRadius.circular(5),
                                                        elevation: 2,
                                                        child: Container(
                                                            width: 60,
                                                            height:25,
                                                            decoration: BoxDecoration(color: Primarycolor,
                                                                borderRadius: BorderRadius.circular(5)
                                                            ),
                                                            child: Center(
                                                              child: Text("View",style:
                                                              GoogleFonts.poppins(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.w600
                                                              )),
                                                            )),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 8.0),
                                                      child: GestureDetector(
                                                        onTap: (){
                                                          showdialog(order.id,order['Userid']);
                                                        },
                                                        child: Material(
                                                          borderRadius: BorderRadius.circular(5),
                                                          elevation: 2,
                                                          child: Container(
                                                              width: 120,
                                                              height:25,
                                                              decoration: BoxDecoration(color: Colors.redAccent,
                                                                  borderRadius: BorderRadius.circular(5)
                                                              ),
                                                              child: Center(
                                                                child: Text("Cancel Order",style:
                                                                GoogleFonts.poppins(
                                                                    color: Colors.white,
                                                                    fontWeight: FontWeight.w600
                                                                )),
                                                              )),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ) :
                                                Container(
                                                  width:150,
                                                  height:35,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Center(child: Text("Order Canceled",style:
                                                  GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600
                                                  ))),
                                                )
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ):
                            SizedBox() : mydate.contains(order["date"])?
                          order["status"]=="ordered"?
                          Container(
                            child: Column(
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
                                      child: Column(
                                        children: [
                                          //orderid
                                          Row(
                                            children: [
                                              Container(
                                                width:100,
                                                child: Text("Order id",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                  width:150,

                                                  child: Text(":  ${order["orderid"]}",
                                                    style: TextStyle(
                                                        overflow: TextOverflow.ellipsis
                                                    ),)),
                                            ],
                                          ),

                                          //name
                                          Row(
                                            children: [
                                              Container(
                                                width:100,
                                                child: Text("Name",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                width:150,
                                                child: Text(":  ${order["name"]}",
                                                    style: TextStyle(
                                                        overflow: TextOverflow.ellipsis
                                                    )),
                                              ),
                                            ],
                                          ),

                                          //phone
                                          Row(
                                            children: [
                                              Container(
                                                width:100,
                                                child: Text("Phone",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                  width:100,
                                                  child: Text(":  ${order["phone"]}",style: TextStyle(
                                                      overflow: TextOverflow.ellipsis
                                                  ))),
                                            ],
                                          ),

                                          //date
                                          Row(
                                            children: [
                                              Container(
                                                width:100,
                                                child: Text("Date",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                width: 150,
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
                                                width:100,
                                                child: Text("Time",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                width: 150,
                                                child: Text(":  ${order["time"].toString()}",style: TextStyle(
                                                    overflow: TextOverflow.ellipsis
                                                )),
                                              ),

                                            ],
                                          ),

                                          //total
                                          Row(
                                            children: [
                                              Container(
                                                width:100,
                                                child: Text("Total",
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                              ),
                                              Container(
                                                  width: order["status"]!="Canceled"? order["status"]=="Delivered"?70: 100 : 70,
                                                  child: Text(":  ${order["total"].toString()}",style: TextStyle(
                                                      overflow: TextOverflow.ellipsis
                                                  ))),

                                              order["status"]!="Canceled"? order["status"]=="Delivered"?Container(
                                                width:150,
                                                height:35,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: Center(child: Text("Delivered",style:
                                                GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600
                                                ))),
                                              ): Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){

                                                      Navigator.push(context,MaterialPageRoute(builder: (context) =>userorderviewlist_page(order.id,order['Userid'],order['name'].toString(),order['phone'].toString(),order['address'].toString(),order['latitude'],order['longitude']) ,));
                                                    },
                                                    child: Material(
                                                      borderRadius: BorderRadius.circular(5),
                                                      elevation: 2,
                                                      child: Container(
                                                          width: 60,
                                                          height:25,
                                                          decoration: BoxDecoration(color: Primarycolor,
                                                              borderRadius: BorderRadius.circular(5)
                                                          ),
                                                          child: Center(
                                                            child: Text("View",style:
                                                            GoogleFonts.poppins(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600
                                                            )),
                                                          )),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 8.0),
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        showdialog(order.id,order['Userid']);
                                                      },
                                                      child: Material(
                                                        borderRadius: BorderRadius.circular(5),
                                                        elevation: 2,
                                                        child: Container(
                                                            width: 120,
                                                            height:25,
                                                            decoration: BoxDecoration(color: Colors.redAccent,
                                                                borderRadius: BorderRadius.circular(5)
                                                            ),
                                                            child: Center(
                                                              child: Text("Cancel Order",style:
                                                              GoogleFonts.poppins(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.w600
                                                              )),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ) :
                                              Container(
                                                width:150,
                                                height:35,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: Center(child: Text("Order Canceled",style:
                                                GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600
                                                ))),
                                              )
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ):
                          SizedBox(): SizedBox();
                        }
                    ),
                  );

                },),
            ):
            Container(
              child: StreamBuilder<QuerySnapshot>(
                stream:FirebaseFirestore.instance.collection("Orders").orderBy("timestamp",descending: true).snapshots(),
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
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context,index) {
                          var order=snapshot.data!.docs[index];
                          return
                            mydate.isEmpty?
                            order["type"]==widget.type?  order["status"]=="ordered"?
                            Container(
                              child: Column(
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
                                        child: Column(
                                          children: [
                                            //orderid
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Order id",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                    width:150,

                                                    child: Text(":  ${order["orderid"]}",
                                                      style: TextStyle(
                                                          overflow: TextOverflow.ellipsis
                                                      ),)),
                                              ],
                                            ),

                                            //name
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Name",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                  width:150,
                                                  child: Text(":  ${order["name"]}",
                                                      style: TextStyle(
                                                          overflow: TextOverflow.ellipsis
                                                      )),
                                                ),
                                              ],
                                            ),

                                            //phone
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Phone",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                    width:100,
                                                    child: Text(":  ${order["phone"]}",style: TextStyle(
                                                        overflow: TextOverflow.ellipsis
                                                    ))),
                                              ],
                                            ),

                                            //date
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Date",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                  width: 150,
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
                                                  width:100,
                                                  child: Text("Time",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                  width: 150,
                                                  child: Text(":  ${order["time"].toString()}",style: TextStyle(
                                                      overflow: TextOverflow.ellipsis
                                                  )),
                                                ),

                                              ],
                                            ),

                                            //total
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Total",
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w600
                                                    ),),
                                                ),
                                                Container(
                                                    width: order["status"]!="Canceled"? order["status"]=="Delivered"?70: 100 : 70,
                                                    child: Text(":  ${order["total"].toString()}",style: TextStyle(
                                                        overflow: TextOverflow.ellipsis
                                                    ))),

                                                order["status"]!="Canceled"? order["status"]=="Delivered"?Container(
                                                  width:150,
                                                  height:35,
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Center(child: Text("Delivered",style:
                                                  GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600
                                                  ))),
                                                ): Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: (){

                                                        Navigator.push(context,MaterialPageRoute(builder: (context) =>userorderviewlist_page(order.id,order['Userid'],order['name'].toString(),order['phone'].toString(),order['address'].toString(),order['latitude'],order['longitude']) ,));
                                                      },
                                                      child: Material(
                                                        borderRadius: BorderRadius.circular(5),
                                                        elevation: 2,
                                                        child: Container(
                                                            width: 60,
                                                            height:25,
                                                            decoration: BoxDecoration(color: Primarycolor,
                                                                borderRadius: BorderRadius.circular(5)
                                                            ),
                                                            child: Center(
                                                              child: Text("View",style:
                                                              GoogleFonts.poppins(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.w600
                                                              )),
                                                            )),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 8.0),
                                                      child: GestureDetector(
                                                        onTap: (){
                                                          showdialog(order.id,order['Userid']);
                                                        },
                                                        child: Material(
                                                          borderRadius: BorderRadius.circular(5),
                                                          elevation: 2,
                                                          child: Container(
                                                              width: 120,
                                                              height:25,
                                                              decoration: BoxDecoration(color: Colors.redAccent,
                                                                  borderRadius: BorderRadius.circular(5)
                                                              ),
                                                              child: Center(
                                                                child: Text("Cancel Order",style:
                                                                GoogleFonts.poppins(
                                                                    color: Colors.white,
                                                                    fontWeight: FontWeight.w600
                                                                )),
                                                              )),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ) :
                                                Container(
                                                  width:150,
                                                  height:35,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Center(child: Text("Order Canceled",style:
                                                  GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600
                                                  ))),
                                                )
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ):
                            SizedBox():SizedBox() :  mydate.contains(order["date"])?
                            order["type"]==widget.type?  order["status"]=="ordered"?
                            Container(
                              child: Column(
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
                                        child: Column(
                                          children: [
                                            //orderid
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Order id",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                    width:150,

                                                    child: Text(":  ${order["orderid"]}",
                                                      style: TextStyle(
                                                          overflow: TextOverflow.ellipsis
                                                      ),)),
                                              ],
                                            ),

                                            //name
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Name",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                  width:150,
                                                  child: Text(":  ${order["name"]}",
                                                      style: TextStyle(
                                                          overflow: TextOverflow.ellipsis
                                                      )),
                                                ),
                                              ],
                                            ),

                                            //phone
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Phone",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                    width:100,
                                                    child: Text(":  ${order["phone"]}",style: TextStyle(
                                                        overflow: TextOverflow.ellipsis
                                                    ))),
                                              ],
                                            ),

                                            //date
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Date",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                  width: 150,
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
                                                  width:100,
                                                  child: Text("Time",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                  width: 150,
                                                  child: Text(":  ${order["time"].toString()}",style: TextStyle(
                                                      overflow: TextOverflow.ellipsis
                                                  )),
                                                ),

                                              ],
                                            ),

                                            //total
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Total",
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w600
                                                    ),),
                                                ),
                                                Container(
                                                    width: order["status"]!="Canceled"? order["status"]=="Delivered"?70: 100 : 70,
                                                    child: Text(":  ${order["total"].toString()}",style: TextStyle(
                                                        overflow: TextOverflow.ellipsis
                                                    ))),

                                                order["status"]!="Canceled"? order["status"]=="Delivered"?Container(
                                                  width:150,
                                                  height:35,
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Center(child: Text("Delivered",style:
                                                  GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600
                                                  ))),
                                                ): Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: (){

                                                        Navigator.push(context,MaterialPageRoute(builder: (context) =>userorderviewlist_page(order.id,order['Userid'],order['name'].toString(),order['phone'].toString(),order['address'].toString(),order['latitude'],order['longitude']) ,));
                                                      },
                                                      child: Material(
                                                        borderRadius: BorderRadius.circular(5),
                                                        elevation: 2,
                                                        child: Container(
                                                            width: 60,
                                                            height:25,
                                                            decoration: BoxDecoration(color: Primarycolor,
                                                                borderRadius: BorderRadius.circular(5)
                                                            ),
                                                            child: Center(
                                                              child: Text("View",style:
                                                              GoogleFonts.poppins(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.w600
                                                              )),
                                                            )),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 8.0),
                                                      child: GestureDetector(
                                                        onTap: (){
                                                          showdialog(order.id,order['Userid']);
                                                        },
                                                        child: Material(
                                                          borderRadius: BorderRadius.circular(5),
                                                          elevation: 2,
                                                          child: Container(
                                                              width: 120,
                                                              height:25,
                                                              decoration: BoxDecoration(color: Colors.redAccent,
                                                                  borderRadius: BorderRadius.circular(5)
                                                              ),
                                                              child: Center(
                                                                child: Text("Cancel Order",style:
                                                                GoogleFonts.poppins(
                                                                    color: Colors.white,
                                                                    fontWeight: FontWeight.w600
                                                                )),
                                                              )),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ) :
                                                Container(
                                                  width:150,
                                                  height:35,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Center(child: Text("Order Canceled",style:
                                                  GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600
                                                  ))),
                                                )
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ):
                            SizedBox():SizedBox() :SizedBox();
                        }
                    ),
                  );

                },),
            ) :   _currentSelection==1?
            widget.type==
                "All"?
            Container(
              child: StreamBuilder<QuerySnapshot>(
                stream:FirebaseFirestore.instance.collection("Orders").orderBy("timestamp",descending: true).snapshots(),
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
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context,index) {
                          var order=snapshot.data!.docs[index];
                          return mydate.isEmpty?
                          order["status"]=="Delivered"?
                          Container(
                            child: Column(
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
                                      child: Column(
                                        children: [
                                          //orderid
                                          Row(
                                            children: [
                                              Container(
                                                width:100,
                                                child: Text("Order id",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                  width:150,

                                                  child: Text(":  ${order["orderid"]}",
                                                    style: TextStyle(
                                                        overflow: TextOverflow.ellipsis
                                                    ),)),
                                            ],
                                          ),

                                          //name
                                          Row(
                                            children: [
                                              Container(
                                                width:100,
                                                child: Text("Name",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                width:150,
                                                child: Text(":  ${order["name"]}",
                                                    style: TextStyle(
                                                        overflow: TextOverflow.ellipsis
                                                    )),
                                              ),
                                            ],
                                          ),

                                          //phone
                                          Row(
                                            children: [
                                              Container(
                                                width:100,
                                                child: Text("Phone",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                  width:100,
                                                  child: Text(":  ${order["phone"]}",style: TextStyle(
                                                      overflow: TextOverflow.ellipsis
                                                  ))),
                                            ],
                                          ),

                                          //date
                                          Row(
                                            children: [
                                              Container(
                                                width:100,
                                                child: Text("Date",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                width: 150,
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
                                                width:100,
                                                child: Text("Time",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                width: 150,
                                                child: Text(":  ${order["time"].toString()}",style: TextStyle(
                                                    overflow: TextOverflow.ellipsis
                                                )),
                                              ),

                                            ],
                                          ),

                                          //total
                                          Row(
                                            children: [
                                              Container(
                                                width:100,
                                                child: Text("Total",
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                              ),
                                              Container(
                                                  width: order["status"]!="Canceled"? order["status"]=="Delivered"?70: 100 : 70,
                                                  child: Text(":  ${order["total"].toString()}",style: TextStyle(
                                                      overflow: TextOverflow.ellipsis
                                                  ))),

                                              order["status"]!="Canceled"? order["status"]=="Delivered"?Container(
                                                width:150,
                                                height:35,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: Center(child: Text("Delivered",style:
                                                GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600
                                                ))),
                                              ): Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){

                                                      Navigator.push(context,MaterialPageRoute(builder: (context) =>userorderviewlist_page(order.id,order['Userid'],order['name'].toString(),order['phone'].toString(),order['address'].toString(),order['latitude'],order['longitude']) ,));
                                                    },
                                                    child: Material(
                                                      borderRadius: BorderRadius.circular(5),
                                                      elevation: 2,
                                                      child: Container(
                                                          width: 60,
                                                          height:25,
                                                          decoration: BoxDecoration(color: Primarycolor,
                                                              borderRadius: BorderRadius.circular(5)
                                                          ),
                                                          child: Center(
                                                            child: Text("View",style:
                                                            GoogleFonts.poppins(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600
                                                            )),
                                                          )),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 8.0),
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        showdialog(order.id,order['Userid']);
                                                      },
                                                      child: Material(
                                                        borderRadius: BorderRadius.circular(5),
                                                        elevation: 2,
                                                        child: Container(
                                                            width: 120,
                                                            height:25,
                                                            decoration: BoxDecoration(color: Colors.redAccent,
                                                                borderRadius: BorderRadius.circular(5)
                                                            ),
                                                            child: Center(
                                                              child: Text("Cancel Order",style:
                                                              GoogleFonts.poppins(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.w600
                                                              )),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ) :
                                              Container(
                                                width:150,
                                                height:35,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: Center(child: Text("Order Canceled",style:
                                                GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600
                                                ))),
                                              )
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ):
                          SizedBox() : mydate.contains(order["date"])?
                          order["status"]=="Delivered"?
                          Container(
                            child: Column(
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
                                      child: Column(
                                        children: [
                                          //orderid
                                          Row(
                                            children: [
                                              Container(
                                                width:100,
                                                child: Text("Order id",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                  width:150,

                                                  child: Text(":  ${order["orderid"]}",
                                                    style: TextStyle(
                                                        overflow: TextOverflow.ellipsis
                                                    ),)),
                                            ],
                                          ),

                                          //name
                                          Row(
                                            children: [
                                              Container(
                                                width:100,
                                                child: Text("Name",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                width:150,
                                                child: Text(":  ${order["name"]}",
                                                    style: TextStyle(
                                                        overflow: TextOverflow.ellipsis
                                                    )),
                                              ),
                                            ],
                                          ),

                                          //phone
                                          Row(
                                            children: [
                                              Container(
                                                width:100,
                                                child: Text("Phone",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                  width:100,
                                                  child: Text(":  ${order["phone"]}",style: TextStyle(
                                                      overflow: TextOverflow.ellipsis
                                                  ))),
                                            ],
                                          ),

                                          //date
                                          Row(
                                            children: [
                                              Container(
                                                width:100,
                                                child: Text("Date",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                width: 150,
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
                                                width:100,
                                                child: Text("Time",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                width: 150,
                                                child: Text(":  ${order["time"].toString()}",style: TextStyle(
                                                    overflow: TextOverflow.ellipsis
                                                )),
                                              ),

                                            ],
                                          ),

                                          //total
                                          Row(
                                            children: [
                                              Container(
                                                width:100,
                                                child: Text("Total",
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                              ),
                                              Container(
                                                  width: order["status"]!="Canceled"? order["status"]=="Delivered"?70: 100 : 70,
                                                  child: Text(":  ${order["total"].toString()}",style: TextStyle(
                                                      overflow: TextOverflow.ellipsis
                                                  ))),

                                              order["status"]!="Canceled"? order["status"]=="Delivered"?Container(
                                                width:150,
                                                height:35,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: Center(child: Text("Delivered",style:
                                                GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600
                                                ))),
                                              ): Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){

                                                      Navigator.push(context,MaterialPageRoute(builder: (context) =>userorderviewlist_page(order.id,order['Userid'],order['name'].toString(),order['phone'].toString(),order['address'].toString(),order['latitude'],order['longitude']) ,));
                                                    },
                                                    child: Material(
                                                      borderRadius: BorderRadius.circular(5),
                                                      elevation: 2,
                                                      child: Container(
                                                          width: 60,
                                                          height:25,
                                                          decoration: BoxDecoration(color: Primarycolor,
                                                              borderRadius: BorderRadius.circular(5)
                                                          ),
                                                          child: Center(
                                                            child: Text("View",style:
                                                            GoogleFonts.poppins(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600
                                                            )),
                                                          )),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 8.0),
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        showdialog(order.id,order['Userid']);
                                                      },
                                                      child: Material(
                                                        borderRadius: BorderRadius.circular(5),
                                                        elevation: 2,
                                                        child: Container(
                                                            width: 120,
                                                            height:25,
                                                            decoration: BoxDecoration(color: Colors.redAccent,
                                                                borderRadius: BorderRadius.circular(5)
                                                            ),
                                                            child: Center(
                                                              child: Text("Cancel Order",style:
                                                              GoogleFonts.poppins(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.w600
                                                              )),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ) :
                                              Container(
                                                width:150,
                                                height:35,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: Center(child: Text("Order Canceled",style:
                                                GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600
                                                ))),
                                              )
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ):
                          SizedBox(): SizedBox();
                        }
                    ),
                  );

                },),
            ):
            Container(
              child: StreamBuilder<QuerySnapshot>(
                stream:FirebaseFirestore.instance.collection("Orders").orderBy("timestamp",descending: true).snapshots(),
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
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context,index) {
                          var order=snapshot.data!.docs[index];
                          return
                            mydate.isEmpty?
                            order["type"]==widget.type?  order["status"]=="Delivered"?
                            Container(
                              child: Column(
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
                                        child: Column(
                                          children: [
                                            //orderid
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Order id",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                    width:150,

                                                    child: Text(":  ${order["orderid"]}",
                                                      style: TextStyle(
                                                          overflow: TextOverflow.ellipsis
                                                      ),)),
                                              ],
                                            ),

                                            //name
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Name",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                  width:150,
                                                  child: Text(":  ${order["name"]}",
                                                      style: TextStyle(
                                                          overflow: TextOverflow.ellipsis
                                                      )),
                                                ),
                                              ],
                                            ),

                                            //phone
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Phone",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                    width:100,
                                                    child: Text(":  ${order["phone"]}",style: TextStyle(
                                                        overflow: TextOverflow.ellipsis
                                                    ))),
                                              ],
                                            ),

                                            //date
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Date",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                  width: 150,
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
                                                  width:100,
                                                  child: Text("Time",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                  width: 150,
                                                  child: Text(":  ${order["time"].toString()}",style: TextStyle(
                                                      overflow: TextOverflow.ellipsis
                                                  )),
                                                ),

                                              ],
                                            ),

                                            //total
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Total",
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w600
                                                    ),),
                                                ),
                                                Container(
                                                    width: order["status"]!="Canceled"? order["status"]=="Delivered"?70: 100 : 70,
                                                    child: Text(":  ${order["total"].toString()}",style: TextStyle(
                                                        overflow: TextOverflow.ellipsis
                                                    ))),

                                                order["status"]!="Canceled"? order["status"]=="Delivered"?Container(
                                                  width:150,
                                                  height:35,
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Center(child: Text("Delivered",style:
                                                  GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600
                                                  ))),
                                                ): Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: (){

                                                        Navigator.push(context,MaterialPageRoute(builder: (context) =>userorderviewlist_page(order.id,order['Userid'],order['name'].toString(),order['phone'].toString(),order['address'].toString(),order['latitude'],order['longitude']) ,));
                                                      },
                                                      child: Material(
                                                        borderRadius: BorderRadius.circular(5),
                                                        elevation: 2,
                                                        child: Container(
                                                            width: 60,
                                                            height:25,
                                                            decoration: BoxDecoration(color: Primarycolor,
                                                                borderRadius: BorderRadius.circular(5)
                                                            ),
                                                            child: Center(
                                                              child: Text("View",style:
                                                              GoogleFonts.poppins(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.w600
                                                              )),
                                                            )),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 8.0),
                                                      child: GestureDetector(
                                                        onTap: (){
                                                          showdialog(order.id,order['Userid']);
                                                        },
                                                        child: Material(
                                                          borderRadius: BorderRadius.circular(5),
                                                          elevation: 2,
                                                          child: Container(
                                                              width: 120,
                                                              height:25,
                                                              decoration: BoxDecoration(color: Colors.redAccent,
                                                                  borderRadius: BorderRadius.circular(5)
                                                              ),
                                                              child: Center(
                                                                child: Text("Cancel Order",style:
                                                                GoogleFonts.poppins(
                                                                    color: Colors.white,
                                                                    fontWeight: FontWeight.w600
                                                                )),
                                                              )),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ) :
                                                Container(
                                                  width:150,
                                                  height:35,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Center(child: Text("Order Canceled",style:
                                                  GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600
                                                  ))),
                                                )
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ):
                            SizedBox():SizedBox() :  mydate.contains(order["date"])?
                            order["type"]==widget.type?  order["status"]=="Delivered"?
                            Container(
                              child: Column(
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
                                        child: Column(
                                          children: [
                                            //orderid
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Order id",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                    width:150,

                                                    child: Text(":  ${order["orderid"]}",
                                                      style: TextStyle(
                                                          overflow: TextOverflow.ellipsis
                                                      ),)),
                                              ],
                                            ),

                                            //name
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Name",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                  width:150,
                                                  child: Text(":  ${order["name"]}",
                                                      style: TextStyle(
                                                          overflow: TextOverflow.ellipsis
                                                      )),
                                                ),
                                              ],
                                            ),

                                            //phone
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Phone",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                    width:100,
                                                    child: Text(":  ${order["phone"]}",style: TextStyle(
                                                        overflow: TextOverflow.ellipsis
                                                    ))),
                                              ],
                                            ),

                                            //date
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Date",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                  width: 150,
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
                                                  width:100,
                                                  child: Text("Time",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                  width: 150,
                                                  child: Text(":  ${order["time"].toString()}",style: TextStyle(
                                                      overflow: TextOverflow.ellipsis
                                                  )),
                                                ),

                                              ],
                                            ),

                                            //total
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Total",
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w600
                                                    ),),
                                                ),
                                                Container(
                                                    width: order["status"]!="Canceled"? order["status"]=="Delivered"?70: 100 : 70,
                                                    child: Text(":  ${order["total"].toString()}",style: TextStyle(
                                                        overflow: TextOverflow.ellipsis
                                                    ))),

                                                order["status"]!="Canceled"? order["status"]=="Delivered"?Container(
                                                  width:150,
                                                  height:35,
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Center(child: Text("Delivered",style:
                                                  GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600
                                                  ))),
                                                ): Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: (){

                                                        Navigator.push(context,MaterialPageRoute(builder: (context) =>userorderviewlist_page(order.id,order['Userid'],order['name'].toString(),order['phone'].toString(),order['address'].toString(),order['latitude'],order['longitude']) ,));
                                                      },
                                                      child: Material(
                                                        borderRadius: BorderRadius.circular(5),
                                                        elevation: 2,
                                                        child: Container(
                                                            width: 60,
                                                            height:25,
                                                            decoration: BoxDecoration(color: Primarycolor,
                                                                borderRadius: BorderRadius.circular(5)
                                                            ),
                                                            child: Center(
                                                              child: Text("View",style:
                                                              GoogleFonts.poppins(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.w600
                                                              )),
                                                            )),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 8.0),
                                                      child: GestureDetector(
                                                        onTap: (){
                                                          showdialog(order.id,order['Userid']);
                                                        },
                                                        child: Material(
                                                          borderRadius: BorderRadius.circular(5),
                                                          elevation: 2,
                                                          child: Container(
                                                              width: 120,
                                                              height:25,
                                                              decoration: BoxDecoration(color: Colors.redAccent,
                                                                  borderRadius: BorderRadius.circular(5)
                                                              ),
                                                              child: Center(
                                                                child: Text("Cancel Order",style:
                                                                GoogleFonts.poppins(
                                                                    color: Colors.white,
                                                                    fontWeight: FontWeight.w600
                                                                )),
                                                              )),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ) :
                                                Container(
                                                  width:150,
                                                  height:35,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Center(child: Text("Order Canceled",style:
                                                  GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600
                                                  ))),
                                                )
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ):
                            SizedBox():SizedBox() :SizedBox();
                        }
                    ),
                  );

                },),
            ) :  widget.type==
                "All"?
            Container(
              child: StreamBuilder<QuerySnapshot>(
                stream:FirebaseFirestore.instance.collection("Orders").orderBy("timestamp",descending: true).snapshots(),
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
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context,index) {
                          var order=snapshot.data!.docs[index];
                          return mydate.isEmpty?
                          order["status"]=="Canceled"?
                          Container(
                            child: Column(
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
                                      child: Column(
                                        children: [
                                          //orderid
                                          Row(
                                            children: [
                                              Container(
                                                width:100,
                                                child: Text("Order id",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                  width:150,

                                                  child: Text(":  ${order["orderid"]}",
                                                    style: TextStyle(
                                                        overflow: TextOverflow.ellipsis
                                                    ),)),
                                            ],
                                          ),

                                          //name
                                          Row(
                                            children: [
                                              Container(
                                                width:100,
                                                child: Text("Name",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                width:150,
                                                child: Text(":  ${order["name"]}",
                                                    style: TextStyle(
                                                        overflow: TextOverflow.ellipsis
                                                    )),
                                              ),
                                            ],
                                          ),

                                          //phone
                                          Row(
                                            children: [
                                              Container(
                                                width:100,
                                                child: Text("Phone",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                  width:100,
                                                  child: Text(":  ${order["phone"]}",style: TextStyle(
                                                      overflow: TextOverflow.ellipsis
                                                  ))),
                                            ],
                                          ),

                                          //date
                                          Row(
                                            children: [
                                              Container(
                                                width:100,
                                                child: Text("Date",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                width: 150,
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
                                                width:100,
                                                child: Text("Time",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                width: 150,
                                                child: Text(":  ${order["time"].toString()}",style: TextStyle(
                                                    overflow: TextOverflow.ellipsis
                                                )),
                                              ),

                                            ],
                                          ),

                                          //total
                                          Row(
                                            children: [
                                              Container(
                                                width:100,
                                                child: Text("Total",
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                              ),
                                              Container(
                                                  width: order["status"]!="Canceled"? order["status"]=="Delivered"?70: 100 : 70,
                                                  child: Text(":  ${order["total"].toString()}",style: TextStyle(
                                                      overflow: TextOverflow.ellipsis
                                                  ))),

                                              order["status"]!="Canceled"? order["status"]=="Delivered"?Container(
                                                width:150,
                                                height:35,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: Center(child: Text("Delivered",style:
                                                GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600
                                                ))),
                                              ): Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){

                                                      Navigator.push(context,MaterialPageRoute(builder: (context) =>userorderviewlist_page(order.id,order['Userid'],order['name'].toString(),order['phone'].toString(),order['address'].toString(),order['latitude'],order['longitude']) ,));
                                                    },
                                                    child: Material(
                                                      borderRadius: BorderRadius.circular(5),
                                                      elevation: 2,
                                                      child: Container(
                                                          width: 60,
                                                          height:25,
                                                          decoration: BoxDecoration(color: Primarycolor,
                                                              borderRadius: BorderRadius.circular(5)
                                                          ),
                                                          child: Center(
                                                            child: Text("View",style:
                                                            GoogleFonts.poppins(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600
                                                            )),
                                                          )),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 8.0),
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        showdialog(order.id,order['Userid']);
                                                      },
                                                      child: Material(
                                                        borderRadius: BorderRadius.circular(5),
                                                        elevation: 2,
                                                        child: Container(
                                                            width: 120,
                                                            height:25,
                                                            decoration: BoxDecoration(color: Colors.redAccent,
                                                                borderRadius: BorderRadius.circular(5)
                                                            ),
                                                            child: Center(
                                                              child: Text("Cancel Order",style:
                                                              GoogleFonts.poppins(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.w600
                                                              )),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ) :
                                              Container(
                                                width:150,
                                                height:35,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: Center(child: Text("Order Canceled",style:
                                                GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600
                                                ))),
                                              )
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ):
                          SizedBox() : mydate.contains(order["date"])?
                          order["status"]=="Canceled"?
                          Container(
                            child: Column(
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
                                      child: Column(
                                        children: [
                                          //orderid
                                          Row(
                                            children: [
                                              Container(
                                                width:100,
                                                child: Text("Order id",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                  width:150,

                                                  child: Text(":  ${order["orderid"]}",
                                                    style: TextStyle(
                                                        overflow: TextOverflow.ellipsis
                                                    ),)),
                                            ],
                                          ),

                                          //name
                                          Row(
                                            children: [
                                              Container(
                                                width:100,
                                                child: Text("Name",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                width:150,
                                                child: Text(":  ${order["name"]}",
                                                    style: TextStyle(
                                                        overflow: TextOverflow.ellipsis
                                                    )),
                                              ),
                                            ],
                                          ),

                                          //phone
                                          Row(
                                            children: [
                                              Container(
                                                width:100,
                                                child: Text("Phone",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                  width:100,
                                                  child: Text(":  ${order["phone"]}",style: TextStyle(
                                                      overflow: TextOverflow.ellipsis
                                                  ))),
                                            ],
                                          ),

                                          //date
                                          Row(
                                            children: [
                                              Container(
                                                width:100,
                                                child: Text("Date",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                width: 150,
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
                                                width:100,
                                                child: Text("Time",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ),
                                              Container(
                                                width: 150,
                                                child: Text(":  ${order["time"].toString()}",style: TextStyle(
                                                    overflow: TextOverflow.ellipsis
                                                )),
                                              ),

                                            ],
                                          ),

                                          //total
                                          Row(
                                            children: [
                                              Container(
                                                width:100,
                                                child: Text("Total",
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                              ),
                                              Container(
                                                  width: order["status"]!="Canceled"? order["status"]=="Delivered"?70: 100 : 70,
                                                  child: Text(":  ${order["total"].toString()}",style: TextStyle(
                                                      overflow: TextOverflow.ellipsis
                                                  ))),

                                              order["status"]!="Canceled"? order["status"]=="Delivered"?Container(
                                                width:150,
                                                height:35,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: Center(child: Text("Delivered",style:
                                                GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600
                                                ))),
                                              ): Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){

                                                      Navigator.push(context,MaterialPageRoute(builder: (context) =>userorderviewlist_page(order.id,order['Userid'],order['name'].toString(),order['phone'].toString(),order['address'].toString(),order['latitude'],order['longitude']) ,));
                                                    },
                                                    child: Material(
                                                      borderRadius: BorderRadius.circular(5),
                                                      elevation: 2,
                                                      child: Container(
                                                          width: 60,
                                                          height:25,
                                                          decoration: BoxDecoration(color: Primarycolor,
                                                              borderRadius: BorderRadius.circular(5)
                                                          ),
                                                          child: Center(
                                                            child: Text("View",style:
                                                            GoogleFonts.poppins(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600
                                                            )),
                                                          )),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 8.0),
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        showdialog(order.id,order['Userid']);
                                                      },
                                                      child: Material(
                                                        borderRadius: BorderRadius.circular(5),
                                                        elevation: 2,
                                                        child: Container(
                                                            width: 120,
                                                            height:25,
                                                            decoration: BoxDecoration(color: Colors.redAccent,
                                                                borderRadius: BorderRadius.circular(5)
                                                            ),
                                                            child: Center(
                                                              child: Text("Cancel Order",style:
                                                              GoogleFonts.poppins(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.w600
                                                              )),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ) :
                                              Container(
                                                width:150,
                                                height:35,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: Center(child: Text("Order Canceled",style:
                                                GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600
                                                ))),
                                              )
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ):
                          SizedBox(): SizedBox();
                        }
                    ),
                  );

                },),
            ):
            Container(
              child: StreamBuilder<QuerySnapshot>(
                stream:FirebaseFirestore.instance.collection("Orders").orderBy("timestamp",descending: true).snapshots(),
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
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context,index) {
                          var order=snapshot.data!.docs[index];
                          return
                            mydate.isEmpty?
                            order["type"]==widget.type?  order["status"]=="Canceled"?
                            Container(
                              child: Column(
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
                                        child: Column(
                                          children: [
                                            //orderid
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Order id",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                    width:150,

                                                    child: Text(":  ${order["orderid"]}",
                                                      style: TextStyle(
                                                          overflow: TextOverflow.ellipsis
                                                      ),)),
                                              ],
                                            ),

                                            //name
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Name",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                  width:150,
                                                  child: Text(":  ${order["name"]}",
                                                      style: TextStyle(
                                                          overflow: TextOverflow.ellipsis
                                                      )),
                                                ),
                                              ],
                                            ),

                                            //phone
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Phone",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                    width:100,
                                                    child: Text(":  ${order["phone"]}",style: TextStyle(
                                                        overflow: TextOverflow.ellipsis
                                                    ))),
                                              ],
                                            ),

                                            //date
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Date",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                  width: 150,
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
                                                  width:100,
                                                  child: Text("Time",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                  width: 150,
                                                  child: Text(":  ${order["time"].toString()}",style: TextStyle(
                                                      overflow: TextOverflow.ellipsis
                                                  )),
                                                ),

                                              ],
                                            ),

                                            //total
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Total",
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w600
                                                    ),),
                                                ),
                                                Container(
                                                    width: order["status"]!="Canceled"? order["status"]=="Delivered"?70: 100 : 70,
                                                    child: Text(":  ${order["total"].toString()}",style: TextStyle(
                                                        overflow: TextOverflow.ellipsis
                                                    ))),

                                                order["status"]!="Canceled"? order["status"]=="Delivered"?Container(
                                                  width:150,
                                                  height:35,
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Center(child: Text("Delivered",style:
                                                  GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600
                                                  ))),
                                                ): Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: (){

                                                        Navigator.push(context,MaterialPageRoute(builder: (context) =>userorderviewlist_page(order.id,order['Userid'],order['name'].toString(),order['phone'].toString(),order['address'].toString(),order['latitude'],order['longitude']) ,));
                                                      },
                                                      child: Material(
                                                        borderRadius: BorderRadius.circular(5),
                                                        elevation: 2,
                                                        child: Container(
                                                            width: 60,
                                                            height:25,
                                                            decoration: BoxDecoration(color: Primarycolor,
                                                                borderRadius: BorderRadius.circular(5)
                                                            ),
                                                            child: Center(
                                                              child: Text("View",style:
                                                              GoogleFonts.poppins(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.w600
                                                              )),
                                                            )),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 8.0),
                                                      child: GestureDetector(
                                                        onTap: (){
                                                          showdialog(order.id,order['Userid']);
                                                        },
                                                        child: Material(
                                                          borderRadius: BorderRadius.circular(5),
                                                          elevation: 2,
                                                          child: Container(
                                                              width: 120,
                                                              height:25,
                                                              decoration: BoxDecoration(color: Colors.redAccent,
                                                                  borderRadius: BorderRadius.circular(5)
                                                              ),
                                                              child: Center(
                                                                child: Text("Cancel Order",style:
                                                                GoogleFonts.poppins(
                                                                    color: Colors.white,
                                                                    fontWeight: FontWeight.w600
                                                                )),
                                                              )),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ) :
                                                Container(
                                                  width:150,
                                                  height:35,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Center(child: Text("Order Canceled",style:
                                                  GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600
                                                  ))),
                                                )
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ):
                            SizedBox():SizedBox() :  mydate.contains(order["date"])?
                            order["type"]==widget.type?  order["status"]=="Canceled"?
                            Container(
                              child: Column(
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
                                        child: Column(
                                          children: [
                                            //orderid
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Order id",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                    width:150,

                                                    child: Text(":  ${order["orderid"]}",
                                                      style: TextStyle(
                                                          overflow: TextOverflow.ellipsis
                                                      ),)),
                                              ],
                                            ),

                                            //name
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Name",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                  width:150,
                                                  child: Text(":  ${order["name"]}",
                                                      style: TextStyle(
                                                          overflow: TextOverflow.ellipsis
                                                      )),
                                                ),
                                              ],
                                            ),

                                            //phone
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Phone",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                    width:100,
                                                    child: Text(":  ${order["phone"]}",style: TextStyle(
                                                        overflow: TextOverflow.ellipsis
                                                    ))),
                                              ],
                                            ),

                                            //date
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Date",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                  width: 150,
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
                                                  width:100,
                                                  child: Text("Time",style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                ),
                                                Container(
                                                  width: 150,
                                                  child: Text(":  ${order["time"].toString()}",style: TextStyle(
                                                      overflow: TextOverflow.ellipsis
                                                  )),
                                                ),

                                              ],
                                            ),

                                            //total
                                            Row(
                                              children: [
                                                Container(
                                                  width:100,
                                                  child: Text("Total",
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w600
                                                    ),),
                                                ),
                                                Container(
                                                    width: order["status"]!="Canceled"? order["status"]=="Delivered"?70: 100 : 70,
                                                    child: Text(":  ${order["total"].toString()}",style: TextStyle(
                                                        overflow: TextOverflow.ellipsis
                                                    ))),

                                                order["status"]!="Canceled"? order["status"]=="Delivered"?Container(
                                                  width:150,
                                                  height:35,
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Center(child: Text("Delivered",style:
                                                  GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600
                                                  ))),
                                                ): Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: (){

                                                        Navigator.push(context,MaterialPageRoute(builder: (context) =>userorderviewlist_page(order.id,order['Userid'],order['name'].toString(),order['phone'].toString(),order['address'].toString(),order['latitude'],order['longitude']) ,));
                                                      },
                                                      child: Material(
                                                        borderRadius: BorderRadius.circular(5),
                                                        elevation: 2,
                                                        child: Container(
                                                            width: 60,
                                                            height:25,
                                                            decoration: BoxDecoration(color: Primarycolor,
                                                                borderRadius: BorderRadius.circular(5)
                                                            ),
                                                            child: Center(
                                                              child: Text("View",style:
                                                              GoogleFonts.poppins(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.w600
                                                              )),
                                                            )),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 8.0),
                                                      child: GestureDetector(
                                                        onTap: (){
                                                          showdialog(order.id,order['Userid']);
                                                        },
                                                        child: Material(
                                                          borderRadius: BorderRadius.circular(5),
                                                          elevation: 2,
                                                          child: Container(
                                                              width: 120,
                                                              height:25,
                                                              decoration: BoxDecoration(color: Colors.redAccent,
                                                                  borderRadius: BorderRadius.circular(5)
                                                              ),
                                                              child: Center(
                                                                child: Text("Cancel Order",style:
                                                                GoogleFonts.poppins(
                                                                    color: Colors.white,
                                                                    fontWeight: FontWeight.w600
                                                                )),
                                                              )),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ) :
                                                Container(
                                                  width:150,
                                                  height:35,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Center(child: Text("Order Canceled",style:
                                                  GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600
                                                  ))),
                                                )
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ):
                            SizedBox():SizedBox() :SizedBox();
                        }
                    ),
                  );

                },),
            )
            ,
          ],
        ),
      )



    );
  }
  showdialog(docid,userid){
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
                Text("Cancel Order",style: GoogleFonts.poppins(
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
                    dailyupdat(docid,userid);
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
                        "Yes",style: GoogleFonts.poppins(color: Colors.black,
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
  dailyupdat(docid,userid) async {
    FirebaseFirestore.instance.collection("Orders").doc(docid).update({
      "status":"Canceled"
    });

    FirebaseFirestore.instance.collection("Users").doc(userid).collection("Orders").doc(docid).update({
      "status":"Canceled"
    });

    }



}
