import 'package:flutter/material.dart';

class StaffListEmptyItem extends StatelessWidget {
  const StaffListEmptyItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: EdgeInsetsGeometry.all(22),
        child: Column(
          spacing: 16.0,
          children: [
            CircleAvatar(
              radius: 45.0,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(
                Icons.search,
                size: 45,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            Text('Staff not found. Please pull down to refresh.',
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
