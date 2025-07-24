import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.onEmailChanged,
    required this.onPasswordChanged,
  });

  final GlobalKey<FormState> formKey;
  final Function(String) onEmailChanged;
  final Function(String) onPasswordChanged;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16.0,
        children: [
          Text(
            'Welcome',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
            onChanged: onEmailChanged,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
            keyboardType: TextInputType.visiblePassword,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
            onChanged: onPasswordChanged,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
