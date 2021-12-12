import 'dart:convert';

import 'package:devslab/base_class.dart';
import 'package:devslab/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with BaseClass{

  var key = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool loading = false;

  Future<void> logUserIn() async {
    setState(() {
      loading = true;
    });
    var response = await Dio(BaseOptions(
    )).post("${baseUrl}shop/login",data: FormData.fromMap({
      "shop_phone":_usernameController.text,
      "shop_password":_passwordController.text,
    }));
    print(response);
    if(response.statusCode == 200){

      if(response.data['code'] == 200){
        var user = User.fromJson(response.data['data']);
        (await SharedPreferences.getInstance()).setString("user_value", jsonEncode(response.data['data']));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=> const MyHomePage()));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${response.data['message']}")));
      }

    }else{

    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(key: key,
        child: ListView(
          padding: const EdgeInsets.all(10).copyWith(
            top: MediaQuery.of(context).padding.top
          ),
          children: [
            TextFormField(
              controller: _usernameController,
              validator: (value){
                return value!.isEmpty ? "Username is required" : null;
              },
              decoration: const InputDecoration(
                hintText: "Username"
              ),
            ),
            TextFormField(
              controller: _passwordController,
              validator: (value){
                return value!.isEmpty ? "Password is required" : value.length < 6 ? "Password length has to be greater than 6" : null;
              },
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password"
              ),
            ),

            loading ? Center(child: CupertinoActivityIndicator(),) : ElevatedButton(onPressed: (){
             var res = key.currentState?.validate() ?? false;
             if(res){
               logUserIn();
             }
            }, child: Text("Sign In"))
          ],
        ),
      ),
    );
  }
}