import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/customer/wishlist/repositories/implementations/customer_wishlist_repository_impl.dart';
import 'package:tugas_akhir_project/core/customer/wishlist/viewmodels/customer_wishlist_viewmodel.dart';
import 'package:tugas_akhir_project/utils/extensions/double_extension.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class CustomerWishlistPage extends ConsumerWidget {
  const CustomerWishlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistInformation = ref.watch(fetchWishlist);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Wishlist",
            style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: wishlistInformation.maybeWhen(
            data: (data) {
              return data.match(
                  (l) => Center(
                          child: Text(
                        "Tidak ada produk dalam wishlist Anda!",
                        style: appStyle(
                            size: 18, color: mainBlack, fw: FontWeight.w600),
                      )), (r) {
                return r!.produkList.isEmpty
                    ? Center(
                        child: Text(
                        "Tidak ada produk dalam wishlist Anda",
                        style: appStyle(
                            size: 18, color: mainBlack, fw: FontWeight.w600),
                      ))
                    : Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Expanded(
                          child: GridView.builder(
                              itemCount: r.produkList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 0.55),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Routemaster.of(context).push('/customer-account/wishlist/produk/${r.produkList[index].toko?.id}/${r.produkList[index].id}');
                                  },
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
                                                    if (r.produkList[index]
                                                                .promo !=
                                                          null &&
                                                        (r
                                                                    .produkList[
                                                                        index]
                                                                    .promo
                                                                    ?.expiredAt ??
                                                                DateTime.now())
                                                            .isAfter(
                                                                DateTime.now()))
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
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
                                                                    vertical:
                                                                        6.0,
                                                                    horizontal:
                                                                        10),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    "${r.produkList[index].promo?.discountPercent}% OFF",
                                                                    style: appStyle(
                                                                        size:
                                                                            13,
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
                                                  GestureDetector(
                                                    onTap: () {
                                                      ref
                                                          .read(
                                                              customerWishlistViewModelProvider
                                                                  .notifier)
                                                          .removeProdukFromWishlist(
                                                              produkId: r
                                                                  .produkList[
                                                                      index]
                                                                  .id!);
                                                      ref.invalidate(
                                                          fetchWishlist);
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.red,
                                                      radius: 14.r,
                                                      child: Icon(
                                                          AntIcons.deleteFilled,
                                                          size: 16,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: ClipRRect(
                                                child: SizedBox(
                                                    width: double.infinity,
                                                    child: CachedNetworkImage(
                                                      imageUrl: r
                                                          .produkList[index]
                                                          .produkGlobalImages[0]
                                                          .globalImageUrl,
                                                      width: 44.w,
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: imageProvider,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      // placeholder: (context,
                                                      //         url) =>
                                                      //     const CircularProgressIndicator(),
                                                      errorWidget: (context, url,
                                                              error) =>
                                                          const Icon(Icons.error),
                                                    )),
                                              ),
                                            ),
                                            SizedBox(height: 10.h),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        r.produkList[index]
                                                                .name ??
                                                            "No Name",
                                                        maxLines: 2,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        style: appStyle(
                                                            size: 16,
                                                            color: mainBlack,
                                                            fw: FontWeight.w600),
                                                        textAlign:
                                                            TextAlign.center),
                                                    SizedBox(height: 5.h),
                                                    Text(
                                                      PriceFormatter.getFormattedValue(r
                                                                      .produkList[
                                                                          index]
                                                                      .promo ==
                                                                  null ||
                                                              (r.produkList[index].promo?.expiredAt ?? DateTime.now()).isBefore(
                                                                  DateTime.now())
                                                          ? r.produkList[index]
                                                                  .price ??
                                                              0
                                                          : (r.produkList[index]
                                                                      .price ??
                                                                  0) -
                                                              (r.produkList[index]
                                                                          .price ??
                                                                      0) *
                                                                  (r
                                                                          .produkList[index]
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
                                                    // if (r.produkList[index].rating
                                                    //     != null)
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          RatingBar.builder(
                                                            ignoreGestures: true,
                                                            itemSize: 16,
                                                            initialRating: r.produkList[index].averageRating ?? 0,
                                                            minRating: 0,
                                                            direction:
                                                                Axis.horizontal,
                                                            allowHalfRating: true,
                                                            itemCount: 5,
                                                            itemPadding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        2.0),
                                                            itemBuilder:
                                                                (context, _) =>
                                                                    const Icon(
                                                              Icons.star,
                                                              color: Colors.amber,
                                                            ),
                                                            onRatingUpdate:
                                                                (rating) {},
                                                          ),
                                                          SizedBox(
                                                              width: 5.w),
                                                          Text(
                                                              "(${r.produkList[index].averageRating?.toStringAsPrecision(2) ?? 0})",
                                                              style: appStyle(
                                                                  size: 13,
                                                                  color:
                                                                      mainBlack,
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
                        ),
                      );
              });
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            orElse: () => null));
  }
}
