import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user_model.dart';

Future<List<User>> fetchUsers(int page) async {
  final response = await http.get(Uri.parse('https://reqres.in/api/users?page=$page'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final List<User> users = (data['data'] as List).map((user) => User.fromJson(user)).toList();
    return users;
  } else {
    throw Exception('Failed to load users');
  }
}
