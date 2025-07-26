import 'package:flutter/material.dart';

class StaffDefaultIcon extends StatelessWidget {
  const StaffDefaultIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 45.0,
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Icon(
        Icons.person,
        size: 45,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
