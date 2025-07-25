import 'package:flutter/material.dart';
import 'package:scmp_mobile_assg/helpers/exception_helper.dart';
import 'package:scmp_mobile_assg/widgets/login/login_page_view_model.dart';

class LoginErrorDialog extends StatelessWidget {
  const LoginErrorDialog({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Login Error'),
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
