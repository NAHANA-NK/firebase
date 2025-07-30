import 'package:firebase/screens/add_task_page.dart';
import 'package:firebase/screens/login_page.dart';
import 'package:firebase/screens/register_page.dart';
import 'package:firebase/screens/splashpage.dart';
import 'package:firebase/screens/todo_home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: "/" ,
      routes: {
        '/':(context)=>  loginview(),
        '/register':(context)=>registerview(),
        '/home':(context)=>todohomepage(),
        '/addtask':(context)=>addtaskview(),
        '/splash':(context)=>splashview(),

      },
      theme: ThemeData(


        textTheme: TextTheme(
          displayMedium: TextStyle(
            color: Colors.white,
            fontSize: 18,

          ),
          displaySmall: TextStyle(
            color: Colors.white70,fontSize: 14,
          )
        ),
        
        scaffoldBackgroundColor: Color(0xff0E1D3E),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xff0E1D3E),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

    );
  }
}
