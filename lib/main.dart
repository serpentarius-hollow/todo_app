import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/notification/notification_bloc.dart';
import 'package:todo_app/notification_service.dart';

import 'bloc/todo/todo_bloc.dart';
import 'login_page.dart';
import 'todo_datasource.dart';
import 'todo_observer.dart';
import 'todo_repository.dart';

void main() {
  Bloc.observer = TodoObserver();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) =>
            TodoBloc(TodoRepositoryImplementation(TodoDatasource())),
      ),
      BlocProvider(
        create: (context) => NotificationBloc(
            BlocProvider.of<TodoBloc>(context), NotificationService()),
      ),
    ],
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
      home: LoginPage(),
    );
  }
}
