import 'package:fakestore/view/home/home_scree.dart';
import 'package:fakestore/widgets/custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/user_provider.dart';

class LoginiScreen extends StatefulWidget {
  const LoginiScreen({super.key});

  @override
  State<LoginiScreen> createState() => _LoginiScreenState();
}

class _LoginiScreenState extends State<LoginiScreen> {
  final username = TextEditingController();
  final password = TextEditingController();

  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final provider = Provider.of<UserProvider>(context, listen: false);
      provider.fetchAllUsers();
    });
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TOP SECTION
                Center(
                  child: Container(
                    height: size.height * 0.18,
                    width: size.height * 0.18,
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                      size: 70,
                      color: Colors.green,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                /// TITLE
                Center(
                  child: const Text(
                    "Welcome Back 👋",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 35),

                /// USERNAME FIELD
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: username,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_outline),
                      hintText: 'Enter your username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// PASSWORD FIELD
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: password,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: GestureDetector(
                        onTap: () => setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        }),
                        child: Icon(
                          isPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                /// FORGOT PASSWORD
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                /// LOGIN BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: CustomButton(
                    text: 'Login',
                    color: Colors.green,

                    onPressed: () async {
                      final provider = Provider.of<UserProvider>(
                        context,
                        listen: false,
                      );

                      final success = await provider.login(
                        username: username.text,
                        password: password.text,
                      );

                      debugPrint('userName: ${username.text}');
                      debugPrint('password: ${password.text}');

                      if (success) {
                        /// SAVE CURRENT USER
                        provider.getCurrentUser(username.text, password.text);

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                          (route) => false,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Login successful!')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Invalid username or password.'),
                          ),
                        );
                      }
                    },
                  ),
                ),

                const SizedBox(height: 30),

                /// REGISTER
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
