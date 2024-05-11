import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tugas_akhir_project/core/customer/cart/repositories/implementations/customer_cart_repository_impl.dart';
import 'package:tugas_akhir_project/core/customer/cart/viewmodels/customer_cart_viewmodel.dart';
import 'package:tugas_akhir_project/models/cartitem.dart';
import 'package:tugas_akhir_project/utils/extensions/date_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/double_extension.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class CustomerCartItem extends ConsumerWidget {
  final CartItem? cartItem;
  const CustomerCartItem({
    super.key,
    this.cartItem,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
      child: Card(
        surfaceTintColor: Colors.white,
        elevation: 5,
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          title: Column(children: [
            if (cartItem?.produkCombination?.product?.promo != null &&
                (cartItem?.produkCombination?.product?.promo?.expiredAt ??
                        DateTime.now())
                    .isAfter(DateTime.now()))
              Row(
                children: [
                  const Icon(Icons.discount_outlined),
                  const SizedBox(width: 5),
                  Text(
                      "${cartItem?.produkCombination?.product?.promo?.discountPercent}% OFF",
                      style: appStyle(
                          size: 12, color: mainBlack, fw: FontWeight.w600)),
                  const Spacer(),
                  Text(
                    textAlign: TextAlign.center,
                    "Expires: ${DateTimeHourMin.durationBetween(DateTime.now(), cartItem?.produkCombination?.product?.promo?.expiredAt ?? DateTime.now())}",
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
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: cartItem
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
                          cartItem?.produkCombination?.product?.name ??
                              "No name",
                          style: appStyle(
                              size: 14, color: mainBlack, fw: FontWeight.w600)),
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        "Size: ${cartItem?.produkCombination?.size?.name ?? "No Size"}",
                        style: appStyle(
                          size: 12,
                          color: mainBlack,
                          fw: FontWeight.w500,
                        ),
                      ),
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        "Warna: ${cartItem?.produkCombination?.color?.name ?? "No Color"}",
                        style: appStyle(
                          size: 12,
                          color: mainBlack,
                          fw: FontWeight.w500,
                        ),
                      ),
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        "Toko: ${cartItem?.produkCombination?.product?.toko?.name ?? "No Name"}",
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
                                (cartItem?.amount ?? 0) *
                                    ((cartItem?.produkCombination?.product
                                                ?.price ??
                                            0)
                                        .toDouble())),
                            style: appStyle(
                              size: 14,
                              color: mainBlack,
                              fw: FontWeight.bold,
                            ).copyWith(
                                decoration: cartItem?.produkCombination?.product
                                                ?.promo !=
                                            null &&
                                        (cartItem?.produkCombination?.product
                                                    ?.promo?.expiredAt ??
                                                DateTime.now())
                                            .isAfter(DateTime.now())
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                decorationThickness: 2),
                          ),
                          const SizedBox(width: 10),
                          if (cartItem?.produkCombination?.product?.promo !=
                                  null &&
                              (cartItem?.produkCombination?.product?.promo
                                          ?.expiredAt ??
                                      DateTime.now())
                                  .isAfter(DateTime.now()))
                            Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              PriceFormatter.getFormattedValue((cartItem
                                          ?.amount ??
                                      0) *
                                  ((cartItem?.produkCombination?.product?.promo ==
                                              null
                                          ? cartItem?.produkCombination?.product
                                                  ?.price ??
                                              0
                                          : (cartItem?.produkCombination
                                                      ?.product?.price ??
                                                  0) -
                                              (cartItem?.produkCombination
                                                          ?.product?.price ??
                                                      0) *
                                                  ((cartItem
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (cartItem != null) {
                          ref
                              .read(customerCartViewModelProvider.notifier)
                              .decreaseItemQuantityCartItem(
                                  cartItemId: cartItem!.id);

                          ref.invalidate(fetchCart);
                        }
                      },
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(20),
                        child: CircleAvatar(
                            radius: 17,
                            child: Icon((cartItem?.amount ?? 0) == 1
                                ? AntIcons.deleteFilled
                                : AntIcons.minusOutlined)),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      cartItem?.amount.toString() ?? "0",
                      style: appStyle(
                        size: 16,
                        color: mainBlack,
                        fw: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: (cartItem != null &&
                              ((cartItem!.amount ?? 0) <
                                  (cartItem!.produkCombination?.variantAmount ??
                                      0)))
                          ? () {
                              ref
                                  .read(customerCartViewModelProvider.notifier)
                                  .increaseItemQuantityCartItem(
                                      cartItemId: cartItem!.id);
                              ref.invalidate(fetchCart);
                            }
                          : null,
                      child: Opacity(
                        opacity: (cartItem != null &&
                                ((cartItem!.amount ?? 0) <
                                    (cartItem!
                                            .produkCombination?.variantAmount ??
                                        0)))
                            ? 1
                            : 0,
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(20),
                          child: const CircleAvatar(
                            radius: 17,
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.purple,
                            child: Icon(Icons.add_outlined),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
