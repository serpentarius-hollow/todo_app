import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/todo_bloc.dart';
import 'home_page.dart';
import 'todo_datasource.dart';
import 'todo_observer.dart';
import 'todo_repository.dart';

void main() {
  Bloc.observer = TodoObserver();

  runApp(BlocProvider(
    create: (context) =>
        TodoBloc(TodoRepositoryImplementation(TodoDatasource())),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
