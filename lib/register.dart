import 'dart:convert';

import 'package:cash_book/home.dart';
import 'package:cash_book/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import '../connect.dart';
class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  var visible_password=true;
  var visible_confirmpassword=true;
  bool _isValid = true;
  var namectrl=TextEditingController();
  var mobile_noctrl=TextEditingController();
  var passwordctrl=TextEditingController();
  var confirm_passwordctrl=TextEditingController();
  final GlobalKey<FormState> _registerkey=GlobalKey<FormState>();
  bool validateMobileNumber(String mobileNumber) {
    RegExp mobileRegex = RegExp(r'^[0-9]{10}$');
    return mobileRegex.hasMatch(mobileNumber);
  }

  Future<void> senddata() async {
    var data={
      'name':namectrl.text,
      'mobile_no':mobile_noctrl.text,
      'password':passwordctrl.text,
    };
    var response=await post(Uri.parse("${connect.url}login/register.php"),body: data);
    print(response.body);
    if (jsonDecode(response.body)['result']=='success') {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>home(total: total,)));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registered')));

    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registraion Failed')));

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:SingleChildScrollView(
          child: Form(
            key: _registerkey,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                Text('Cash Book'.toUpperCase(),style: GoogleFonts.cantarell(
                  fontSize: 50,
                  color: Colors.blueGrey,
                ),),
                SizedBox(height: 20,),
                Icon(Icons.bookmark_added_outlined,size: 70,color: Colors.blueGrey,),
//app name
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all( 10),
                  child: TextFormField(
                    validator: (val){
                      if ( val!.isEmpty){
                        return 'field required';
                      }
                    },
                    controller: namectrl,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: ' Name',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,

                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.numberWithOptions(),
                    onChanged: (value) {
                      setState(() {
                        _isValid = validateMobileNumber(value);
                      });
                    },
                    validator: (val){
                      if ( val!.isEmpty){
                        return 'field required';
                      }
                    },
                    controller: mobile_noctrl,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        errorText: _isValid ? null : 'Invalid mobile number',
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Mobile no',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,

                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all( 10),
                  child: TextFormField(
                    validator: (val){
                      if (val!.length<=6 && val.isEmpty){
                        return 'password required or too short';
                      }
                    },
                    obscureText: visible_password,
                    controller: passwordctrl,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            visible_password=!visible_password;
                            print(visible_password);
                          });
                        }, icon:(visible_password)?Icon(Icons.visibility_off_outlined,color: Colors.blueGrey):Icon(Icons.visibility_outlined,color: Colors.blueGrey)),

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
                  padding: const EdgeInsets.all( 10),
                  child: TextFormField(
                    validator: (val){
                      if ( val!.isEmpty){
                        return 'field required';
                      }
                      return null;
                    },
                    controller: confirm_passwordctrl,
                    obscureText: visible_confirmpassword,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            visible_confirmpassword=!visible_confirmpassword;
                          });
                        },
                            icon:(visible_confirmpassword) ? Icon(Icons.visibility_off_outlined,color: Colors.blueGrey,) :Icon(Icons.visibility_outlined,color: Colors.blueGrey)
                        ),
                        filled: true,
                        fillColor:Colors.white,
                        hintText: 'Confirm Password',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,

                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Container(
                    height: 45,
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            backgroundColor: Colors.blueGrey),
                        onPressed: (){
                          print(namectrl.text);
                          print(mobile_noctrl.text);
                          print(passwordctrl.text);
                          if (_registerkey.currentState!.validate()) {
                            if (passwordctrl.text==confirm_passwordctrl.text) {
                              senddata();
                            }
                            else
                            {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password Incorrect')));
                            }
                          }
                        }, child:  Text('Sign UP',style: GoogleFonts.alexandria(fontSize: 20),),),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an Account? ',style: TextStyle(color: Colors.black),),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
                    }, child: Text('LogIn',style: TextStyle(color: Colors.blueGrey),))
                  ],
                ),


              ],
            ),
          ),
        ),

      ),
    );
  }
}
