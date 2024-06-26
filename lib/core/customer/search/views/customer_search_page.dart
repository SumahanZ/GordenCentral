import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/customer/search/repositories/implementations/customer_search_repository_impl.dart';
import 'package:tugas_akhir_project/core/customer/search/widgets/modal_search_filter_widget.dart';
import 'package:tugas_akhir_project/utils/extensions/double_extension.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class CustomerSearchPage extends ConsumerStatefulWidget {
  const CustomerSearchPage({super.key});

  @override
  ConsumerState<CustomerSearchPage> createState() => _CustomerSearchPageState();
}

class _CustomerSearchPageState extends ConsumerState<CustomerSearchPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
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
          "Search Produk",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const ModalSearchFilter();
                    });
              },
              child: Row(
                children: [
                  const Icon(AntIcons.filterOutlined),
                  SizedBox(width: 5.w),
                  Text("Filter",
                      style: appStyle(
                          size: 14, color: mainBlack, fw: FontWeight.w500)),
                ],
              ),
            ),
          )
        ],
      ),
      body: ref.watch(fetchAllProductsSearch).maybeWhen(
          data: (data) {
            return data.match(
                (l) => Center(
                    child: Text(l.message,
                        style: appStyle(
                            size: 16,
                            color: mainBlack,
                            fw: FontWeight.w600))), (r) {
              return r.isEmpty
                  ? Center(
                      child: Text("Tidak ada produk yang ditemukan",
                          style: appStyle(
                              size: 16, color: mainBlack, fw: FontWeight.w600)))
                  : Expanded(
                      child: GridView.builder(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 12),
                          itemCount: r.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.55),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => Routemaster.of(context).push(
                                  '/customer-search/produk/${r[index].toko?.id}/${r[index].id}'),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Card(
                                  surfaceTintColor: Colors.white,
                                  elevation: 5,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            children: [
                                              Row(children: [
                                                if (r[index].promo != null &&
                                                    (r[index]
                                                                .promo
                                                                ?.expiredAt ??
                                                            DateTime.now())
                                                        .isAfter(
                                                            DateTime.now()))
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: DecoratedBox(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors
                                                            .deepPurpleAccent,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 6.0,
                                                                horizontal: 10),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                "${r[index].promo?.discountPercent}% OFF",
                                                                style: appStyle(
                                                                    size: 13,
                                                                    color: Colors
                                                                        .white,
                                                                    fw: FontWeight
                                                                        .w600)),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ]),
                                              const Spacer(),
                                              if ((DateTime.now()).isBefore(
                                                  (r[index].createdAt ??
                                                          DateTime.now())
                                                      .add(const Duration(
                                                          days: 7))))
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: DecoratedBox(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.red,
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 6.0,
                                                          horizontal: 10),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text("BARU",
                                                              style: appStyle(
                                                                  size: 13,
                                                                  color: Colors
                                                                      .white,
                                                                  fw: FontWeight
                                                                      .w600)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: SizedBox(
                                              width: double.infinity,
                                              child: CachedNetworkImage(
                                                imageUrl: r[index]
                                                    .produkGlobalImages[0]
                                                    .globalImageUrl,
                                                height: 120.h,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              )),
                                        ),
                                        SizedBox(height: 10.h),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(r[index].name ?? "No Name",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: appStyle(
                                                        size: 14,
                                                        color: mainBlack,
                                                        fw: FontWeight.w600),
                                                    textAlign:
                                                        TextAlign.center),
                                                SizedBox(height: 5.h),
                                                Text(
                                                  PriceFormatter.getFormattedValue(r[
                                                                      index]
                                                                  .promo ==
                                                              null ||
                                                          (r[index]
                                                                      .promo
                                                                      ?.expiredAt ??
                                                                  DateTime
                                                                      .now())
                                                              .isBefore(DateTime
                                                                  .now())
                                                      ? r[index].price ?? 0
                                                      : (r[index].price ?? 0) -
                                                          (r[index].price ??
                                                                  0) *
                                                              (r[index]
                                                                      .promo!
                                                                      .discountPercent!
                                                                      .toInt() /
                                                                  100)),
                                                  style: appStyle(
                                                      size: 18,
                                                      color: mainBlack,
                                                      fw: FontWeight.bold),
                                                ),
                                                SizedBox(height: 5.h),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    RatingBar.builder(
                                                      ignoreGestures: true,
                                                      itemSize: 16,
                                                      initialRating: r[index]
                                                              .averageRating ??
                                                          0,
                                                      minRating: 0,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 2.0),
                                                      itemBuilder:
                                                          (context, _) =>
                                                              const Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      onRatingUpdate:
                                                          (rating) {},
                                                    ),
                                                    SizedBox(width: 5.w),
                                                    Text(
                                                        "(${r[index].averageRating?.toStringAsPrecision(2) ?? 0})",
                                                        style: appStyle(
                                                            size: 13,
                                                            color: mainBlack,
                                                            fw: FontWeight
                                                                .w600)),
                                                  ],
                                                ),
                                                SizedBox(height: 5.h),
                                              ],
                                            ),
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            );
                          }),
                    );
            });
          },
          orElse: () => const SizedBox.shrink(),
          loading: () => Center(child: const CircularProgressIndicator())),
    );
  }
}
