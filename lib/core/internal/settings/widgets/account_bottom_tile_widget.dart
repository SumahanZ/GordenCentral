import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/viewmodels/auth_viewmodel.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';

class AccountBottomTile extends ConsumerWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  final Color textColor;
  final bool isArrowDisabled;
  final String? routeDestination;
  const AccountBottomTile({
    super.key,
    required this.icon,
    required this.title,
    this.routeDestination,
    required this.iconColor,
    required this.textColor,
    this.isArrowDisabled = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        if (isArrowDisabled == false) {
          Routemaster.of(context).push(routeDestination!);
        } else {
          ref.read(authViewModelProvider.notifier).logOut();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
        child: Row(
          children: [
            SizedBox(width: 5.w),
            Icon(
              icon,
              color: iconColor,
            ),
            SizedBox(width: 20.w),
            Text(
              title,
              style: appStyle(size: 14, color: textColor, fw: FontWeight.w500),
            ),
            const Spacer(),
            if (!isArrowDisabled) const Icon(Icons.chevron_right_rounded),
          ],
        ),
      ),
    );
  }
}
