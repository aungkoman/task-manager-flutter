

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  // data repo
  List<Task> taskList = [
    Task(id: "1", name: "one", status: "pending"),
    Task(id: "2", name: "two", status: "pending"),
    Task(id: "3", name: "three", status: "done"),
    Task(id: "4", name: "four", status: "pending"),
    Task(id: "5", name: "five", status: "pending"),
  ];


  // methods
  void selectTask()async{
    String url = "https://646996a003bb12ac208f243e.mockapi.io/api/v1/task";
    print("GET request to $url");
    http.Response response = await http.get(Uri.parse(url));
    print("status code is ${response.statusCode}");
    print("response.body  is ${response.body}");

    List<dynamic> responseBody = jsonDecode(response.body) ;
    print(responseBody);

    print(responseBody.length);
    for(int i=0; i < responseBody.length; i++){
      dynamic item = responseBody[i];
      Task task = Task(id: item['id'], name: item['name'], status: item['status']);
      taskList.add(task);
    }
    notifyListeners();
  }

  void addTask({required Task task}) async{

    // server
    String url = "https://646996a003bb12ac208f243e.mockapi.io/api/v1/task";
    Map<String, String> header = {
      "Content-Type" : "application/x-www-form-urlencoded"
    };
    Map<String, String> body = {
      "name" : task.name,
      "status" : task.status
    };
    http.Response response = await  http.post(Uri.parse(url), body: body, headers: header);
    print("status code is ${response.statusCode}");
    print("response.body  is ${response.body}");

    String responseText = response.body;
    dynamic responseObj = jsonDecode(responseText);
    String id = responseObj["id"];
    task.id  = id;
    taskList.add(task);
    notifyListeners();
  }

  void updateTask({required Task task}){
    for(int i=0; i< taskList.length; i++){
      if(taskList[i].id == task.id){
        taskList[i] = task;
      }
    }
    notifyListeners();
  }
}