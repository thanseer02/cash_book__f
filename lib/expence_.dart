import 'dart:convert';
import 'package:cash_book/_expence.dart';
import 'package:cash_book/connect.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
class expnece_ extends StatefulWidget {
  const expnece_({super.key});

  @override
  State<expnece_> createState() => _expnece_State();
}

class _expnece_State extends State<expnece_> {
  @override
  var log_id=getLoginId();
  var flag;
  double sum=0;
  // List<dynamic> amount = [];
  List<dynamic> dataList = [];
  // List< dynamic> dataList = [{}];
  List< dynamic> data1 = [];

  var _expence_;
  Future<String?>? log_idFuture;

  Future<dynamic> getdata() async {
    var log_id = await log_idFuture;
    var data={
      'log_id':log_id
    };
    print(log_id);
    var response=await post(Uri.parse("${connect.url}cash/view_expence.php"),body: data);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200 && jsonDecode(response.body)[0]['result']=='success') {
      print(response.body);
      flag=1;
      _expence_=jsonDecode(response.body);
      // setState(() {
        dataList=_expence_;
        total=0;
        dataList.forEach((element) {
         total=total+ int.parse(element['amount']);
        });
        print(total);
      // });

      return jsonDecode(response.body);
    }
    else {
      flag=0;
      const CircularProgressIndicator();
      print('error');
    }
  }
  @override
  void initState() {
    super.initState();
    log_idFuture = getLoginId(); // Assign the future to log_idFuture
    setState(() {
      getdata();

    });
  }
  

  // double add(  Map< String, dynamic> data1) {
  //   double sumUsingLoop = 10;
  //
  //   for (var i in dataList) {
  //     sumUsingLoop += i;
  //     print(sumUsingLoop);
  //   }
  //   return sumUsingLoop;
  // }

  @override
  Widget build(BuildContext context) {
  //   for (var item in data1) {
  //     // Access the 'amount' key from the map and calculate the sum, max, and min
  //     if (item is Map<String, dynamic> && item.containsKey('amount')) {
  //       double amount = item['amount'].toDouble(); // Convert to double if needed
  //       sum += amount;
  //     }
  //   }
    return Scaffold(
      body: Column(
        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Total Income (+)',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red),),
            Text('${total}',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.red)),

          ],
        ),
          Expanded(
            child: FutureBuilder(
              future: getdata(),
    builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data.length == null) {
              return Center(child: CircularProgressIndicator(),);
            }
            else {
              return
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${dataList[index]['discription']}',
                                  style: TextStyle(color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),),
                                Text('${dataList[index]['date']}',
                                  style: TextStyle(color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),),
                                Text('${dataList[index]['amount']}',
                                  style: TextStyle(color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),)

                              ],
                            ),


                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        thickness: 2,
                      );
                    },
                    itemCount: dataList.length,


                  ),

                ),



            );}}),
          ),
        ],
      )
    );
  }
}
