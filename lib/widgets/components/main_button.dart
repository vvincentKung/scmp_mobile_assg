import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({super.key, required this.onPressed, required this.title});

  final VoidCallback? onPressed;
  final String title;

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
        title,
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 16.0),
      ),
      ),
    );
  }
}