// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagerapp/const/colors/colors.dart';
import 'package:taskmanagerapp/const/style/styles.dart';
import 'package:taskmanagerapp/controller/signup/sign_up_controller.dart';
import 'package:taskmanagerapp/controller/task/task_controller.dart';
import 'package:taskmanagerapp/model/task/task_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<TaskController>(context, listen: false).fetchTasks(1);
  }

  @override
  Widget build(BuildContext context) {
    final taskcontroller = Provider.of<TaskController>(context);
    final signUpcontroller = Provider.of<SignupController>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kOrangeColor,
        centerTitle: true,
        title: Text(
          'Task Manager Page ${taskcontroller.currentPaged}',
          style: kmyTS14(size: 18.sp),
        ),
        actions: [
          IconButton(
              onPressed: () {
                signUpcontroller.logout(context);
              },
              icon: Icon(
                Icons.logout,
                color: kwhiteColor,
                size: 25.r,
              ))
        ],
      ),
      body: Consumer<TaskController>(
        builder: (context, taskProvider, _) {
          if (taskProvider.tasks.isEmpty) {
            return const Center(
              child: Text('No Task Added Add The Task By Using Add Button'),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                final task = taskProvider.tasks[index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Edit Task'),
                            content: TextField(
                              controller:
                                  TextEditingController(text: task.title),
                              onChanged: (value) {
                                setState(() {
                                  task.title = value;
                                });
                              },
                              decoration: const InputDecoration(
                                  hintText: 'Enter task title'),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Update the task
                                  Provider.of<TaskController>(context,
                                          listen: false)
                                      .updateTask(task);
                                  Navigator.pop(context);
                                },
                                child: const Text('Save'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    title: Text(task.title ?? ''),
                    subtitle: const Text('edit task'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        taskProvider.deleteTask(task.id!);
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add Task'),
                content: TextField(
                  controller: _taskController,
                  decoration:
                      const InputDecoration(hintText: 'Enter task title'),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      final taskTitle = _taskController.text.trim();
                      if (taskTitle.isNotEmpty) {
                        final newTask = TaskModel(
                            id: DateTime.now().millisecondsSinceEpoch,
                            title: taskTitle);
                        Provider.of<TaskController>(context, listen: false)
                            .addTask(newTask);
                        _taskController.clear();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: kwhiteColor,
        color: kwhiteColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                if (taskcontroller.currentPaged > 1) {
                  taskcontroller.fetchUsers(taskcontroller.currentPaged - 1);
                }
              },
            ),
            Text(
              "${taskcontroller.currentPaged}",
              style: kmyTS14(
                  color: kblackColor, size: 24.sp, weight: FontWeight.w600),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                taskcontroller.fetchTasks(taskcontroller.currentPaged + 1);
              },
            ),
          ],
        ),
      ),
    );
  }
}
