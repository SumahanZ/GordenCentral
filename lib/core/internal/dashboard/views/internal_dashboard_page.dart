import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/core/internal/dashboard/repositories/implementations/internal_dashboard_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/settings/repositories/implementations/internal_settings_repository_impl.dart';
import 'package:tugas_akhir_project/utils/extensions/either_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/integer_extension.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class InternalDashboardPage extends ConsumerWidget {
  const InternalDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final internalInformation = ref.watch(fetchInternalInformation);
    final ordersCompletedOngoingCount =
        ref.watch(fetchOrdersProcessingCompletedCountInternal);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Dashboard",
            style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: internalInformation.when(
            data: (data) {
              return data.unwrapRight()?.status != "joined"
                  ? Center(
                      child: Text("Anda belum bergabung toko",
                          style: appStyle(
                              size: 16, color: mainBlack, fw: FontWeight.w600)))
                  : ordersCompletedOngoingCount.maybeWhen(
                      data: (data) {
                        return data.match(
                            (l) => Center(
                                child: Text(l.message,
                                    style: appStyle(
                                        size: 16,
                                        color: mainBlack,
                                        fw: FontWeight.w600))), (r) {
                          return SafeArea(
                              child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  const TopSectionAuth(
                                      name: "Selamat Datang!",
                                      description:
                                          "This is the dashboard, where you receive information of the overall sales of the toko.",
                                      isAvatarNeeded: false),
                                  const SizedBox(height: 10),
                                  Card(
                                    surfaceTintColor: Colors.white,
                                    elevation: 5,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20.0, horizontal: 20),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Total Pesanan:",
                                                  style: appStyle(
                                                      size: 20,
                                                      color: mainBlack,
                                                      fw: FontWeight.w600)),
                                              const SizedBox(height: 20),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Flexible(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      child: Column(children: [
                                                        Text(
                                                            ((r["completedOrdersCount"] ??
                                                                    0) as int)
                                                                .formatOrderCount(),
                                                            style: appStyle(
                                                                size: 20,
                                                                color:
                                                                    mainBlack,
                                                                fw: FontWeight
                                                                    .bold)),
                                                        ConstrainedBox(
                                                          constraints:
                                                              const BoxConstraints(
                                                            minWidth: 100,
                                                            maxWidth: 120,
                                                          ),
                                                          child: Text(
                                                              "Pesanan Selesai",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: appStyle(
                                                                  size: 16,
                                                                  color:
                                                                      mainBlack,
                                                                  fw: FontWeight
                                                                      .w500)),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      child: Column(children: [
                                                        Text(
                                                            (((r["processingOrdersCount"] ??
                                                                    0) as int)
                                                                .formatOrderCount()),
                                                            style: appStyle(
                                                                size: 20,
                                                                color:
                                                                    mainBlack,
                                                                fw: FontWeight
                                                                    .bold)),
                                                        ConstrainedBox(
                                                          constraints:
                                                              const BoxConstraints(
                                                            minWidth: 80,
                                                            maxWidth: 100,
                                                          ),
                                                          child: Text(
                                                              "Pesanan Processing",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: appStyle(
                                                                  size: 16,
                                                                  color:
                                                                      mainBlack,
                                                                  fw: FontWeight
                                                                      .w500)),
                                                        )
                                                      ]),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ])),
                                  ),
                                  const SizedBox(height: 15),
                                  GestureDetector(
                                    onTap: () => Routemaster.of(context)
                                        .push('/internal-dashboard/produkstok'),
                                    child: Card(
                                      surfaceTintColor: Colors.white,
                                      elevation: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 30, 10, 30),
                                        child: Row(children: [
                                          const CircleAvatar(
                                            radius: 35,
                                            child: Icon(
                                                AntIcons.projectOutlined,
                                                size: 35),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Produk & Stok",
                                                      style: appStyle(
                                                          size: 16,
                                                          color: mainBlack,
                                                          fw: FontWeight.w500)),
                                                  Text(
                                                      "Konfigurasikan produk, stok, dan kelola inventaris!",
                                                      style: appStyle(
                                                          size: 12,
                                                          color: mainBlack,
                                                          fw: FontWeight.w400))
                                                ]),
                                          ),
                                          const Icon(
                                              Icons.chevron_right_rounded,
                                              size: 35)
                                        ]),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  GestureDetector(
                                    onTap: () => Routemaster.of(context).push(
                                        '/internal-dashboard/analisa-keuangan'),
                                    child: Card(
                                      surfaceTintColor: Colors.white,
                                      elevation: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 30, 10, 30),
                                        child: Row(children: [
                                          const CircleAvatar(
                                            radius: 35,
                                            child: Icon(AntIcons.stockOutlined,
                                                size: 35),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Analisa Keuangan",
                                                      style: appStyle(
                                                          size: 16,
                                                          color: mainBlack,
                                                          fw: FontWeight.w500)),
                                                  Text(
                                                      "Analisis penjualan dan pendapatan toko!",
                                                      style: appStyle(
                                                          size: 12,
                                                          color: mainBlack,
                                                          fw: FontWeight.w400))
                                                ]),
                                          ),
                                          const Icon(
                                              Icons.chevron_right_rounded,
                                              size: 35)
                                        ]),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  GestureDetector(
                                    onTap: () => Routemaster.of(context).push(
                                        '/internal-dashboard/laporan-barang'),
                                    child: Card(
                                      surfaceTintColor: Colors.white,
                                      elevation: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 30, 10, 30),
                                        child: Row(children: [
                                          const CircleAvatar(
                                            radius: 35,
                                            child: Icon(Icons.inbox, size: 35),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Laporan Barang",
                                                      style: appStyle(
                                                          size: 16,
                                                          color: mainBlack,
                                                          fw: FontWeight.w500)),
                                                  Text(
                                                      "Lihat hasil laporan barang keluar dan masuk",
                                                      style: appStyle(
                                                          size: 12,
                                                          color: mainBlack,
                                                          fw: FontWeight.w400))
                                                ]),
                                          ),
                                          const Icon(
                                              Icons.chevron_right_rounded,
                                              size: 35)
                                        ]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                        });
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      orElse: () => const SizedBox.shrink());
            },
            error: ((error, stackTrace) =>
                Center(child: Text(error.toString()))),
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}
