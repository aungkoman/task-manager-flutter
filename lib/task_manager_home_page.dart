import 'package:flutter/material.dart';

class TaskManagerHomePage extends StatefulWidget {
  const TaskManagerHomePage({Key? key}) : super(key: key);

  @override
  State<TaskManagerHomePage> createState() => _TaskManagerHomePageState();
}

class _TaskManagerHomePageState extends State<TaskManagerHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Manager"),
      ),
      body: _mainWidget(),
    );
  }

  Widget _mainWidget(){
    return Column(
      children: [
        _inputRow(),

        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) => _taskCard(),
              separatorBuilder: (context, index) => Divider(),
              itemCount: 10
          ),
        )
      ],
    );
  }

  Widget _inputRow(){
    return Row(
      children: [
        Expanded(child: TextFormField()),
        ElevatedButton(onPressed: (){}, child: Text("Create Task")),
      ],
    );
  }

  Widget _taskCard(){
    return Container(
      height: 50,
      color: Colors.green,
    );
  }
}
