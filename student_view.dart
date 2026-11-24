
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/student_viewmodel.dart';

class StudentView extends StatefulWidget {
  const StudentView({super.key});

  @override
  State<StudentView> createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {

  final nameController = TextEditingController();
  final courseController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    courseController.dispose();
    super.dispose();
  }

  void addStudent() {

    final name = nameController.text;
    final course = courseController.text;

    if (name.trim().isEmpty || course.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all details')),
      );
      return;
    }

    context.read<StudentViewModel>().addStudent(
      name,
      course,
    );

    nameController.clear();
    courseController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Student Added Successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student App'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Student Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: courseController,
              decoration: const InputDecoration(
                labelText: 'Course',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.book),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addStudent,
                child: const Text('Add Student'),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Consumer<StudentViewModel>(
                builder: (context, viewModel, child) {

                  if (viewModel.students.isEmpty) {
                    return const Center(
                      child: Text('No Students Found'),
                    );
                  }

                  return ListView.builder(
                    itemCount: viewModel.students.length,

                    itemBuilder: (context, index) {

                      final student =
                      viewModel.students[index];

                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(
                              student.name[0].toUpperCase(),
                            ),
                          ),

                          title: Text(student.name),

                          subtitle: Text(student.course),

                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),

                            onPressed: () {
                              viewModel.deleteStudent(
                                student.id,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
