import 'package:flutter/material.dart';
import 'package:scmp_mobile_assg/widgets/home/home_page.dart';
import 'package:scmp_mobile_assg/widgets/login/components/login_button.dart';
import 'package:scmp_mobile_assg/widgets/login/components/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16.0,
            children: [
              LoginForm(formKey: _formKey, 
                onEmailChanged: (value) {
                  debugPrint('Email changed: $value'); // TODO: Implement email change logic
                },
                onPasswordChanged: (value) {
                  debugPrint('Password changed: $value'); // TODO: Implement password change logic
                },
              ),
              LoginButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    debugPrint(
                      'Login successful',
                    ); // TODO: Implement login logic
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
