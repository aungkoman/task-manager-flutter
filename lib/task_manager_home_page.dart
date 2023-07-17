import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/providers/task_provider.dart';

import 'models/task.dart';

class TaskManagerHomePage extends StatefulWidget {
  const TaskManagerHomePage({Key? key}) : super(key: key);

  @override
  State<TaskManagerHomePage> createState() => _TaskManagerHomePageState();
}

class _TaskManagerHomePageState extends State<TaskManagerHomePage> {

  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Manager"),
      ),
      body: _mainWidget(),
      floatingActionButton: _fab(),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).selectTask();
  }
  Widget _mainWidget(){
    return Column(
      children: [
        _inputRow(),

        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) => _taskCard(task: Provider.of<TaskProvider>(context, listen:true).taskList[index]),
              separatorBuilder: (context, index) => Divider(),
              itemCount: Provider.of<TaskProvider>(context, listen:true).taskList.length
          ),
        )
      ],
    );
  }

  Widget _inputRow(){
    return Row(
      children: [
        Expanded(
            child: TextFormField(
              controller: textEditingController,
            )
        ),
        ElevatedButton(onPressed: (){
          Task task = Task(id:"", name: textEditingController.text, status: "pending");
          Provider.of<TaskProvider>(context, listen: false).addTask(task: task);
        }, child: Text("Create Task")),
      ],
    );
  }

  Widget _taskCard({required Task task}){
    return Container(
      height: 50,
      color: Colors.green,
      child: Row(
        children: [
          Checkbox(
              value: task.status == "pending" ? false : true,
              onChanged: (checkboxStatus) {
                print("checkBoxStatus is $checkboxStatus");
                if(checkboxStatus == true){
                  task.status = "done";
                  Provider.of<TaskProvider>(context, listen: false).updateTask(task: task);
                }
                else{
                  task.status = "pending";
                  Provider.of<TaskProvider>(context, listen: false).updateTask(task: task);
                }
              }
          ),
          Expanded(child: Text(task.name)),
          IconButton(onPressed: (){
            Provider.of<TaskProvider>(context, listen: false).deleteTask(task: task);

          }, icon: Icon(Icons.delete, color: Colors.red,))
        ],
      ),
    );
  }

  Widget _fab(){
    return FloatingActionButton(
      onPressed: (){
        Provider.of<TaskProvider>(context, listen: false).selectTask();
      },
      child: Icon(Icons.refresh),
    );
  }
}
