import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class splashview extends StatefulWidget {
  const splashview({super.key});

  @override
  State<splashview> createState() => _splashviewState();
}

class _splashviewState extends State<splashview> {

  String?name;
  String?email;
  String?uid;
  String?token;

  getData() async{
    SharedPreferences _pref=await SharedPreferences.getInstance();
    token= await _pref.getString('token');
    email= await _pref.getString('name');
    uid= await _pref.getString('uid');
    name= await _pref.getString('name');

    

  }


  @override
  void iniState(){
    getData();
    var d = Duration(seconds: 2);
    Future.delayed(d, (){
      checkLoginStatus();
    });

    super.initState();
  }

  Future<void>checkLoginStatus() async{
    if (token==null) {
      Navigator.pushNamed(context, "/");
    }else{
      Navigator.pushNamed(context, "/home");
    }
  }



  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("ToDo App",style: TextStyle(color: Colors.white,fontSize: 30),),
      ),
    );
  }
}
