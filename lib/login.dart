import 'dart:convert';
import 'package:cash_book/connect.dart';
import 'package:cash_book/home.dart';
import 'package:cash_book/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'connect.dart';
class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final TextEditingController mobile_noctrl=TextEditingController();
  final TextEditingController passwordctrl=TextEditingController();
  var visible_password=true;
  final GlobalKey<FormState> _formkey =GlobalKey<FormState>();
  Future<void> login() async {
    var data={
      'mobile_no':mobile_noctrl.text,
      'password':passwordctrl.text,
    };
    var response=await post(Uri.parse("${connect.url}login/login.php"),body: data);
    print(response.body);
    print(response.statusCode);
    if (jsonDecode(response.body)['result']=='success') {
      id(jsonDecode(response.body)['log_id']);
      print(jsonDecode(response.body)['log_id']);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>home(total: total,)), (Route<dynamic> route) => false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('logIn')));
    }
    else
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed')));

    }
    @override
    void initState(){
      super.initState();
      getLoginId();
    }
  }

  Future<void> id(String log_id) async {
    var data={
      'log_id':log_id,
    };
    var response=await post(Uri.parse("${connect.url}login/profile.php"),body: data);
    print(response.body);
    log_id=jsonDecode(response.body)['log_id'];
    if (log_id!=null) {
      savedata(log_id);
      print('data saved');
    }
    @override
    void initState(){
      super.initState();
      getLoginId();
    }
  }

  void savedata(String loginId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('loginId', loginId);
    print(loginId);
    print('data ');

  }
  Future<String?> getLoginId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? login_id = prefs.getString('loginId');
    return login_id;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: Text('Cash Book',style: GoogleFonts.cantarell(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                              // fontFamily: 'Times New Roman'
                            ),),
                          ),
                        ),
                        Icon(Icons.bookmark_added_outlined,size: 70,color: Colors.blueGrey,),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 30),
                          child: TextFormField(
                            keyboardType: TextInputType.numberWithOptions(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your mobile number';
                              }
                              return null;
                            },
                            controller: mobile_noctrl,
                            style: TextStyle(color: Colors.black,fontSize: 18),
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.person_outline_outlined,color: Colors.blueGrey,),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Mobile number',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical:0.0,horizontal: 18),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            controller: passwordctrl,
                            style: TextStyle(color: Colors.black,fontSize: 18),
                            obscureText: visible_password,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(onPressed: (){
                                  setState(() {
                                    visible_password=!visible_password;
                                    print(visible_password);
                                  });
                                }, icon:(visible_password)?Icon(Icons.visibility_off_outlined,color: Colors.blueGrey,):Icon(Icons.visibility_outlined,color: Colors.blueGrey,)),

                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Password',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 225.0),
                          child: TextButton(onPressed: (){
                          }, child: Text('forget password?',style:GoogleFonts.alexandria(color: Colors.black),)),
                        ),
                        Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  backgroundColor: Colors.blueGrey),
                              onPressed:
                                login
                              , child: Text('LogIn',style: GoogleFonts.alexandria(fontSize: 20),)),
                        ),
                        SizedBox(
                          height:35,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Dont have an Account? ',style: TextStyle(color: Colors.black),),
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>register()));
                            }, child: Text('Signup',style: TextStyle(color: Colors.blueGrey),))
                          ],
                        ),

                      ]),
                ))));
  }
}
