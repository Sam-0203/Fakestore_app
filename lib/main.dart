import 'package:fakestore/controller/cart.dart';
import 'package:fakestore/controller/product_provider.dart';
import 'package:fakestore/core/utils/token_save.dart';
import 'package:fakestore/view/authentication/login_screen.dart';
import 'package:fakestore/view/home/home_scree.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

// ── Splash Screen ────────────────────────────────────────────────────────────
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkTokenAndNavigate();
  }

  Future<void> _checkTokenAndNavigate() async {
    // Small delay so splash is visible
    await Future.delayed(const Duration(seconds: 2));

    final String? token = await SaveToken.getToken();
    final String? userName = await SaveToken.getUserName();
    final int? userId = await SaveToken.getUserId();
    debugPrint('User Token: $token');
    debugPrint('User userName: $userName');
    debugPrint('User userId: $userId');

    if (!mounted) return; // safety check before navigating

    final destination = (token != null && token.isNotEmpty)
        ? const HomeScreen()
        : const LoginiScreen();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => destination),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Replace with your logo if you have one
            Icon(Icons.store_rounded, size: 80, color: Colors.green),
            SizedBox(height: 16),
            Text(
              'Fakestore',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: 32),
            CircularProgressIndicator(color: Colors.green, strokeWidth: 2.5),
          ],
        ),
      ),
    );
  }
}
