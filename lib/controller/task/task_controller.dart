import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:taskmanagerapp/model/task/task_model.dart';
import 'package:http/http.dart' as http;

import '../../const/utils/utils.dart';
import '../../model/user/user_model.dart';

class TaskController with ChangeNotifier {
  List<TaskModel> _tasks = [];
  final int _currentPages = 1;
  int get currentPaged => _currentPages;
  List<TaskModel> get tasks => _tasks;

  Future<void> fetchTasks(int page) async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=$page'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final tasksJson = data['data'];
      _tasks = tasksJson
          .map<TaskModel>((taskJson) => TaskModel.fromJson(taskJson))
          .toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<void> addTask(TaskModel task) async {
    final response = await http.post(
      Uri.parse('https://reqres.in/api/users'),
      body: jsonEncode(task.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      Utils.toastMessage('task added successfully');
      _tasks.add(task);
      notifyListeners();
    } else {
      throw Exception('Failed to add task');
    }
  }

  Future<void> updateTask(TaskModel task) async {
    final response = await http.put(
      Uri.parse('https://reqres.in/api/users/${task.id}'),
      body: jsonEncode(task.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      Utils.toastMessage('task updated successfully');
      notifyListeners();
    } else {
      throw Exception('Failed to update task');
    }
  }

  Future<void> deleteTask(int taskId) async {
    final response =
        await http.delete(Uri.parse('https://reqres.in/api/users/$taskId'));
    if (response.statusCode == 204) {
      _tasks.removeWhere((task) => task.id == taskId);
      Utils.toastMessage('task deleted successfully');
      notifyListeners();
    } else {
      throw Exception('Failed to delete task');
    }
  }

  //........................fetch users...................//
  final List<User> _users = [];
  int _currentPage = 1;

  List<User> get users => _users;
  int get currentPage => _currentPage;

  Future<void> fetchUsers(int page) async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=$page'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final usersJson = data['data'];
      _users.clear();
      _users.addAll(
          usersJson.map<User>((userJson) => User.fromJson(userJson)).toList());
      _currentPage = page; // Update current page
      notifyListeners();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
