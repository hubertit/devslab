import 'package:devslab/models/user.dart';
import 'package:devslab/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget{
  final User user;
  const AccountScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.user.name),
            Text(widget.user.id),
            TextButton(onPressed: (){
              showDialog(context: context, builder: (context){
                return AlertDialog(
                  title: Text("Sign Out"),
                  content: Text("re yo sure?"),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("Cancel")),
                    TextButton(onPressed: ()async{
                      Navigator.pop(context);
                      (await SharedPreferences.getInstance()).remove("user_value");
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=> const LoginScreen()));

                    }, child: const Text("Ok")),
                  ],
                );
              });
            }, child: const Text("Sign Out"))
          ],
        ),
      ),
    );
  }
}