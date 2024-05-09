import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/widgets/global_providers/user_state.dart';

class InternalProfileTokoPage extends ConsumerWidget {
  const InternalProfileTokoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kelola Profil Toko",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                if (userState?.type == "pemilik")
                  GestureDetector(
                    onTap: () {
                      Routemaster.of(context).push(
                          '/internal-account/profile-toko/toko-information');
                    },
                    child: Card(
                      surfaceTintColor: Colors.white,
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 30, 10, 30),
                        child: Row(children: [
                          const CircleAvatar(
                            radius: 35,
                            child: Icon(AntIcons.shopOutlined, size: 35),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Informasi Toko",
                                      style: appStyle(
                                          size: 16,
                                          color: mainBlack,
                                          fw: FontWeight.w500)),
                                  Text(
                                      "Konfigurasikan informasi toko dan edit yang lainnya!",
                                      style: appStyle(
                                          size: 12,
                                          color: mainBlack,
                                          fw: FontWeight.w400))
                                ]),
                          ),
                          const Icon(Icons.chevron_right_rounded, size: 35)
                        ]),
                      ),
                    ),
                  ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () => Routemaster.of(context)
                      .push("/internal-account/profile-toko/katalog-produk"),
                  child: Card(
                    surfaceTintColor: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 10, 30),
                      child: Row(children: [
                        const CircleAvatar(
                          radius: 35,
                          child: Icon(Icons.shop_2_outlined, size: 35),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Katalog Produk",
                                    style: appStyle(
                                        size: 16,
                                        color: mainBlack,
                                        fw: FontWeight.w500)),
                                Text(
                                    "Konfigurasikan katalog produk toko dan edit yang lainnya!",
                                    style: appStyle(
                                        size: 12,
                                        color: mainBlack,
                                        fw: FontWeight.w400))
                              ]),
                        ),
                        const Icon(Icons.chevron_right_rounded, size: 35)
                      ]),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () => Routemaster.of(context)
                      .push("/internal-account/profile-toko/beranda-toko"),
                  child: Card(
                    surfaceTintColor: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 10, 30),
                      child: Row(children: [
                        const CircleAvatar(
                          radius: 35,
                          child: Icon(AntIcons.pictureOutlined, size: 35),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Beranda Toko",
                                    style: appStyle(
                                        size: 16,
                                        color: mainBlack,
                                        fw: FontWeight.w500)),
                                Text(
                                    "Konfigurasikan beranda toko dan edit yang lainnya!",
                                    style: appStyle(
                                        size: 12,
                                        color: mainBlack,
                                        fw: FontWeight.w400))
                              ]),
                        ),
                        const Icon(Icons.chevron_right_rounded, size: 35)
                      ]),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () => Routemaster.of(context)
                      .push("/internal-account/profile-toko/promosi"),
                  child: Card(
                    surfaceTintColor: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 10, 30),
                      child: Row(children: [
                        const CircleAvatar(
                          radius: 35,
                          child: Icon(Icons.discount_outlined, size: 35),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Promo",
                                    style: appStyle(
                                        size: 16,
                                        color: mainBlack,
                                        fw: FontWeight.w500)),
                                Text(
                                    "Konfigurasikan promo toko dan edit yang lainnya!",
                                    style: appStyle(
                                        size: 12,
                                        color: mainBlack,
                                        fw: FontWeight.w400))
                              ]),
                        ),
                        const Icon(Icons.chevron_right_rounded, size: 35)
                      ]),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () => Routemaster.of(context).push(
                      "/internal-account/profile-toko/preview-profile-toko"),
                  child: Card(
                    surfaceTintColor: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 10, 30),
                      child: Row(children: [
                        const CircleAvatar(
                          radius: 35,
                          child: Icon(Icons.view_carousel_outlined, size: 40),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Preview Profile Toko",
                                    style: appStyle(
                                        size: 16,
                                        color: mainBlack,
                                        fw: FontWeight.w500)),
                                Text(
                                    "Melihat preview dari profile toko yang sudah dikonfigurasikan",
                                    style: appStyle(
                                        size: 12,
                                        color: mainBlack,
                                        fw: FontWeight.w400))
                              ]),
                        ),
                        const Icon(Icons.chevron_right_rounded, size: 35)
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
