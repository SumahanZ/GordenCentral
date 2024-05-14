import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/models/internal.dart';
import 'package:tugas_akhir_project/utils/extensions/string_extension.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';

class SettingTopSectionInternal extends ConsumerWidget {
  final Internal internal;
  const SettingTopSectionInternal({super.key, required this.internal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      elevation: 5,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 5.w),
                internal.profilePhotoURL == null
                    ? CircleAvatar(
                        radius: 22.r,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child:
                            Image.network(internal.profilePhotoURL ?? "", width: 44.w),
                      ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      internal.user?.name ?? "No name",
                      style: appStyle(
                          size: 12, color: Colors.black, fw: FontWeight.w600),
                    ),
                    Text("#${internal.userCode ?? "No code"}",
                        style: appStyle(
                            size: 12, color: Colors.black, fw: FontWeight.w500))
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                        (internal.toko != null && internal.status != "pending")
                            ? internal.toko!.name ?? "Belum join toko"
                            : "Belum join toko",
                        style: appStyle(
                            size: 12,
                            color: Colors.black,
                            fw: FontWeight.w600)),
                    Text((internal.role ?? "No role").toCapitalized(),
                        style: appStyle(
                            size: 12, color: Colors.black, fw: FontWeight.w500))
                  ],
                ),
                SizedBox(width: 5.w),
              ],
            ),
            SizedBox(height: 15.h),
            ElevatedButton(
              onPressed: () {
                Routemaster.of(context).push('/internal-account/edit-profile');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                "Edit Profile",
                style: appStyle(
                    size: 14, color: Colors.white, fw: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
