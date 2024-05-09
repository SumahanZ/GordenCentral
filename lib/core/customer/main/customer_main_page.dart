import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/repositories/implementations/token_push_notification_repository_impl.dart';
import 'package:tugas_akhir_project/core/auth/viewmodels/token_push_notification_viewmodel.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:badges/badges.dart' as badges;

class CustomerMainPage extends ConsumerWidget {
  const CustomerMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabPage = TabPage.of(context);

    ref.listen(onRefreshTokenStreamProvider, (previous, next) async {
      if (previous?.value != next.value) {
        final token = await ref
            .read(pushNotificationRepositoryProvider)
            .getTokenDatabase(ref);
        ref
            .read(tokenPushNotificationViewModelProvider.notifier)
            .updateDeviceToken(deviceToken: token ?? "");
      }
    });

    return Scaffold(
      bottomNavigationBar: TabBar(
        splashFactory: NoSplash.splashFactory,
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          // Use the default focused overlay color
          return states.contains(MaterialState.focused)
              ? null
              : Colors.transparent;
        }),
        indicator: const UnderlineTabIndicator(),
        tabAlignment: TabAlignment.fill,
        indicatorSize: TabBarIndicatorSize.tab,
        labelPadding: const EdgeInsets.symmetric(horizontal: 2),
        enableFeedback: true,
        splashBorderRadius: BorderRadius.circular(10),
        controller: tabPage.controller,
        labelStyle:
            appStyle(size: 10, color: Colors.purple, fw: FontWeight.bold),
        unselectedLabelStyle:
            appStyle(size: 10, color: mainBlack, fw: FontWeight.w500),
        tabs: [
          const Tab(
            icon: Icon(AntIcons.homeOutlined),
            text: "Dashboard",
          ),
          badges.Badge(
            showBadge: false,
            position: badges.BadgePosition.custom(start: 30),
            badgeContent: Text("3",
                style: appStyle(
                    size: 10, color: Colors.white, fw: FontWeight.w500)),
            badgeStyle: const badges.BadgeStyle(badgeColor: Colors.purple),
            child: const Tab(
              icon: Icon(AntIcons.globalOutlined),
              text: 'Browse Toko',
            ),
          ),
          const Tab(
            icon: Icon(AntIcons.searchOutlined),
            text: 'Search',
          ),
          badges.Badge(
            showBadge: false,
            position: badges.BadgePosition.custom(start: 40),
            badgeContent: Text(
              "3",
              style:
                  appStyle(size: 10, color: Colors.white, fw: FontWeight.w500),
            ),
            badgeStyle: const badges.BadgeStyle(badgeColor: Colors.purple),
            child: const Tab(
              icon: Icon(AntIcons.notificationOutlined),
              text: 'Notifikasi',
            ),
          ),
          const Tab(
            icon: Icon(AntIcons.settingOutlined),
            text: 'Setting',
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 243, 244, 248),
        child: TabBarView(
          controller: tabPage.controller,
          children: [
            for (final stack in tabPage.stacks)
              PageStackNavigator(stack: stack),
          ],
        ),
      ),
    );
  }
}
