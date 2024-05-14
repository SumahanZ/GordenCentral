import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tugas_akhir_project/core/customer/settings/repositories/implementations/customer_setting_repository_impl.dart';
import 'package:tugas_akhir_project/core/customer/settings/widgets/account_top_section_customer_widget.dart';
import 'package:tugas_akhir_project/core/internal/settings/widgets/account_bottom_tile_widget.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class CustomerAccountPage extends ConsumerWidget {
  const CustomerAccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetchCustomerInformationData = ref.watch(fetchCustomerInformation);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pengaturan",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: fetchCustomerInformationData.maybeWhen(
              data: (data) {
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
                        SectionTopCustomer(
                          customer: r,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 25.h),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(
                                  "GENERAL",
                                  style: appStyle(
                                      size: 15,
                                      color: mainBlack,
                                      fw: FontWeight.w400),
                                ),
                              ),
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
                                        title: "Manage Wishlist",
                                        icon: AntIcons.heartOutlined,
                                        routeDestination:
                                            '/customer-account/wishlist',
                                        iconColor: Colors.purple,
                                        textColor: mainBlack,
                                      ),
                                      const Divider(),
                                      AccountBottomTile(
                                        title: "Manage Keranjang",
                                        icon: AntIcons.shoppingCartOutlined,
                                        routeDestination:
                                            '/customer-account/cart',
                                        iconColor: Colors.purple,
                                        textColor: mainBlack,
                                      ),
                                      const Divider(),
                                      AccountBottomTile(
                                        title: "Manage Pesanan",
                                        icon: AntIcons.orderedListOutlined,
                                        routeDestination:
                                            '/customer-account/orders',
                                        iconColor: Colors.purple,
                                        textColor: mainBlack,
                                      ),
                                    ],
                                  ),
                                ),
                              )
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(
                                  "ACCOUNT SETTINGS",
                                  style: appStyle(
                                      size: 15,
                                      color: mainBlack,
                                      fw: FontWeight.w400),
                                ),
                              ),
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
                                        title: "Configure Informasi Pengiriman",
                                        icon: AntIcons.userOutlined,
                                        routeDestination:
                                            '/customer-account/change-delivery',
                                        iconColor: Colors.purple,
                                        textColor: mainBlack,
                                      ),
                                      const Divider(),
                                      const AccountBottomTile(
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
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              orElse: () => const SizedBox.shrink())),
    );
  }
}
