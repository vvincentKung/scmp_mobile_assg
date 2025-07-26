import 'package:flutter/material.dart';
import 'package:scmp_mobile_assg/models/staff.dart';
import 'package:scmp_mobile_assg/widgets/home/components/staff_list_item/staff_list_empty_item.dart';
import 'package:scmp_mobile_assg/widgets/home/components/staff_list_item/staff_list_item.dart';

class StaffList extends StatelessWidget {
  final List<Staff> staffList;
  final ScrollController? scrollController;
  final bool hideLoadMoreIndicator;
  const StaffList({super.key, required this.staffList, this.scrollController, required this.hideLoadMoreIndicator});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 16.0,
        right: 16.0,
        bottom: 16.0,
      ),
      itemCount: staffList.length + 1,
      separatorBuilder: (context, index) => const SizedBox(height: 12.0),
      itemBuilder: (context, index) {
        if(staffList.isEmpty){
          return StaffListEmptyItem();
        }
        if (index >= staffList.length && hideLoadMoreIndicator) {
          return Container();
        }

        if (index >= staffList.length && !hideLoadMoreIndicator) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Text(
                'Load More',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          );
        }

        final staff = staffList[index];
        return StaffListItem(staff: staff);
      },
    );
  }
}
