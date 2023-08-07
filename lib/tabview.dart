import 'package:cash_book/expence_.dart';
import 'package:cash_book/income_.dart';
import 'package:flutter/material.dart';
class tab_ extends StatefulWidget {
  const tab_({Key? key}) : super(key: key);

  @override
  State<tab_> createState() => _tab_State();
}

class _tab_State extends State<tab_> {
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title:  TabBar(
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
        ),
        body: TabBarView(children: [
          income_(),
          expnece_()
        ]),
      ),
    );
  }
}
