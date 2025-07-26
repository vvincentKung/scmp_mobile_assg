import 'package:flutter/material.dart';
import 'package:scmp_mobile_assg/models/staff.dart';
import 'package:scmp_mobile_assg/widgets/home/components/staff_list_item/staff_avatar_image.dart';
import 'package:scmp_mobile_assg/widgets/home/components/staff_list_item/staff_information_box.dart';

class StaffListItem extends StatelessWidget {
  final Staff staff;
  const StaffListItem({super.key, required this.staff});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: EdgeInsetsGeometry.all(22),
        child: Column(
          spacing: 16.0,
          children: [
            StaffAvatarImage(avatar: staff.avatar,),
            StaffInformationBox(staff: staff),
          ],
        ),
      ),
    );
  }
}
