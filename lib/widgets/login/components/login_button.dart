import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          padding: const EdgeInsets.symmetric(vertical: 12.0),
        ),
      onPressed: onPressed,
      child: Text(
        'Login',
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 16.0),
      ),
      ),
    );
  }
}