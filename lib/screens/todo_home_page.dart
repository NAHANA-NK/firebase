
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class todohomepage extends StatefulWidget {
  const todohomepage({super.key});

  @override
  State<todohomepage> createState() => _todohomepageState();
}

class _todohomepageState extends State<todohomepage> {
  @override
  Widget build(BuildContext context) {

    final themedata=Theme.of(context);
    return Scaffold(


      appBar: AppBar(),

    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.teal,
      onPressed:(){
        Navigator.pushNamed(context, '/addtask');
      },
      child: Icon(Icons.add,color: Colors.white,),
    ),

    
    body: Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("hi",style: themedata.textTheme.displayMedium,),
                    SizedBox(width: 10,),
                    Text("jobin",style: themedata.textTheme.displayMedium,),
                  ],
                ),
              ),
              CircleAvatar(
                
                child: IconButton(onPressed: () {
                  final user = FirebaseAuth.instance.currentUser;
                  FirebaseAuth.instance.signOut().then((Value) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/", (route) => false);
                    print(user!.email);
                  },
                  );

                },icon: Icon(Icons.logout),),
              ),
            ],
          ),
          
          SizedBox(height:15 ,),

          Text("your to-dos",style: themedata.textTheme.displayMedium,),

          SizedBox(height:15 ,),   ListView.builder(
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (context,index){
              return Card(
                elevation: 5.0,
                color: themedata.scaffoldBackgroundColor,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Icon(Icons.circle_outlined,color: Colors.white,),
                  ),
                  title: Text("Todo one",style: themedata.textTheme.displaySmall,),
                  subtitle: Text("complete the assignment before 10 am tom",style: themedata.textTheme.displaySmall,),
                  trailing: Container(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                        onPressed: () {},
                    icon: Icon(Icons.edit,color: Colors.teal,),
                  ),



                        IconButton(onPressed: () {}, icon: Icon(Icons.delete,color: Colors.red,),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    ),
    );
  }
}
