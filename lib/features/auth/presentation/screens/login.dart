import 'package:flutter/material.dart';
import 'package:linkyou/core/extensions/context_extension.dart';
import '../../../../core/routes/app_route.dart';
import '../../data/datasources/auth_method.dart';
import '../wedgits/LoginButton.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthMethods _authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/core/background.jpg', // Ensure this image is added to your assets
            fit: BoxFit.cover,
          ),
          // Content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // App Logo or Title
                  Text(
                    'LinkYou',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50),
                  // Google Sign-In Button
                  LoginButton(
                    text: 'Sign in with Google',
                    onPressed: () async {
                      bool res = await _authMethods.signInWithGoogle(context);
                      if (res) {
                        context.pushReplacementNamed(AppRoute.home);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
