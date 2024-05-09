import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:tugas_akhir_project/core/customer/order/repositories/implementations/customer_order_repository_impl.dart';
// import 'package:tugas_akhir_project/core/customer/order/viewmodels/customer_order_viewmodel.dart';
import 'package:tugas_akhir_project/models/orderitem.dart';
import 'package:tugas_akhir_project/utils/extensions/double_extension.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class CustomerOrderItem extends ConsumerWidget {
  final OrderItem? orderItem;
  const CustomerOrderItem({
    super.key,
    this.orderItem,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      title: Column(children: [
        if (orderItem?.produkCombination?.product?.promo != null &&
            (orderItem?.produkCombination?.product?.promo?.expiredAt ??
                    DateTime.now())
                .isAfter(orderItem?.order?.createdAt ?? DateTime.now()))
          Row(
            children: [
              const Icon(Icons.discount_outlined),
              const SizedBox(width: 5),
              Text(
                  "${orderItem?.produkCombination?.product?.promo?.discountPercent}% OFF",
                  style: appStyle(
                      size: 12, color: mainBlack, fw: FontWeight.w600)),
            ],
          ),
        const SizedBox(height: 5),
        IntrinsicHeight(
          child: Row(children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: orderItem
                          ?.produkCombination?.color?.produkColorImageUrl ??
                      "",
                  width: 70,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  // placeholder: (context, url) =>
                  //     const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                )),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      orderItem?.produkCombination?.product?.name ??
                          "No name",
                      style: appStyle(
                          size: 14, color: mainBlack, fw: FontWeight.w600)),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    "Ukuran: ${orderItem?.produkCombination?.size?.name ?? "No Size"}",
                    style: appStyle(
                      size: 12,
                      color: mainBlack,
                      fw: FontWeight.w500,
                    ),
                  ),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    "Warna: ${orderItem?.produkCombination?.color?.name ?? "No Color"}",
                    style: appStyle(
                      size: 12,
                      color: mainBlack,
                      fw: FontWeight.w500,
                    ),
                  ),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    "Toko: ${orderItem?.produkCombination?.product?.toko?.name ?? "No Name"}",
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
                        overflow: TextOverflow.ellipsis,
                        PriceFormatter.getFormattedValue(
                            (orderItem?.amount ?? 0) *
                                ((orderItem?.produkCombination?.product
                                            ?.price ??
                                        0)
                                    .toDouble())),
                        style: appStyle(
                          size: 14,
                          color: mainBlack,
                          fw: FontWeight.bold,
                        ).copyWith(
                            decoration: orderItem?.produkCombination
                                            ?.product?.promo !=
                                        null &&
                                    (orderItem?.produkCombination?.product
                                                ?.promo?.expiredAt ??
                                            DateTime.now())
                                        .isAfter(orderItem?.order?.createdAt ?? DateTime.now())
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            decorationThickness: 2),
                      ),
                      const SizedBox(width: 10),
                      if (orderItem?.produkCombination?.product?.promo !=
                              null &&
                          (orderItem?.produkCombination?.product?.promo
                                      ?.expiredAt ??
                                  DateTime.now())
                              .isAfter(orderItem?.order?.createdAt ?? DateTime.now()))
                        Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          PriceFormatter.getFormattedValue((orderItem
                                      ?.amount ??
                                  0) *
                              ((orderItem?.produkCombination?.product
                                              ?.promo ==
                                          null
                                      ? orderItem?.produkCombination
                                              ?.product?.price ??
                                          0
                                      : (orderItem?.produkCombination
                                                  ?.product?.price ??
                                              0) -
                                          (orderItem?.produkCombination
                                                      ?.product?.price ??
                                                  0) *
                                              ((orderItem
                                                          ?.produkCombination
                                                          ?.product
                                                          ?.promo
                                                          ?.discountPercent
                                                          ?.toInt() ??
                                                      0) /
                                                  100))
                                  .toDouble())),
                          style: appStyle(
                            size: 14,
                            color: mainBlack,
                            fw: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              "${orderItem?.amount}x",
              style: appStyle(
                size: 18,
                color: mainBlack,
                fw: FontWeight.w600,
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
