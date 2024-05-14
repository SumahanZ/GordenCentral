import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/customer/dashboard/repositories/implementations/customer_dashboard_repository_impl.dart';
import 'package:tugas_akhir_project/core/customer/dashboard/widgets/customer_dashboard_produk_row.widget.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/utils/extensions/integer_extension.dart';

class CustomerDashboardPage extends ConsumerStatefulWidget {
  const CustomerDashboardPage({super.key});

  @override
  ConsumerState<CustomerDashboardPage> createState() =>
      _CustomerDashboardPageState();
}

class _CustomerDashboardPageState extends ConsumerState<CustomerDashboardPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 1, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Dashboard",
            style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: ref.watch(fetchDashboardInformationProvider).maybeWhen(
            data: (data) {
              return data.counts.match(
                  (l) => Center(
                      child: Text(l.message,
                          style: appStyle(
                              size: 16,
                              color: mainBlack,
                              fw: FontWeight.w600))), (counts) {
                return data.newArrival.match(
                    (l) => Center(
                        child: Text(l.message,
                            style: appStyle(
                                size: 16,
                                color: mainBlack,
                                fw: FontWeight.w600))), (newArrival) {
                  return data.popular.match(
                      (l) => Center(
                          child: Text(l.message,
                              style: appStyle(
                                  size: 16,
                                  color: mainBlack,
                                  fw: FontWeight.w600))), (popular) {
                    return data.promo.match(
                        (l) => Center(
                            child: Text(l.message,
                                style: appStyle(
                                    size: 16,
                                    color: mainBlack,
                                    fw: FontWeight.w600))), (promo) {
                      return SafeArea(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(children: [
                              Card(
                                surfaceTintColor: Colors.white,
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Informasi Pesanan:",
                                          style: appStyle(
                                              size: 20,
                                              color: mainBlack,
                                              fw: FontWeight.w600)),
                                      SizedBox(height: 20.h),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(children: [
                                                Text(
                                                    (((counts["processingOrdersCount"] ??
                                                            0) as int)
                                                        .formatOrderCount()),
                                                    style: appStyle(
                                                        size: 20,
                                                        color: mainBlack,
                                                        fw: FontWeight.bold)),
                                                Text("Pesanan \n Ongoing",
                                                    textAlign: TextAlign.center,
                                                    style: appStyle(
                                                        size: 18,
                                                        color: mainBlack,
                                                        fw: FontWeight.w500))
                                              ]),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(children: [
                                                Text(
                                                    ((counts["completedOrdersCount"] ??
                                                            0) as int)
                                                        .formatOrderCount(),
                                                    style: appStyle(
                                                        size: 20,
                                                        color: mainBlack,
                                                        fw: FontWeight.bold)),
                                                Text("Pesanan \n Selesai",
                                                    textAlign: TextAlign.center,
                                                    style: appStyle(
                                                        size: 18,
                                                        color: mainBlack,
                                                        fw: FontWeight.w500))
                                              ]),
                                            ),
                                          ]),
                                      SizedBox(height: 15.h),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              // TabBar(
                              //   padding: const EdgeInsets.all(0),
                              //   splashFactory: NoSplash.splashFactory,
                              //   indicatorSize: TabBarIndicatorSize.tab,
                              //   indicatorColor: Colors.transparent,
                              //   controller: _tabController,
                              //   labelColor: Colors.purple,
                              //   labelStyle: appStyle(
                              //       size: 18,
                              //       color: mainBlack,
                              //       fw: FontWeight.bold),
                              //   unselectedLabelColor:
                              //       Colors.black.withOpacity(0.2),
                              //   tabs: const [
                              //     Tab(text: "Produk"),
                              //     // Tab(text: "Layanan")
                              //   ],
                              // ),
                              SizedBox(
                                child: AutoScaleTabBarView(
                                    controller: _tabController,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 30.h,
                                          ),
                                          Text(
                                            "Paling Populer",
                                            style: appStyle(
                                                size: 18,
                                                color: mainBlack,
                                                fw: FontWeight.w600),
                                          ),
                                          CustomerDashboardProdukRow(
                                              produkList: popular,
                                              onTapNavigation:
                                                  (produkId, tokoId) {
                                                Routemaster.of(context).push(
                                                    '/customer-dashboard/produk/$tokoId/$produkId');
                                              }),
                                          SizedBox(height: 20.h),
                                          Text(
                                            "Promo",
                                            style: appStyle(
                                                size: 18,
                                                color: mainBlack,
                                                fw: FontWeight.w600),
                                          ),
                                          CustomerDashboardProdukRow(
                                              produkList: promo,
                                              onTapNavigation:
                                                  (produkId, tokoId) {
                                                Routemaster.of(context).push(
                                                    '/customer-dashboard/produk/$tokoId/$produkId');
                                              }),
                                          SizedBox(height: 20.h),
                                          Text(
                                            "Arrival Baru",
                                            style: appStyle(
                                                size: 18,
                                                color: mainBlack,
                                                fw: FontWeight.w600),
                                          ),
                                          SizedBox(height: 20.h),
                                          CustomerDashboardProdukRow(
                                              produkList: newArrival,
                                              onTapNavigation:
                                                  (produkId, tokoId) {
                                                Routemaster.of(context).push(
                                                    '/customer-dashboard/produk/$tokoId/$produkId');
                                              }),
                                        ],
                                      ),
                                    ]),
                              ),
                            ]),
                          ),
                        ),
                      );
                    });
                  });
                });
              });
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            orElse: () => const SizedBox.shrink()));
  }
}
