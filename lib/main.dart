import 'package:complete_todo_provider_db/database/local/db_helper.dart';
import 'package:complete_todo_provider_db/provider/todo_provider.dart';
import 'package:complete_todo_provider_db/screens/home_screen.dart';
import 'package:complete_todo_provider_db/screens/login_screen.dart';
import 'package:complete_todo_provider_db/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( ChangeNotifierProvider(create: (context){
    return TodoProvider(mainDb: DbHelper.getInstances);
  },child: MyApp(),));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
