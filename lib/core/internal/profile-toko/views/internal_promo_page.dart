import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/providers/promo_item_selection_notifier.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/providers/promo_selection_notifier.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/utils/extensions/date_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/double_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/list_extension.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:routemaster/routemaster.dart';

class InternalPromoPage extends ConsumerStatefulWidget {
  const InternalPromoPage({super.key});

  @override
  ConsumerState<InternalPromoPage> createState() => _InternalPromoPageState();
}

class _InternalPromoPageState extends ConsumerState<InternalPromoPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  const Icon(Icons.add_outlined, size: 30),
                  GestureDetector(
                    onTap: () {
                      ref
                          .read(promoItemSelectionNotifierProvider.notifier)
                          .emptySelection();
                      Routemaster.of(context)
                          .push('/internal-account/profile-toko/promosi/add');
                    },
                    child: Text(
                      "Tambah",
                      style: appStyle(
                          size: 14, color: mainBlack, fw: FontWeight.w600),
                    ),
                  )
                ],
              ),
            )
          ],
          bottom: TabBar(
            // dividerColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            padding: const EdgeInsets.all(0),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.transparent,
            controller: _tabController,
            labelColor: Colors.purple,
            labelStyle:
                appStyle(size: 16, color: mainBlack, fw: FontWeight.bold),
            unselectedLabelColor: Colors.black.withOpacity(0.2),
            tabs: const [
              Tab(text: "Berlangsung"),
              Tab(text: "Expired"),
            ],
          ),
          title: Text(
            "Promo",
            style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ref.watch(fetchPromoProvider).when(
                      data: (data) {
                        return data.match(
                            (l) => Center(
                                child: Text(l.message,
                                    style: appStyle(
                                        size: 16,
                                        color: mainBlack,
                                        fw: FontWeight.w600))), (r) {
                          final filteredPromosOngoing = r.where((element) {
                            return (element.expiredAt ?? DateTime.now())
                                .isAfter(DateTime.now());
                          }).toList();
                          if (filteredPromosOngoing.isEmpty) {
                            return Center(
                                child: Text(
                                    "Tidak ada promo yang sedang berlangsung",
                                    style: appStyle(
                                        size: 16,
                                        color: mainBlack,
                                        fw: FontWeight.w600)));
                          } else {
                            return SingleChildScrollView(
                              child: Column(children: [
                                ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: filteredPromosOngoing.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 5),
                                        child: Card(
                                          surfaceTintColor: Colors.white,
                                          elevation: 5,
                                          child: ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 10),
                                            title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(Icons
                                                          .discount_outlined),
                                                      const SizedBox(width: 5),
                                                      Text(
                                                          "${filteredPromosOngoing[index].discountPercent}% OFF",
                                                          style: appStyle(
                                                              size: 12,
                                                              color: mainBlack,
                                                              fw: FontWeight
                                                                  .w600)),
                                                      const Spacer(),
                                                      Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        ((filteredPromosOngoing[
                                                                            index]
                                                                        .expiredAt ??
                                                                    DateTime
                                                                        .now())
                                                                .isAfter(
                                                                    DateTime
                                                                        .now()))
                                                            ? "Expires: ${DateTimeHourMin.durationBetween(DateTime.now(), filteredPromosOngoing[index].expiredAt!)}"
                                                            : "Expired At: ${filteredPromosOngoing[index].expiredAt?.formatDatePDF()}",
                                                        style: appStyle(
                                                          size: 11,
                                                          color: mainBlack,
                                                          fw: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5),
                                                  IntrinsicHeight(
                                                    child: Row(children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Image.network(
                                                            filteredPromosOngoing[
                                                                        index]
                                                                    .produk
                                                                    ?.produkGlobalImages
                                                                    .first
                                                                    .globalImageUrl ??
                                                                "",
                                                            fit: BoxFit.contain,
                                                            width: 70),
                                                      ),
                                                      const SizedBox(width: 15),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                filteredPromosOngoing[
                                                                            index]
                                                                        .produk
                                                                        ?.name ??
                                                                    "No name",
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: appStyle(
                                                                    size: 14,
                                                                    color:
                                                                        mainBlack,
                                                                    fw: FontWeight
                                                                        .w600)),
                                                            Text(
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              "Ukuran: ${filteredPromosOngoing[index].produk?.produkSizes.map((e) => e.name).toList().getConcatenatedList()}",
                                                              style: appStyle(
                                                                size: 11,
                                                                color:
                                                                    mainBlack,
                                                                fw: FontWeight
                                                                    .w500,
                                                              ),
                                                            ),
                                                            Text(
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              "Warna: ${filteredPromosOngoing[index].produk?.produkColors.map((e) => e.name).toList().getConcatenatedList()}",
                                                              style: appStyle(
                                                                size: 11,
                                                                color:
                                                                    mainBlack,
                                                                fw: FontWeight
                                                                    .w500,
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  PriceFormatter
                                                                      .getFormattedValue(
                                                                          filteredPromosOngoing[index].produk?.price ??
                                                                              0),
                                                                  style:
                                                                      appStyle(
                                                                    size: 14,
                                                                    color:
                                                                        mainBlack,
                                                                    fw: FontWeight
                                                                        .bold,
                                                                  ).copyWith(
                                                                          decoration: TextDecoration
                                                                              .lineThrough,
                                                                          decorationThickness:
                                                                              2),
                                                                ),
                                                                const SizedBox(
                                                                    width: 5),
                                                                Text(
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  PriceFormatter.getFormattedValue((filteredPromosOngoing[index]
                                                                              .produk
                                                                              ?.price ??
                                                                          0) -
                                                                      (filteredPromosOngoing[index].produk?.price ??
                                                                              0) *
                                                                          ((filteredPromosOngoing[index].discountPercent?.toInt() ?? 0) /
                                                                              100)),
                                                                  style:
                                                                      appStyle(
                                                                    size: 14,
                                                                    color:
                                                                        mainBlack,
                                                                    fw: FontWeight
                                                                        .bold,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(width: 20),
                                                      GestureDetector(
                                                        onTap: () {
                                                          if (filteredPromosOngoing[
                                                                      index]
                                                                  .produk !=
                                                              null) {
                                                            ref
                                                                .read(promoItemSelectionNotifierProvider
                                                                    .notifier)
                                                                .selectProduct(
                                                                    filteredPromosOngoing[
                                                                            index]
                                                                        .produk!);

                                                            ref
                                                                .read(promoSelectionNotifierProvider
                                                                    .notifier)
                                                                .selectPromo(
                                                                    filteredPromosOngoing[
                                                                        index]);
                                                            Routemaster.of(
                                                                    context)
                                                                .push(
                                                                    '/internal-account/profile-toko/promosi/edit');
                                                          }
                                                        },
                                                        child: Material(
                                                          elevation: 5,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          child: const CircleAvatar(
                                                              radius: 17,
                                                              child: Icon(AntIcons
                                                                  .editFilled)),
                                                        ),
                                                      ),
                                                    ]),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      );
                                    }),
                              ]),
                            );
                          }
                        });
                      },
                      error: (error, stackTrace) => const SizedBox.shrink(),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()))),
            ),
            SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ref.watch(fetchPromoProvider).when(
                      data: (data) {
                        return data.match(
                            (l) => Center(
                                child: Text(l.message,
                                    style: appStyle(
                                        size: 16,
                                        color: mainBlack,
                                        fw: FontWeight.w600))), (r) {
                          final filteredPromosExpired = r.where((element) {
                            return (element.expiredAt ?? DateTime.now())
                                .isBefore(DateTime.now());
                          }).toList();

                          if (filteredPromosExpired.isEmpty) {
                            return Center(
                                child: Text(
                                    "Tidak ada promo yang sudah expired",
                                    style: appStyle(
                                        size: 16,
                                        color: mainBlack,
                                        fw: FontWeight.w600)));
                          } else {
                            return SingleChildScrollView(
                              child: Column(children: [
                                ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: filteredPromosExpired.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 5),
                                        child: Card(
                                          surfaceTintColor: Colors.white,
                                          elevation: 5,
                                          child: ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 10),
                                            title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(Icons
                                                          .discount_outlined),
                                                      const SizedBox(width: 5),
                                                      Text(
                                                          "${filteredPromosExpired[index].discountPercent}% OFF",
                                                          style: appStyle(
                                                              size: 12,
                                                              color: mainBlack,
                                                              fw: FontWeight
                                                                  .w600)),
                                                      const Spacer(),
                                                      Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        (filteredPromosExpired[
                                                                            index]
                                                                        .produk
                                                                        ?.promo !=
                                                                    null &&
                                                                (filteredPromosExpired[index]
                                                                            .produk
                                                                            ?.promo
                                                                            ?.expiredAt ??
                                                                        DateTime
                                                                            .now())
                                                                    .isAfter(
                                                                        DateTime
                                                                            .now()))
                                                            ? "Expires: ${DateTimeHourMin.durationBetween(DateTime.now(), filteredPromosExpired[index].expiredAt!)}"
                                                            : "Expired At: ${filteredPromosExpired[index].expiredAt?.formatDatePDF()}",
                                                        style: appStyle(
                                                          size: 12,
                                                          color: mainBlack,
                                                          fw: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5),
                                                  IntrinsicHeight(
                                                    child: Row(children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Image.network(
                                                            filteredPromosExpired[
                                                                        index]
                                                                    .produk
                                                                    ?.produkGlobalImages
                                                                    .first
                                                                    .globalImageUrl ??
                                                                "",
                                                            fit: BoxFit.contain,
                                                            width: 70),
                                                      ),
                                                      const SizedBox(width: 15),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                filteredPromosExpired[
                                                                            index]
                                                                        .produk
                                                                        ?.name ??
                                                                    "No name",
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: appStyle(
                                                                    size: 14,
                                                                    color:
                                                                        mainBlack,
                                                                    fw: FontWeight
                                                                        .w600)),
                                                            Text(
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              "Ukuran: ${filteredPromosExpired[index].produk?.produkSizes.map((e) => e.name).toList().getConcatenatedList()}",
                                                              style: appStyle(
                                                                size: 11,
                                                                color:
                                                                    mainBlack,
                                                                fw: FontWeight
                                                                    .w500,
                                                              ),
                                                            ),
                                                            Text(
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              "Warna: ${filteredPromosExpired[index].produk?.produkColors.map((e) => e.name).toList().getConcatenatedList()}",
                                                              style: appStyle(
                                                                size: 11,
                                                                color:
                                                                    mainBlack,
                                                                fw: FontWeight
                                                                    .w500,
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  PriceFormatter
                                                                      .getFormattedValue(
                                                                          filteredPromosExpired[index].produk?.price ??
                                                                              0),
                                                                  style:
                                                                      appStyle(
                                                                    size: 14,
                                                                    color:
                                                                        mainBlack,
                                                                    fw: FontWeight
                                                                        .bold,
                                                                  ).copyWith(
                                                                          decoration: TextDecoration
                                                                              .lineThrough,
                                                                          decorationThickness:
                                                                              2),
                                                                ),
                                                                const SizedBox(
                                                                    width: 5),
                                                                Text(
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  PriceFormatter.getFormattedValue((filteredPromosExpired[index]
                                                                              .produk
                                                                              ?.price ??
                                                                          0) -
                                                                      (filteredPromosExpired[index].produk?.price ??
                                                                              0) *
                                                                          ((filteredPromosExpired[index].discountPercent?.toInt() ?? 0) /
                                                                              100)),
                                                                  style:
                                                                      appStyle(
                                                                    size: 14,
                                                                    color:
                                                                        mainBlack,
                                                                    fw: FontWeight
                                                                        .bold,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(width: 20),
                                                      GestureDetector(
                                                        onTap: () {
                                                          if (filteredPromosExpired[
                                                                      index]
                                                                  .produk !=
                                                              null) {
                                                            ref
                                                                .read(promoItemSelectionNotifierProvider
                                                                    .notifier)
                                                                .selectProduct(
                                                                    filteredPromosExpired[
                                                                            index]
                                                                        .produk!);

                                                            ref
                                                                .read(promoSelectionNotifierProvider
                                                                    .notifier)
                                                                .selectPromo(
                                                                    filteredPromosExpired[
                                                                        index]);
                                                            Routemaster.of(
                                                                    context)
                                                                .push(
                                                                    '/internal-account/profile-toko/promosi/edit');
                                                          }
                                                        },
                                                        child: Material(
                                                          elevation: 5,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          child: const CircleAvatar(
                                                              radius: 17,
                                                              child: Icon(AntIcons
                                                                  .editFilled)),
                                                        ),
                                                      ),
                                                    ]),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      );
                                    }),
                              ]),
                            );
                          }
                        });
                      },
                      error: (error, stackTrace) => const SizedBox.shrink(),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()))),
            ),
          ],
        ));
  }
}
