import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scmp_mobile_assg/widgets/home/components/staff_list_item/staff_avatar_file_image.dart';
import 'package:scmp_mobile_assg/widgets/home/components/staff_list_item/staff_avatar_network_image.dart';
import 'package:scmp_mobile_assg/widgets/home/helpers/staff_avatar_image_helper.dart';

class StaffAvatarImage extends StatelessWidget {
  const StaffAvatarImage({super.key, required this.avatar});

  final String avatar;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.0,
      height: 90.0,
      child: ClipOval(
        child: isNetworkImage(avatar) ? StaffAvatarNetworkImage(avatar: avatar): StaffAvatarFileImage(avatar: avatar),
      ),
    );
  }
}
