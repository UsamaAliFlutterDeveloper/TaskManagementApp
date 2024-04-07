import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:taskmanagerapp/const/utils/utils.dart';
import 'dart:convert';

import 'package:taskmanagerapp/model/task/task_model.dart';

class ApiServices {
  static const baseUrl = 'https://reqres.in/api';

  static Future<Map<String, dynamic>> register(
      String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      log('Registration failed with status code: ${response.statusCode}');
      log('Response body: ${response.body}');
      throw Exception('Failed to register');
    }
  }

  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  Future<void> fetchTasks() async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final tasksJson = data['data'];
      _tasks = tasksJson
          .map<TaskModel>((taskJson) => TaskModel.fromJson(taskJson))
          .toList();
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
      _tasks.add(task);
      Utils.toastMessage('task uploaded successfully');
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
    } else {
      throw Exception('Failed to update task');
    }
  }

  Future<void> deleteTask(int taskId) async {
    final response =
        await http.delete(Uri.parse('https://reqres.in/api/users/$taskId'));
    if (response.statusCode == 200) {
      _tasks.removeWhere((task) => task.id == taskId);
      Utils.toastMessage('task deleted successfully');
    } else {
      throw Exception('Failed to delete task');
    }
  }
}
