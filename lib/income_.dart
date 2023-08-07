import 'dart:convert';

import 'package:cash_book/connect.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
class income_ extends StatefulWidget {
  const income_({super.key});

  @override
  State<income_> createState() => _income_State();
}

class _income_State extends State<income_> {
  var log_id=getLoginId();
  var flag;
  var _income_;
  List< dynamic> dataList = [{}];

  Future<String?>? log_idFuture;
  void initState() {
    super.initState();
    log_idFuture = getLoginId(); // Assign the future to log_idFuture
    setState(() {
      getdata();

    });
  }

  Future<dynamic> getdata() async {
    var log_id = await log_idFuture;
    var data={
      'log_id':log_id
    };
    print(log_id);
    var response=await post(Uri.parse("${connect.url}cash/view_income.php"),body: data);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200 && jsonDecode(response.body)[0]['result']=='success') {
      print(response.body);
      flag=1;
      _income_=jsonDecode(response.body);
      // setState(() {
        dataList=_income_;
      total_i=0;
      dataList.forEach((element) {
        total_i=total_i+ int.parse(element['amount']);
      });
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Total Income (+)',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green[600]),),
              Text('${total_i}',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.green[600])),

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
                    return  Padding(
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
                                        style: TextStyle(color: Colors.green[600],
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
                    );
                  }
                }
            ),
          ),
        ],
      ),
    );
  }
}
