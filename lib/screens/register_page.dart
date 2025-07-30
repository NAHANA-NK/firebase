import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/models/user_model.dart';
import 'package:firebase/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class registerview extends StatefulWidget {
  const registerview({super.key});

  @override
  State<registerview> createState() => _registerviewState();
}

class _registerviewState extends State<registerview> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();






  UserModel _userModel=UserModel();
  AuthService _authService=AuthService();

  final _registerkey = GlobalKey<FormState>();



  bool _isLoading=false;

  void _register() async {
    setState(() {
      _isLoading=true;
    });




    _userModel=UserModel(
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      status: 1,
      createdAt: DateTime.now(),
    );


    try{
      await Future.delayed(Duration(seconds:3));
      final useData = await _authService.registerUser(_userModel);


      if (useData!=null){
        Navigator.pushNamedAndRemoveUntil(
             context, '/home', (route) => false);
      }
    }on FirebaseAuthException catch(e){
      setState(() {
        _isLoading=false;
      });
      List err=  e.toString().split("]");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err[1])));
    }

  }

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            Form(
              key: _registerkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Create an  account",
                    style: themedata.textTheme.displayMedium,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: themedata.textTheme.displaySmall,
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter an email id";
                      }
                    },
                    cursorColor: Colors.teal,
                    decoration: InputDecoration(
                      hintText: "Enter Email",
                      hintStyle: themedata.textTheme.displaySmall,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: themedata.textTheme.displaySmall,
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password id mandatory";
                      }
                    },
                    cursorColor: Colors.teal,
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      hintStyle: themedata.textTheme.displaySmall,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: themedata.textTheme.displaySmall,
                    controller: _nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter your name";
                      }
                    },
                    cursorColor: Colors.teal,
                    decoration: InputDecoration(
                      hintText: "Enter name",
                      hintStyle: themedata.textTheme.displaySmall,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      if (_registerkey.currentState!.validate()) {

                        _register();
                        // UserCredential UserData = await FirebaseAuth.instance
                        //     .createUserWithEmailAndPassword(
                        // email: _emailController.text.trim(),
                        // password: _passwordController.text.trim());
                        // if (UserData != null) ;
                        // FirebaseFirestore.instance
                        //     .collection('users')
                        //     .doc(UserData.user!.uid)
                        //     .set({
                        // 'uid': UserData.user!.uid,
                        // 'email': UserData.user!.email,
                        // 'name': _nameController.text,
                        // 'CreatedAt': DateTime.now(),
                        // 'status': 1
                        // }).then((value) => Navigator.pushNamedAndRemoveUntil(
                        // context, '/home', (route) => false));
                        // }




                      }
                    },
                    child: Container(
                      height: 48,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Create Account",
                          style: themedata.textTheme.displayMedium,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "already have an Account?",
                        style: themedata.textTheme.displaySmall,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "login",
                            style: themedata.textTheme.displayMedium,
                          ))
                    ],
                  )
                ],
              ),
            ),

            Visibility(
                visible: _isLoading,
                child: Center(child: CircularProgressIndicator(),)),
          ],
        ),
      ),
    );
  }
}
