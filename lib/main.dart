import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/providers/task_provider.dart';
import 'package:taskmanager/task_manager_home_page.dart';

void main() {
  // runApp(const MyApp());

  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) =>TaskProvider()),
          ],
          child: MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskManagerHomePage(),
    );
  }
}