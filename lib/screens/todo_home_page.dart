import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/models/task_model.dart';
import 'package:firebase/services/auth_service.dart';
import 'package:firebase/services/task_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'add_task_page.dart';

class todohomepage extends StatefulWidget {
  const todohomepage({super.key});

  @override
  State<todohomepage> createState() => _todohomepageState();
}

class _todohomepageState extends State<todohomepage> {

  TaskService _taskService=TaskService();
  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.pushNamed(context, '/addtask');
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
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
                      Text(
                        "hi",
                        style: themedata.textTheme.displayMedium,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "jobin",
                        style: themedata.textTheme.displayMedium,
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  child: IconButton(
                    onPressed: () {
                      final user = FirebaseAuth.instance.currentUser;
                      AuthService().logout().then(
                        (Value) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/", (route) => false);
                        },
                      );
                    },
                    icon: Icon(Icons.logout),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "your to-dos",
              style: themedata.textTheme.displayMedium,
            ),
            SizedBox(
              height: 15,
            ),


            StreamBuilder<List<TaskModel>>(
                stream:_taskService.getAllTasks(),
                builder: (context,snapshot){


                 if(snapshot.connectionState==ConnectionState.waiting){

                   return Center(
                     child: CircularProgressIndicator(),
                   );

                 }

                 if (snapshot.hasError){
                   return Center(
                     child: Text("some error occured",style: themedata.textTheme.displaySmall,),
                   );
                 }

                 if (snapshot.hasData && snapshot.data!.length==0){
                   return Center(
                     child: Text("no tasks added",style: themedata.textTheme.displaySmall,),
                   );
                 }


                   if(snapshot.hasData && snapshot.data!.length!=0){


                     List<TaskModel> tasks=snapshot.data??[];

                     return  ListView.builder(
                       shrinkWrap: true,
                       itemCount: snapshot.data!.length,
                       itemBuilder: (context, index) {


              final _task=tasks[index];
                        print(_task);

                         return Card(
                           elevation: 5.0,
                           color: themedata.scaffoldBackgroundColor,
                           child: ListTile(
                             leading: CircleAvatar(
                               backgroundColor: Colors.transparent,
                               child: Icon(
                                 Icons.circle_outlined,
                                 color: Colors.white,
                               ),
                             ),
                             title: Text(
                               "${_task.title}",
                               style: themedata.textTheme.displaySmall,
                             ),
                             subtitle: Text(
                               "${_task.body}",
                               style: themedata.textTheme.displaySmall,
                             ),
                             trailing: Container(
                               width: 100,
                               child: Row(
                                 children: [
                                   IconButton(
                                     onPressed: () {


                                       Navigator.push(context, MaterialPageRoute(builder: (context)=> addtaskview(task: _task,)));

                                     },
                                     icon: Icon(
                                       Icons.edit,
                                       color: Colors.teal,
                                     ),
                                   ),
                                   IconButton(
                                     onPressed: () {

                                       _taskService.deleteTask(_task.id);
                                     },
                                     icon: Icon(
                                       Icons.delete,
                                       color: Colors.red,
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ),
                         );
                       },
                     );
                   }

                   return Center(


                     child: Text("hello",style: themedata.textTheme.displaySmall,),
                   );




                }
            ),



            



          ],
        ),
      ),
    );
  }
}
