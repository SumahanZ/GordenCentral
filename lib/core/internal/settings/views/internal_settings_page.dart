import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tugas_akhir_project/core/internal/settings/repositories/implementations/internal_settings_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/settings/widgets/account_bottom_tile_widget.dart';
import 'package:tugas_akhir_project/core/internal/settings/widgets/account_top_section_internal_widget.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class InternalAccountPage extends ConsumerWidget {
  const InternalAccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetchInternalInformationData = ref.watch(fetchInternalInformation);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Settings",
            style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: fetchInternalInformationData.maybeWhen(data: (data) {
            return data.match(
                (l) => Center(
                    child: Text(l.message,
                        style: appStyle(
                            size: 16,
                            color: mainBlack,
                            fw: FontWeight.w600))), (r) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SettingTopSectionInternal(
                      internal: r,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 25.h),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "GENERAL",
                              style: appStyle(
                                  size: 15,
                                  color: mainBlack,
                                  fw: FontWeight.w400),
                            ),
                          ),
                          if (r.toko != null && r.status != "pending") ...[
                            SizedBox(height: 5.h),
                            Card(
                              margin: const EdgeInsets.all(15),
                              elevation: 5,
                              surfaceTintColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10),
                                child: Column(
                                  children: [
                                    AccountBottomTile(
                                      title: "Kelola Profil Toko",
                                      icon: AntIcons.shopOutlined,
                                      routeDestination:
                                          '/internal-account/profile-toko',
                                      iconColor: Colors.purple,
                                      textColor: mainBlack,
                                    ),
                                    const Divider(),
                                    AccountBottomTile(
                                      title: "Kelola Toko Internal",
                                      icon: AntIcons.teamOutlined,
                                      routeDestination:
                                          '/internal-account/internal-toko',
                                      iconColor: Colors.purple,
                                      textColor: mainBlack,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ] else ...[
                            SizedBox(height: 5.h),
                            Card(
                              margin: const EdgeInsets.all(15),
                              elevation: 5,
                              surfaceTintColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10),
                                child: Column(
                                  children: [
                                    AccountBottomTile(
                                      title: "Gabung Toko",
                                      icon: AntIcons.shopOutlined,
                                      routeDestination:
                                          '/internal-account/join-toko',
                                      iconColor: Colors.purple,
                                      textColor: mainBlack,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 25.h),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "ACCOUNT SETTINGS",
                              style: appStyle(
                                  size: 15,
                                  color: mainBlack,
                                  fw: FontWeight.w400),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          const Card(
                            margin: EdgeInsets.all(15),
                            elevation: 5,
                            surfaceTintColor: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 10),
                              child: Column(
                                children: [
                                  AccountBottomTile(
                                    title: "Logout",
                                    icon: AntIcons.logoutOutlined,
                                    iconColor: Colors.red,
                                    textColor: Colors.red,
                                    isArrowDisabled: true,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
          }, loading: () {
            return const Center(child: CircularProgressIndicator());
          }, error: ((error, stackTrace) {
            return Text(error.toString());
          }), orElse: () {
            return const SizedBox.shrink();
          }),
        ));
  }
}
