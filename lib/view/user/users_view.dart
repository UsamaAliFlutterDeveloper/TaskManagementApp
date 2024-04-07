// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagerapp/const/colors/colors.dart';
import 'package:taskmanagerapp/const/style/styles.dart';
import 'package:taskmanagerapp/controller/task/task_controller.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaskController>(context, listen: false)
        .fetchUsers(1); // Fetch first page initially
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<TaskController>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kOrangeColor,
        title: Text(
          'User List - Page ${userProvider.currentPage}',
          style:
              kmyTS14(size: 18.sp, color: kwhiteColor, weight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: userProvider.users.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: userProvider.users.length,
              itemBuilder: (context, index) {
                final user = userProvider.users[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.avatar),
                  ),
                  title: Text('${user.firstName} ${user.lastName}'),
                  subtitle: Text(user.email),
                );
              },
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
                if (userProvider.currentPage > 1) {
                  userProvider.fetchUsers(userProvider.currentPage - 1);
                }
              },
            ),
            Text(
              "${userProvider.currentPage}",
              style: kmyTS14(
                  color: kblackColor, size: 24.sp, weight: FontWeight.w600),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                userProvider.fetchUsers(userProvider.currentPage + 1);
              },
            ),
          ],
        ),
      ),
    );
  }
}
