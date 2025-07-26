import 'package:flutter/material.dart';
import 'package:scmp_mobile_assg/widgets/home/components/staff_list_item/staff_default_icon.dart';

class StaffAvatarNetworkImage extends StatelessWidget {
  const StaffAvatarNetworkImage({
    super.key,
    required this.avatar,
  });

  final String avatar;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      avatar,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => StaffDefaultIcon(),
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        if (frame == null) return StaffDefaultIcon();
        return child;
      },
    );
  }
}
