import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class loginview extends StatefulWidget {
  const loginview({super.key});

  @override
  State<loginview> createState() => _loginviewState();
}

class _loginviewState extends State<loginview> {

  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();

  final _loginKey=GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    final themedata=Theme.of(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Form(
          key: _loginKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("login to your account",style: themedata.textTheme.displayMedium,),
          SizedBox(
            height: 20,
          ),
              TextFormField(
                style: themedata.textTheme.displaySmall,
                controller: _emailController,
                validator: (value){
                  if(value!.isEmpty){
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
SizedBox(height: 10,),
              TextFormField(
                style: themedata.textTheme.displaySmall,
                controller: _passwordController,
                obscureText: true,
                validator: (value){
                  if(value!.isEmpty){
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
              SizedBox(height: 10,),

              InkWell(
                onTap: () async {
               if (_loginKey.currentState!.validate()){


                 _login();
               }

                },
                child: Container(
                  height: 48,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: Text("Login",style: themedata.textTheme.displayMedium,),),

                ),
              ),
              SizedBox(height: 50,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an Account?",style: themedata.textTheme.displaySmall,),
                  SizedBox(width: 10,),
                  InkWell(

                    onTap: (){
                      Navigator.pushNamed(context, '/register');
                    },


                      child: Text("Create Now",style: themedata.textTheme.displayMedium,))
                ],
              )


            ],
          ),
        ),
      ),
    );



  }

  _login() async {
    UserCredential userdata =  await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());
    if (userdata!=null){
      Navigator.pushNamedAndRemoveUntil(context, "/home",(route)  => false);
    }
  }
}
