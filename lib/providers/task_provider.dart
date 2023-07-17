

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  // data repo
  List<Task> taskList = [
    // Task(id: "1", name: "one", status: "pending"),
    // Task(id: "2", name: "two", status: "pending"),
    // Task(id: "3", name: "three", status: "done"),
    // Task(id: "4", name: "four", status: "pending"),
    // Task(id: "5", name: "five", status: "pending"),
  ];


  // methods
  Future<bool> selectTask()async{
    String url = "https://646996a003bb12ac208f243e.mockapi.io/api/v1/task";
    print("GET request to $url");
    http.Response response = await http.get(Uri.parse(url));
    print("status code is ${response.statusCode}");
    print("response.body  is ${response.body}");
    if(response.statusCode == 200){
      List<dynamic> responseBody = jsonDecode(response.body) ;
      print(responseBody);
      print(responseBody.length);
      taskList.clear();
      for(int i=0; i < responseBody.length; i++){
        dynamic item = responseBody[i];
        Task task = Task(id: item['id'], name: item['name'], status: item['status']);
        taskList.add(task);
      }
      notifyListeners();
      return true;
    }
    else{
      return false;
    }
  }

  Future<bool> addTask({required Task task}) async{

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

    if(response.statusCode == 201){
      String responseText = response.body;
      dynamic responseObj = jsonDecode(responseText);
      String id = responseObj["id"];
      task.id  = id;
      taskList.add(task);
      notifyListeners();
      return true;
    }
    else{
      return false;
    }


  }

  Future<bool> updateTask({required Task task}) async{
    for(int i=0; i< taskList.length; i++){
      if(taskList[i].id == task.id){
        String url = "https://646996a003bb12ac208f243e.mockapi.io/api/v1/task/" + task.id;
        Map<String, String> header = {
          "Content-Type" : "application/x-www-form-urlencoded"
        };
        Map<String, String> body = {
          "name" : task.name,
          "status" : task.status
        };
        http.Response response = await  http.put(Uri.parse(url), body: body, headers: header);
        if(response.statusCode == 200){
          taskList[i] = task;
          notifyListeners();
          return true;
        }
        else{
          return false;
        }
      }
    }
    return true;
  }


  Future<bool> deleteTask({required Task task}) async{
    String url = "https://646996a003bb12ac208f243e.mockapi.io/api/v1/task/" + task.id;
    http.Response response = await  http.delete(Uri.parse(url));
    if(response.statusCode == 200){
      taskList.removeWhere((element) => element.id == task.id);
      notifyListeners();
      return true;
    }
    else{
      return false;
    }

  }
}