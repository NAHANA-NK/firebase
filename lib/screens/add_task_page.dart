
import 'package:flutter/material.dart';

class addtaskview extends StatefulWidget {
  const addtaskview({super.key});

  @override
  State<addtaskview> createState() => _addtaskviewState();
}

class _addtaskviewState extends State<addtaskview> {

  TextEditingController _titleController=TextEditingController();
  TextEditingController _descController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themedata=Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("add task",style:themedata.textTheme.displayMedium,),
            const SizedBox(height: 5,),

            const Divider(height: 3,color: Colors.teal,
              endIndent: 50,
            ),
       const     SizedBox(height: 20,),


            TextFormField(
              style: themedata.textTheme.displaySmall,
              controller: _titleController ,
              validator: (value){
                if(value!.isEmpty){
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
            SizedBox(height: 10,),

            TextFormField(
              style: themedata.textTheme.displaySmall,
              controller: _descController ,
              validator: (value){
                if(value!.isEmpty){
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
            SizedBox(height: 20,),

            Center(
              child: Container(
                height: 48,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Text("add task",style: themedata.textTheme.displayMedium,),),

              ),
            ),

          ],
        ),
      ),
    );
  }
}
