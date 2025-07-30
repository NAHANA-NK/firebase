import 'package:firebase/models/task_model.dart';
import 'package:firebase/services/task_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class addtaskview extends StatefulWidget {
  final TaskModel? task;
  const addtaskview({super.key,this.task});

  @override
  State<addtaskview> createState() => _addtaskviewState();
}

class _addtaskviewState extends State<addtaskview> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TaskService _taskService=TaskService();



   bool _edit=false;


 @override
  void dispose() {


    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  loadData(){
   if(widget.task!=null){
     setState(() {
       _titleController.text=widget.task!.title!;
       _descController.text=widget.task!.body!;
       _edit=true;
     });
   }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }


  final _taskKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _taskKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            _edit==true?  Text(
                "Update Task",
                style: themedata.textTheme.displayMedium,
              ):Text(
              "Add new Task",
              style: themedata.textTheme.displayMedium,
            ),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                height: 3,
                color: Colors.teal,
                endIndent: 50,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: themedata.textTheme.displaySmall,
                controller: _titleController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "title is mandatory";
                  }
                },
                cursorColor: Colors.teal,
                decoration: InputDecoration(
                  hintText: "Entertask title",
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
                controller: _descController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "description is mandatory";
                  }
                },
                cursorColor: Colors.teal,
                decoration: InputDecoration(
                  hintText: "Enter task description",
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
              Center(
                child: GestureDetector(
                  onTap: () {
                    if (_taskKey.currentState!.validate()) {
                     if(_edit){
                       TaskModel _taskmodel=TaskModel(
                         id: widget.task?.id,
                         title: _titleController.text,
                         body: _descController.text,
                         status: widget.task!.status,
                         createdAt: widget.task!.createdAt                       );
                       _taskService.updateTask(_taskmodel).then((value)=>Navigator.pop(context));
                     }else{_addTask();

                     }
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
                      child: _edit==true?Text(
                        "update task",
                        style: themedata.textTheme.displayMedium,
                      ):Text(
                        "Add new task",
                        style: themedata.textTheme.displayMedium,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _addTask()  async{
    var id = Uuid().v1();

    TaskModel _taskModel = TaskModel(
        title: _titleController.text,
        body: _descController.text,
        id: id,
        status: 1,
        createdAt: DateTime.now());


    final task= await _taskService.createTask(_taskModel);


    if(task!=null){
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Task Created")));
    }
  }
}
