import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:badges/badges.dart' as badges;

class InternalMainPage extends ConsumerWidget {
  const InternalMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabPage = TabPage.of(context);

    return Scaffold(
      extendBody: true,
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
        labelPadding: const EdgeInsets.symmetric(horizontal: 5),
        enableFeedback: true,
        splashBorderRadius: BorderRadius.circular(10),
        labelStyle:
            appStyle(size: 10, color: Colors.purple, fw: FontWeight.bold),
        unselectedLabelStyle: appStyle(
            size: 10,
            color: Colors.black.withOpacity(0.5),
            fw: FontWeight.w600),
        controller: tabPage.controller,
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
              icon: Icon(AntIcons.orderedListOutlined),
              text: 'Pesanan',
            ),
          ),
          // const Tab(
          //   icon: Icon(Icons.inventory_2),
          //   text: 'Produk & Stok',
          // ),
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
        color: Colors.red,
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


// BottomNavigationBarItem(
//             label: 'Dashboard',
//             icon: Icon(CupertinoIcons.list_bullet),
//           ),
//           BottomNavigationBarItem(
//             label: 'Orders',
//             icon: Icon(CupertinoIcons.search),
//           ),
//           BottomNavigationBarItem(
//             label: 'Profile Toko',
//             icon: Icon(CupertinoIcons.search),
//           ),
//           BottomNavigationBarItem(
//             label: 'Notifications',
//             icon: Icon(CupertinoIcons.search),
//           ),
//           BottomNavigationBarItem(
//             label: 'Account',
//             icon: Icon(CupertinoIcons.search),
//           ),