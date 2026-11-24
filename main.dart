
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_managment/view/student_view.dart';
import 'package:state_managment/viewmodel/student_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => StudentViewModel(),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MVVM Provider App',

        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        home: const StudentView(),
      ),
    );
  }
}
