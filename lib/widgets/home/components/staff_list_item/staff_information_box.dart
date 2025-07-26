import 'package:flutter/material.dart';
import 'package:scmp_mobile_assg/models/staff.dart';

class StaffInformationBox extends StatelessWidget {
  const StaffInformationBox({
    super.key,
    required this.staff,
  });

  final Staff staff;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${staff.firstName} ${staff.lastName}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        Text(
          staff.email,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
