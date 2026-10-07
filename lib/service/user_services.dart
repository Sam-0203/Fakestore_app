import 'dart:convert';

import 'package:fakestore/core/constant/api_urls.dart';
import 'package:fakestore/model/user/user_details.dart';
import 'package:fakestore/model/user/users.dart';
import 'package:http/http.dart' as http;

class UserService {
  List<UserModel> users = [];

  // fetching all users
  Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(Uri.parse(APIUrls.users));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<UserModel>.from(data.map((user) => UserModel.fromJson(user)));
    } else {
      throw Exception('Failed to load users');
    }
  }

  // User login
  Future<String?> userLogin({
    required String username,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse(APIUrls.login),

      headers: {'Content-Type': 'application/json'},

      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);

      print('Login Response : $data');

      return data['token'];
    } else {
      throw Exception('Login failed');
    }
  }

  // Single user details
  Future<SingleUserModel> fechingsingleUser(int id) async {
    final response = await http.get(Uri.parse('${APIUrls.singleUser}$id'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      SingleUserModel userDetails = SingleUserModel.fromJson(data);

      print('Single user details: $userDetails');

      return userDetails;
    } else {
      throw Exception('Failed to load User details');
    }
  }
}
