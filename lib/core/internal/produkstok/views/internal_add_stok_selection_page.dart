import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_stok_selection_notifier.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/repositories/implementations/produk_stok_repository_impl.dart';
import 'package:tugas_akhir_project/utils/extensions/date_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/double_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/list_extension.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class InternalAddStokProdukSelection extends ConsumerWidget {
  const InternalAddStokProdukSelection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final produksInformation = ref.watch(fetchProducts);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pilih Produk",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: produksInformation.maybeWhen(
                data: (data) {
                  return data.match(
                      (l) => Center(
                          child: Text(l.message,
                              style: appStyle(
                                  size: 16,
                                  color: mainBlack,
                                  fw: FontWeight.w600))), (r) {
                    if (r.isNotEmpty) {
                      return SingleChildScrollView(
                        child: Column(children: [
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: r.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(
                                            productStokSelectionNotifierProvider
                                                .notifier)
                                        .selectProduk(r[index]);
                                    //navigate to stok page
                                    Routemaster.of(context).push(
                                        '/internal-dashboard/produkstok/add-stok/selection');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 5),
                                    child: Card(
                                      surfaceTintColor: Colors.white,
                                      elevation: 5,
                                      child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                        title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (r[index].promo != null &&
                                                  (r[index].promo?.expiredAt ??
                                                          DateTime.now())
                                                      .isAfter(DateTime.now()))
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.discount_outlined,
                                                        size: 20),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                        "${r[index].promo?.discountPercent}% OFF",
                                                        style: appStyle(
                                                            size: 12,
                                                            color: mainBlack,
                                                            fw: FontWeight
                                                                .w600)),
                                                    const Spacer(),
                                                    Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      "Expires: ${DateTimeHourMin.durationBetween(DateTime.now(), r[index].promo!.expiredAt!)}",
                                                      style: appStyle(
                                                        size: 12,
                                                        color: mainBlack,
                                                        fw: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              const SizedBox(height: 5),
                                              Row(children: [
                                                Text(
                                                    "Stok: ${r[index].stok?.totalAmount ?? 0}",
                                                    style: appStyle(
                                                        size: 16,
                                                        color: mainBlack,
                                                        fw: FontWeight.w600))
                                              ]),
                                              const SizedBox(height: 10),
                                              IntrinsicHeight(
                                                child: Row(children: [
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: CachedNetworkImage(
                                                        imageUrl: r[index]
                                                            .produkGlobalImages[
                                                                0]
                                                            .globalImageUrl,
                                                        width: 80,
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit
                                                                  .contain,
                                                              image:
                                                                  imageProvider,
                                                            ),
                                                          ),
                                                        ),
                                                        // placeholder: (context,
                                                        //         url) =>
                                                        //     const CircularProgressIndicator(),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                      )),
                                                  const SizedBox(width: 15),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            r[index].name ??
                                                                "No name",
                                                            style: appStyle(
                                                                size: 14,
                                                                color:
                                                                    mainBlack,
                                                                fw: FontWeight
                                                                    .w600)),
                                                        Text(
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          "Ukuran: ${r[index].produkSizes.map((e) => e.name).toList().getConcatenatedList()}",
                                                          style: appStyle(
                                                            size: 12,
                                                            color: mainBlack,
                                                            fw: FontWeight.w500,
                                                          ),
                                                        ),
                                                        Text(
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          "Warna: ${r[index].produkColors.map((e) => e.name).toList().getConcatenatedList()}",
                                                          style: appStyle(
                                                            size: 12,
                                                            color: mainBlack,
                                                            fw: FontWeight.w500,
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
                                                                      r[index].price ??
                                                                          0),
                                                              style: appStyle(
                                                                size: 16,
                                                                color:
                                                                    mainBlack,
                                                                fw: FontWeight
                                                                    .bold,
                                                              ).copyWith(
                                                                  decoration: r[index].promo !=
                                                                              null &&
                                                                          (r[index].promo?.expiredAt ?? DateTime.now()).isAfter(DateTime
                                                                              .now())
                                                                      ? TextDecoration
                                                                          .lineThrough
                                                                      : TextDecoration
                                                                          .none,
                                                                  decorationThickness:
                                                                      2),
                                                            ),
                                                            const SizedBox(
                                                                width: 10),
                                                            if (r[index].promo !=
                                                                    null &&
                                                                (r[index]
                                                                            .promo
                                                                            ?.expiredAt ??
                                                                        DateTime
                                                                            .now())
                                                                    .isAfter(
                                                                        DateTime
                                                                            .now()))
                                                              Text(
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                PriceFormatter.getFormattedValue((r[index]
                                                                            .price ??
                                                                        0) -
                                                                    (r[index].price ??
                                                                            0) *
                                                                        ((r[index].promo?.discountPercent?.toInt() ??
                                                                                0) /
                                                                            100)),
                                                                style: appStyle(
                                                                  size: 16,
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
                                                  const Icon(
                                                      Icons.chevron_right,
                                                      size: 30),
                                                ]),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ]),
                      );
                    } else {
                      return Center(
                          child: Text(
                              "Produk tidak ada, Silakan tambahkan produk",
                              style: appStyle(
                                  size: 16,
                                  color: mainBlack,
                                  fw: FontWeight.w600)));
                    }
                  });
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                orElse: () => const SizedBox.shrink())),
      ),
    );
  }
}
