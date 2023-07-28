import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'models/task.dart';

class OurDB{
  Future<Database> connectToDB() async {
    final database = openDatabase(
        join(await getDatabasesPath(), 'hello_db.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE tasks (id TEXT, name TEXT, status TEXT)',
          );
        },
        version: 1,
    );
    return database;
  }

  Future<void> insertTask({required Task task}) async{
    Database db = await connectToDB();
    db.insert("tasks", {
      "id" : task.id,
      "name" : task.name,
      "status" : task.status
    });
  }

  Future<List<Task>> selectTasks() async{
    Database db = await connectToDB();
    List<Map<String, dynamic>> resultRows =  await db.query("tasks"); // SELECT * FROM tasks;
    List<Task> taskList = [];
    for(int i=0; i< resultRows.length; i++){
      Task task = Task(
          id: resultRows[i]["id"],
          name: resultRows[i]["name"],
          status: resultRows[i]["status"]
      );
      taskList.add(task);
    }
    return taskList;
  }
}