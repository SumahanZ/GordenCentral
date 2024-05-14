import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tugas_akhir_project/models/toko.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class TokoInformationCard extends ConsumerWidget {
  final Toko? toko;
  const TokoInformationCard(
    this.toko, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 20),
        child: Column(
          children: [
            Row(children: [
              toko?.profilePhotoURL != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(toko?.profilePhotoURL ?? "",
                          fit: BoxFit.contain, width: 90.w)

                      // Image.network(toko?.profilePhotoURL ?? "",
                      //     fit: BoxFit.contain, width: 90),
                      )
                  : CircleAvatar(radius: 45.r),
              SizedBox(width: 15.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      toko?.name ?? "Tidak Ada Nama",
                      style: appStyle(
                          size: 16, color: mainBlack, fw: FontWeight.w600),
                    ),
                    Text(
                      toko?.bio ?? "Tidak Ada Bio",
                      style: appStyle(
                          size: 13, color: mainBlack, fw: FontWeight.w500),
                    ),
                    Text(
                      toko?.address?.streetAddress ?? "Tidak Ada Alamat",
                      style: appStyle(
                          size: 13, color: mainBlack, fw: FontWeight.w500),
                    ),
                    Text(
                      "Nomor HP: ${toko?.whatsAppURL}",
                      style: appStyle(
                          size: 13, color: mainBlack, fw: FontWeight.w500),
                    ),
                  ],
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
