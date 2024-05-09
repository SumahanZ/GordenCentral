import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                                      const SizedBox(height: 20),
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
                                      const SizedBox(height: 15),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
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
                                          const SizedBox(
                                            height: 30,
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
                                          const SizedBox(height: 20),
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
                                          const SizedBox(height: 20),
                                          Text(
                                            "Arrival Baru",
                                            style: appStyle(
                                                size: 18,
                                                color: mainBlack,
                                                fw: FontWeight.w600),
                                          ),
                                          const SizedBox(height: 20),
                                          CustomerDashboardProdukRow(
                                              produkList: newArrival,
                                              onTapNavigation:
                                                  (produkId, tokoId) {
                                                Routemaster.of(context).push(
                                                    '/customer-dashboard/produk/$tokoId/$produkId');
                                              }),
                                        ],
                                      ),
                                      // Column(
                                      //   crossAxisAlignment:
                                      //       CrossAxisAlignment.start,
                                      //   children: [
                                      //     const SizedBox(
                                      //       height: 30,
                                      //     ),
                                      //     Text(
                                      //       "Most Popular",
                                      //       style: appStyle(
                                      //           size: 18,
                                      //           color: mainBlack,
                                      //           fw: FontWeight.w600),
                                      //     ),
                                      //     SizedBox(
                                      //         height: 350,
                                      //         child: ListView.builder(
                                      //             physics:
                                      //                 const ClampingScrollPhysics(),
                                      //             padding:
                                      //                 const EdgeInsets.all(10),
                                      //             shrinkWrap: true,
                                      //             primary: true,
                                      //             itemCount: 10,
                                      //             scrollDirection:
                                      //                 Axis.horizontal,
                                      //             itemBuilder:
                                      //                 (context, index) {
                                      //               return GestureDetector(
                                      //                 onTap: () => Routemaster
                                      //                         .of(context)
                                      //                     .push(
                                      //                         '/internal-account/profile-toko/preview-profile-toko/produk'),
                                      //                 child: SizedBox(
                                      //                   width: 200,
                                      //                   child: Padding(
                                      //                     padding:
                                      //                         const EdgeInsets
                                      //                             .symmetric(
                                      //                             horizontal:
                                      //                                 10,
                                      //                             vertical: 10),
                                      //                     child: ClipRRect(
                                      //                       borderRadius:
                                      //                           BorderRadius
                                      //                               .circular(
                                      //                                   20),
                                      //                       child: Card(
                                      //                         surfaceTintColor:
                                      //                             Colors.white,
                                      //                         elevation: 5,
                                      //                         child: Column(
                                      //                             crossAxisAlignment:
                                      //                                 CrossAxisAlignment
                                      //                                     .center,
                                      //                             children: [
                                      //                               Padding(
                                      //                                 padding: const EdgeInsets
                                      //                                     .all(
                                      //                                     15.0),
                                      //                                 child: Row(
                                      //                                     children: [
                                      //                                       ClipRRect(
                                      //                                         borderRadius: BorderRadius.circular(15),
                                      //                                         child: DecoratedBox(
                                      //                                           decoration: const BoxDecoration(
                                      //                                             color: Colors.deepPurpleAccent,
                                      //                                           ),
                                      //                                           child: Padding(
                                      //                                             padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10),
                                      //                                             child: Row(
                                      //                                               crossAxisAlignment: CrossAxisAlignment.start,
                                      //                                               children: [
                                      //                                                 Text("15% OFF", style: appStyle(size: 13, color: Colors.white, fw: FontWeight.w600)),
                                      //                                               ],
                                      //                                             ),
                                      //                                           ),
                                      //                                         ),
                                      //                                       ),
                                      //                                       const Spacer(),
                                      //                                       const CircleAvatar(
                                      //                                         backgroundColor: Colors.deepPurpleAccent,
                                      //                                         radius: 14,
                                      //                                         child: Icon(AntIcons.heartFilled, size: 16, color: Colors.white),
                                      //                                       )
                                      //                                     ]),
                                      //                               ),
                                      //                               ClipRRect(
                                      //                                 child: Image
                                      //                                     .asset(
                                      //                                   "assets/images/test-image-2.avif",
                                      //                                   fit: BoxFit
                                      //                                       .fitWidth,
                                      //                                 ),
                                      //                               ),
                                      //                               const SizedBox(
                                      //                                   height:
                                      //                                       12),
                                      //                               Padding(
                                      //                                 padding: const EdgeInsets
                                      //                                     .all(
                                      //                                     6.0),
                                      //                                 child:
                                      //                                     Column(
                                      //                                   mainAxisAlignment:
                                      //                                       MainAxisAlignment.spaceBetween,
                                      //                                   crossAxisAlignment:
                                      //                                       CrossAxisAlignment.center,
                                      //                                   children: [
                                      //                                     Text(
                                      //                                         "Nike Air Max K200",
                                      //                                         maxLines: 2,
                                      //                                         overflow: TextOverflow.ellipsis,
                                      //                                         style: appStyle(size: 14, color: mainBlack, fw: FontWeight.w600),
                                      //                                         textAlign: TextAlign.center),
                                      //                                     const SizedBox(
                                      //                                         height: 5),
                                      //                                     Text(
                                      //                                       "Rp 97.000",
                                      //                                       style: appStyle(
                                      //                                           size: 16,
                                      //                                           color: mainBlack,
                                      //                                           fw: FontWeight.bold),
                                      //                                     ),
                                      //                                     const SizedBox(
                                      //                                         height: 5),
                                      //                                     Row(
                                      //                                       mainAxisAlignment:
                                      //                                           MainAxisAlignment.center,
                                      //                                       children: [
                                      //                                         RatingBar.builder(
                                      //                                           ignoreGestures: true,
                                      //                                           itemSize: 16,
                                      //                                           initialRating: 3,
                                      //                                           minRating: 1,
                                      //                                           direction: Axis.horizontal,
                                      //                                           allowHalfRating: true,
                                      //                                           itemCount: 5,
                                      //                                           itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                                      //                                           itemBuilder: (context, _) => const Icon(
                                      //                                             Icons.star,
                                      //                                             color: Colors.amber,
                                      //                                           ),
                                      //                                           onRatingUpdate: (rating) {},
                                      //                                         ),
                                      //                                         const SizedBox(width: 5),
                                      //                                         Text("(3.5)", style: appStyle(size: 11, color: mainBlack, fw: FontWeight.w600)),
                                      //                                       ],
                                      //                                     ),
                                      //                                     const SizedBox(
                                      //                                         height: 5),
                                      //                                   ],
                                      //                                 ),
                                      //                               )
                                      //                             ]),
                                      //                       ),
                                      //                     ),
                                      //                   ),
                                      //                 ),
                                      //               );
                                      //             })),
                                      //     const SizedBox(height: 20),
                                      //     Text(
                                      //       "Promo",
                                      //       style: appStyle(
                                      //           size: 18,
                                      //           color: mainBlack,
                                      //           fw: FontWeight.w600),
                                      //     ),
                                      //     SizedBox(
                                      //         height: 350,
                                      //         child: ListView.builder(
                                      //             physics:
                                      //                 const ClampingScrollPhysics(),
                                      //             padding:
                                      //                 const EdgeInsets.all(10),
                                      //             shrinkWrap: true,
                                      //             primary: true,
                                      //             itemCount: 10,
                                      //             scrollDirection:
                                      //                 Axis.horizontal,
                                      //             itemBuilder:
                                      //                 (context, index) {
                                      //               return GestureDetector(
                                      //                 onTap: () => Routemaster
                                      //                         .of(context)
                                      //                     .push(
                                      //                         '/internal-account/profile-toko/preview-profile-toko/produk'),
                                      //                 child: SizedBox(
                                      //                   width: 200,
                                      //                   child: Padding(
                                      //                     padding:
                                      //                         const EdgeInsets
                                      //                             .symmetric(
                                      //                             horizontal:
                                      //                                 10,
                                      //                             vertical: 10),
                                      //                     child: ClipRRect(
                                      //                       borderRadius:
                                      //                           BorderRadius
                                      //                               .circular(
                                      //                                   20),
                                      //                       child: Card(
                                      //                         surfaceTintColor:
                                      //                             Colors.white,
                                      //                         elevation: 5,
                                      //                         child: Column(
                                      //                             crossAxisAlignment:
                                      //                                 CrossAxisAlignment
                                      //                                     .center,
                                      //                             children: [
                                      //                               const Padding(
                                      //                                 padding:
                                      //                                     EdgeInsets.all(
                                      //                                         15.0),
                                      //                                 child: Row(
                                      //                                     mainAxisAlignment:
                                      //                                         MainAxisAlignment.end,
                                      //                                     children: [
                                      //                                       CircleAvatar(
                                      //                                         backgroundColor: Colors.deepPurpleAccent,
                                      //                                         radius: 14,
                                      //                                         child: Icon(AntIcons.heartFilled, size: 16, color: Colors.white),
                                      //                                       )
                                      //                                     ]),
                                      //                               ),
                                      //                               ClipRRect(
                                      //                                 child: Image
                                      //                                     .asset(
                                      //                                   "assets/images/test-image-2.avif",
                                      //                                   fit: BoxFit
                                      //                                       .fitWidth,
                                      //                                 ),
                                      //                               ),
                                      //                               const SizedBox(
                                      //                                   height:
                                      //                                       12),
                                      //                               Padding(
                                      //                                 padding: const EdgeInsets
                                      //                                     .all(
                                      //                                     6.0),
                                      //                                 child:
                                      //                                     Column(
                                      //                                   mainAxisAlignment:
                                      //                                       MainAxisAlignment.spaceBetween,
                                      //                                   crossAxisAlignment:
                                      //                                       CrossAxisAlignment.center,
                                      //                                   children: [
                                      //                                     Text(
                                      //                                         "Nike Air Max K200",
                                      //                                         maxLines: 2,
                                      //                                         overflow: TextOverflow.ellipsis,
                                      //                                         style: appStyle(size: 14, color: mainBlack, fw: FontWeight.w600),
                                      //                                         textAlign: TextAlign.center),
                                      //                                     const SizedBox(
                                      //                                         height: 5),
                                      //                                     Text(
                                      //                                       "Rp 97.000",
                                      //                                       style: appStyle(
                                      //                                           size: 16,
                                      //                                           color: mainBlack,
                                      //                                           fw: FontWeight.bold),
                                      //                                     ),
                                      //                                     const SizedBox(
                                      //                                         height: 5),
                                      //                                     Row(
                                      //                                       mainAxisAlignment:
                                      //                                           MainAxisAlignment.center,
                                      //                                       children: [
                                      //                                         RatingBar.builder(
                                      //                                           ignoreGestures: true,
                                      //                                           itemSize: 16,
                                      //                                           initialRating: 3,
                                      //                                           minRating: 1,
                                      //                                           direction: Axis.horizontal,
                                      //                                           allowHalfRating: true,
                                      //                                           itemCount: 5,
                                      //                                           itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                                      //                                           itemBuilder: (context, _) => const Icon(
                                      //                                             Icons.star,
                                      //                                             color: Colors.amber,
                                      //                                           ),
                                      //                                           onRatingUpdate: (rating) {},
                                      //                                         ),
                                      //                                         const SizedBox(width: 5),
                                      //                                         Text("(3.5)", style: appStyle(size: 11, color: mainBlack, fw: FontWeight.w600)),
                                      //                                       ],
                                      //                                     ),
                                      //                                     const SizedBox(
                                      //                                         height: 5),
                                      //                                   ],
                                      //                                 ),
                                      //                               )
                                      //                             ]),
                                      //                       ),
                                      //                     ),
                                      //                   ),
                                      //                 ),
                                      //               );
                                      //             })),
                                      //     const SizedBox(height: 20),
                                      //     Text(
                                      //       "Paling Fashionable",
                                      //       style: appStyle(
                                      //           size: 18,
                                      //           color: mainBlack,
                                      //           fw: FontWeight.w600),
                                      //     ),
                                      //     const SizedBox(height: 20),
                                      //     SizedBox(
                                      //         height: 350,
                                      //         child: ListView.builder(
                                      //             physics:
                                      //                 const ClampingScrollPhysics(),
                                      //             padding:
                                      //                 const EdgeInsets.all(10),
                                      //             shrinkWrap: true,
                                      //             primary: true,
                                      //             itemCount: 10,
                                      //             scrollDirection:
                                      //                 Axis.horizontal,
                                      //             itemBuilder:
                                      //                 (context, index) {
                                      //               return GestureDetector(
                                      //                 onTap: () => Routemaster
                                      //                         .of(context)
                                      //                     .push(
                                      //                         '/internal-account/profile-toko/preview-profile-toko/produk'),
                                      //                 child: SizedBox(
                                      //                   width: 200,
                                      //                   child: Padding(
                                      //                     padding:
                                      //                         const EdgeInsets
                                      //                             .symmetric(
                                      //                             horizontal:
                                      //                                 10,
                                      //                             vertical: 10),
                                      //                     child: ClipRRect(
                                      //                       borderRadius:
                                      //                           BorderRadius
                                      //                               .circular(
                                      //                                   20),
                                      //                       child: Card(
                                      //                         surfaceTintColor:
                                      //                             Colors.white,
                                      //                         elevation: 5,
                                      //                         child: Column(
                                      //                             crossAxisAlignment:
                                      //                                 CrossAxisAlignment
                                      //                                     .center,
                                      //                             children: [
                                      //                               const Padding(
                                      //                                 padding:
                                      //                                     EdgeInsets.all(
                                      //                                         15.0),
                                      //                                 child: Row(
                                      //                                     mainAxisAlignment:
                                      //                                         MainAxisAlignment.end,
                                      //                                     children: [
                                      //                                       CircleAvatar(
                                      //                                         backgroundColor: Colors.deepPurpleAccent,
                                      //                                         radius: 14,
                                      //                                         child: Icon(AntIcons.heartFilled, size: 16, color: Colors.white),
                                      //                                       )
                                      //                                     ]),
                                      //                               ),
                                      //                               ClipRRect(
                                      //                                 child: Image
                                      //                                     .asset(
                                      //                                   "assets/images/test-image-2.avif",
                                      //                                   fit: BoxFit
                                      //                                       .fitWidth,
                                      //                                 ),
                                      //                               ),
                                      //                               const SizedBox(
                                      //                                   height:
                                      //                                       12),
                                      //                               Padding(
                                      //                                 padding: const EdgeInsets
                                      //                                     .all(
                                      //                                     6.0),
                                      //                                 child:
                                      //                                     Column(
                                      //                                   mainAxisAlignment:
                                      //                                       MainAxisAlignment.spaceBetween,
                                      //                                   crossAxisAlignment:
                                      //                                       CrossAxisAlignment.center,
                                      //                                   children: [
                                      //                                     Text(
                                      //                                         "Nike Air Max K200",
                                      //                                         maxLines: 2,
                                      //                                         overflow: TextOverflow.ellipsis,
                                      //                                         style: appStyle(size: 14, color: mainBlack, fw: FontWeight.w600),
                                      //                                         textAlign: TextAlign.center),
                                      //                                     const SizedBox(
                                      //                                         height: 5),
                                      //                                     Text(
                                      //                                       "Rp 97.000",
                                      //                                       style: appStyle(
                                      //                                           size: 16,
                                      //                                           color: mainBlack,
                                      //                                           fw: FontWeight.bold),
                                      //                                     ),
                                      //                                     const SizedBox(
                                      //                                         height: 5),
                                      //                                     Row(
                                      //                                       mainAxisAlignment:
                                      //                                           MainAxisAlignment.center,
                                      //                                       children: [
                                      //                                         RatingBar.builder(
                                      //                                           ignoreGestures: true,
                                      //                                           itemSize: 16,
                                      //                                           initialRating: 3,
                                      //                                           minRating: 1,
                                      //                                           direction: Axis.horizontal,
                                      //                                           allowHalfRating: true,
                                      //                                           itemCount: 5,
                                      //                                           itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                                      //                                           itemBuilder: (context, _) => const Icon(
                                      //                                             Icons.star,
                                      //                                             color: Colors.amber,
                                      //                                           ),
                                      //                                           onRatingUpdate: (rating) {},
                                      //                                         ),
                                      //                                         const SizedBox(width: 5),
                                      //                                         Text("(3.5)", style: appStyle(size: 11, color: mainBlack, fw: FontWeight.w600)),
                                      //                                       ],
                                      //                                     ),
                                      //                                     const SizedBox(
                                      //                                         height: 5),
                                      //                                   ],
                                      //                                 ),
                                      //                               )
                                      //                             ]),
                                      //                       ),
                                      //                     ),
                                      //                   ),
                                      //                 ),
                                      //               );
                                      //             })),
                                      //   ],
                                      // ),
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
