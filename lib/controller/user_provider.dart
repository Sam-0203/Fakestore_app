import 'package:fakestore/model/user/user_details.dart';
import 'package:fakestore/model/user/users.dart';
import 'package:fakestore/service/user_services.dart';
import 'package:fakestore/core/utils/token_save.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final UserService userService = UserService();

  // current user
  UserModel? _currentUser;
  int? _currentUserId;

  SingleUserModel? _singleUserDetails;

  List<UserModel> _allUsers = [];
  bool _isLoading = false;

  String? _token;

  List<UserModel> get allUsers => _allUsers;
  bool get isLoading => _isLoading;

  // current user
  UserModel? get currentUser => _currentUser;

  int? get currentUserId => _currentUserId;
  SingleUserModel? get singleUser => _singleUserDetails;

  // login function
  bool getCurrentUser(String username, String password) {
    for (var user in _allUsers) {
      if (user.username == username && user.password == password) {
        _currentUser = user;

        _currentUserId = user.id;

        /// SAVE USER DATA
        SaveToken.saveUserId(user.id);

        SaveToken.saveUserName('${user.name.firstname} ${user.name.lastname}');
        print('Saved User Name : ${user.name.firstname} ${user.name.lastname}');

        print('Saved User ID : ${user.id}');

        notifyListeners();

        return true;
      }
    }

    return false;
  }

  // fetch all users
  Future<void> fetchAllUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      _allUsers = await userService.fetchUsers();
    } catch (e) {
      print('Error fetching users: $e');
    }

    _isLoading = false;
    notifyListeners();
    print('Fetched ${allUsers.length} users');
  }

  // User login
  Future<bool> login({
    required String username,
    required String password,
  }) async {
    _isLoading = true;

    notifyListeners();

    try {
      final responseToken = await userService.userLogin(
        username: username,
        password: password,
      );

      if (responseToken != null) {
        _token = responseToken;

        // save token
        await SaveToken.saveToken(_token!);

        print('Token : $_token');

        return true;
      }
    } catch (e) {
      print('Login Error : $e');
    }
    _isLoading = false;
    notifyListeners();

    return false;
  }

  // fetch single user details
  Future<void> fetchSingleUserDetails(int _currentUserId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _singleUserDetails = await userService.fechingsingleUser(_currentUserId);
    } catch (e) {
      print('Error fetching Single User: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
