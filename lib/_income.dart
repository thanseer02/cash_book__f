import 'package:cash_book/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:io';

import 'package:intl/intl.dart';

import 'connect.dart';
class income extends StatefulWidget {


  @override
  State<income> createState() => _incomeState();
}

class _incomeState extends State<income> {

  final TextEditingController amountctrl =TextEditingController();
  final TextEditingController datectrl =TextEditingController();
  final TextEditingController discriptionctrl =TextEditingController();
  final status='income';
  DateTime selectedDate = DateTime.now();
  Future<void> select_date() async {
    final DateTime? pick= await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (pick!=null && pick!=select_date) {
      print(pick);
      String formatteddate=DateFormat('yyyy-MM-dd').format(pick);
      print(formatteddate);
      datectrl.text=formatteddate ;

      setState(() {
        datectrl.text=formatteddate ;
      });
    }
  }
  @override
  void initState(){
    super.initState();
    getLoginId();
  }
  Future<void> add() async {
    var log_id=await getLoginId();
    print(log_id);
    print(status);
    print("log_id");

    var data={
      'log_id':log_id,
      'date':datectrl.text,
      'amount':amountctrl.text,
      'discription':discriptionctrl.text,
      'status':status,

    };
    var response=await post(Uri.parse("${connect.url}cash/inc_exp.php"),body: data);
    print(response.body);
    if (response.statusCode==200) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>home(total: total,)));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Entry added')));
    }
    else
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Event adding failed')));

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_ios_new,color: Colors.black,),),
          title: Text('Add Cash In Entry',style:TextStyle(color: Colors.green)),
        ),
        body: SingleChildScrollView(
          child: Form(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 52,
                    child: TextFormField(
                      validator: (val){
                        if ( val!.isEmpty){
                          return 'Field required';
                        }
                        return null;
                      },
                      controller: amountctrl,
                      decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      label: Text('Amount'),
                      prefixIcon: Icon(CupertinoIcons.money_dollar),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      focusedBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),),
                  ),
                ),
                SizedBox(height: 8,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 65,
                    child: TextFormField(
                      validator: (val){
                        if ( val!.isEmpty){
                          return 'Field required';
                        }
                        return null;
                      },
                      controller: discriptionctrl,
                      decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      label: Text('Discription'),
                      prefixIcon: Icon(Icons.note_alt_outlined),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      focusedBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),),
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 52,
                    child:  TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        label: Text('$DateTime'),
                        prefixIcon: Icon(CupertinoIcons.calendar),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        focusedBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (val){
                        if ( val!.isEmpty){
                          return 'Field required';
                        }
                        return null;
                      },
                      controller: datectrl,
                      onTap: (){
                        setState(() {
                          select_date();

                        });
                      },

                    ),
                  ),
                ),

                SizedBox(height: 10,),
                Center(
                  child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: ElevatedButton(
                          style:ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: Colors.blueGrey),
                          onPressed: (){
                          add();
                          }, child: Text('Save'))),
                )


              ],
            ),
          ),
        ),
        );
    }
}
