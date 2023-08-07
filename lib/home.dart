import 'package:cash_book/_expence.dart';
import 'package:cash_book/connect.dart';
import 'package:cash_book/tabview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '_income.dart';
import 'expence_.dart';
import 'income_.dart';
import 'login.dart';
class home extends StatefulWidget {
   home( {super.key,required this.total});
  var total;
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  void updateTotal(int newTotal) {
    setState(() {
      total = newTotal;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      updateTotal(total);
      refresh();
    });
  }
  Future<void> refresh() async {
    await Future.delayed(Duration(milliseconds: 300));
    setState(() {

    });
  }
  // int income_=1000;
  // int expence_=500;
  // late int balance;
  // int balance=income_-expence_;

  @override

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions:[
            IconButton(onPressed: (){
            showDialog(context: context, builder: (context) {
              return AlertDialog(
                title: Text('Are you sure you want to logout!'),
                actions: [
                  TextButton(onPressed: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => h1()));
                    Navigator.pop(context);
                  }, child: Text('No')),
                  TextButton(onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => login()));
                  }, child: Text('Yes')),

                ],
              );
            });
          }, icon: Icon(Icons.logout)),
          ],
          title: Text('cashbook'.toUpperCase(),style:GoogleFonts.cantarell(color: Colors.black),),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Card(
            //     elevation: 5,
            //     child: Container(
            //
            //       height: 170,
            //       // width: double.infinity,
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(5)
            //       ),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Text('Balance',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            //                 Text('1000',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            //
            //               ],
            //             ),
            //           ),
            //           Divider(
            //             thickness: 3,
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Text('Total Income (+)',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.green[600]),),
            //                 Text('${total}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.green[600])),
            //
            //               ],
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Text('Total Expense (-)',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.red[600]),),
            //                 Text('${total}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.red[600])),
            //
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // Text('Showing entries'),
            // Divider(),
            TabBar(
                indicator: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(40)
                ),
                labelColor: Colors.green,
                unselectedLabelColor: Colors.red,
                tabs:[
                  Tab(
                    text: 'Income',
                  ),
                  Tab(
                    text: 'Expence',
                  )]
            ),
            Expanded(
              child: TabBarView(children: [
                income_(),
                expnece_()
              ]),
            ),

            Card(
              elevation: 5,
              child: Container(
                height: 60,
                width: double.infinity,
                color: Colors.black12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 40,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                            )
                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>income()));
                          }, child: Text('Add Income (+)')),
                    ),
                    Container(
                      height: 40,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)
                              )
                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>expence()));

                          }, child: Text('Add Expence (-)')),
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
