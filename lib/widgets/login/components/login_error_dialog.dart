import 'package:flutter/material.dart';

class LoginErrorDialog extends StatelessWidget {
  const LoginErrorDialog({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Login Failed'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('OK'),
        ),
      ],
    );
  }
}
