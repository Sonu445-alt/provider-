
import 'package:flutter/material.dart';
import '../model/student_model.dart';

class StudentViewModel extends ChangeNotifier {

  List<StudentModel> _students = [];

  List<StudentModel> get students => _students;

  void addStudent(String name, String course) {

    if (name.trim().isEmpty || course.trim().isEmpty) {
      return;
    }

    final student = StudentModel(
      id: DateTime.now().millisecondsSinceEpoch,
      name: name.trim(),
      course: course.trim(),
    );

    _students = [..._students, student];

    notifyListeners();
  }

  void deleteStudent(int id) {

    _students = _students
        .where((student) => student.id != id)
        .toList();

    notifyListeners();
  }
}
