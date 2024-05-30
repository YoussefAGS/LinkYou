import 'package:flutter/material.dart';
import 'package:linkyou/core/extensions/context_extension.dart';
import 'package:linkyou/core/routes/app_route.dart';

import '../../../../core/common/animations/animate_do.dart';
import '../../../auth/data/datasources/auth_method.dart';
import '../../data/datasourec/Api.dart';
import '../../data/model/user_model.dart';

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  int currentPage = 1;
  List<User> users = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchMoreUsers();
  }

  Future<void> fetchMoreUsers() async {
    if (isLoading) return;
    setState(() => isLoading = true);

    final newUsers = await fetchUsers(currentPage);
    setState(() {
      currentPage++;
      users.addAll(newUsers);
      isLoading = false;
    });
  }

  final AuthMethods _authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        actions: [
          IconButton(
              onPressed: () {
                _authMethods.signOut();
                context.pushReplacementNamed(AppRoute.login);
              },
              icon: Icon(Icons.logout)
          )
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            fetchMoreUsers();
          }
          return false;
        },
        child: ListView.builder(
          itemCount: users.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == users.length) {
              return Center(child: CircularProgressIndicator());
            }
            final user = users[index];
            return CustomFadeInRight(
              duration: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    leading: Image.network(user.avatar),
                    title: Text('${user.firstName} ${user.lastName}'),
                    subtitle: Text(user.email),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
