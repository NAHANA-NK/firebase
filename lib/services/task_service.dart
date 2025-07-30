import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/models/task_model.dart';
import 'package:flutter/cupertino.dart';



class TaskService{



  final CollectionReference _taskCollection=FirebaseFirestore.instance.collection('task');

  //create

Future<TaskModel?>createTask(TaskModel task)async{

  try{

    final taskMap=TaskModel().toMap();

   await _taskCollection.doc(task.id).set(taskMap);

   return task;



  }on FirebaseException catch (e){
    print(e.toString());
  }
}

//getalltask


Stream<List<TaskModel>> getAllTasks(){
  try {
    return _taskCollection.snapshots().map((QuerySnapshot snapshot) {
      return snapshot.docs.map((DocumentSnapshot doc) {
        return TaskModel.fromJson(doc);
      }).toList();
    });
  }on FirebaseException catch(e){
     print(e);
     throw(e);
      }
  }

  Future<void> updateTask(TaskModel task)async{
  
  try{
    final taskMap=task.toMap();
    await _taskCollection.doc(task.id).update(taskMap);
  }on FirebaseException catch(e){
    print(e.toString());
  }
  }






  Future<void>deleteTask(String? id)async{

  try{
    await _taskCollection.doc(id).delete();

  }on FirebaseException catch(e){
    print(e.toString());
  }
  }
}








