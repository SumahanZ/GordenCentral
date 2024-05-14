import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/customer/cart/repositories/implementations/customer_cart_repository_impl.dart';
import 'package:tugas_akhir_project/core/customer/cart/viewmodels/customer_cart_viewmodel.dart';
import 'package:tugas_akhir_project/core/customer/cart/widgets/customer_checkout_cart_item.dart';
import 'package:tugas_akhir_project/models/invoice.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';
import 'package:tugas_akhir_project/utils/extensions/double_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/string_extension.dart';
import 'package:tugas_akhir_project/utils/methods/utilmethods.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerCartCheckoutPage extends ConsumerWidget {
  const CustomerCartCheckoutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartInformation = ref.watch(fetchCart);

    ref.listen(customerCartViewModelProvider, (_, state) {
      if (state is AsyncData<void>) {
        showPopupModal(
            context: context,
            title: "Berhasil",
            info: DialogType.success,
            animType: AnimType.scale,
            desc: "Berhasil membuat permintaan pesanan!",
            onOkPress: () {
              Routemaster.of(context).replace('/customer-account');
            });
      } else if (state is AsyncError && state.error is ResponseAPIError) {
        showPopupModal(
            context: context,
            title: "Peringatan",
            info: DialogType.error,
            animType: AnimType.scale,
            desc: "Kesalahan respons telah terjadi!",
            onOkPress: () {
              // Routemaster.of(context).pop();
            });
      } else if (state is AsyncError && state.error is RequestError) {
        showPopupModal(
            context: context,
            title: "Peringatan",
            info: DialogType.error,
            animType: AnimType.scale,
            desc: (state.error as RequestError).errorMessage,
            onOkPress: () {
              // Routemaster.of(context).pop();
            });
      } else if (state is AsyncError) {
        showPopupModal(
            context: context,
            title: "Peringatan",
            info: DialogType.error,
            animType: AnimType.scale,
            desc: (state.error as ApiError).message,
            onOkPress: () {
              // Routemaster.of(context).pop();
            });
      }
    });
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Checkout",
            style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: cartInformation.maybeWhen(
            data: (data) {
              return data.match(
                  (l) => Center(
                      child: Text(l.message,
                          style: appStyle(
                              size: 16,
                              color: mainBlack,
                              fw: FontWeight.w600))), (r) {
                return !ref.watch(customerCartViewModelProvider).isLoading
                    ? SafeArea(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Total Barang:",
                                        style: appStyle(
                                            size: 18,
                                            color: mainBlack,
                                            fw: FontWeight.w600)),
                                    SizedBox(width: 5.w),
                                    Text(
                                        "${r?.cartItemList.map((e) => e.amount).reduce((value, element) => value! + element!)}",
                                        style: appStyle(
                                            size: 18,
                                            color: mainBlack,
                                            fw: FontWeight.w600)),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: r?.cartItemList.length,
                                  itemBuilder: (context, index) {
                                    return CustomerCheckoutCartItem(
                                      cartItem: r?.cartItemList[index],
                                    );
                                  },
                                ),
                                SizedBox(height: 20.h),
                                Card(
                                  surfaceTintColor: Colors.white,
                                  elevation: 5,
                                  child: ExpansionTile(
                                    title: Text("Alamat Pengiriman",
                                        style: appStyle(
                                            size: 16,
                                            color: mainBlack,
                                            fw: FontWeight.w600)),
                                    subtitle: Text(
                                      "${r?.customer?.address?.streetAddress}",
                                      style: appStyle(
                                          size: 15,
                                          color: mainBlack,
                                          fw: FontWeight.w500),
                                    ),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 0, 15, 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Kota",
                                                  style: appStyle(
                                                      size: 14,
                                                      color: mainBlack,
                                                      fw: FontWeight.w500),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  "${r?.customer?.address?.city?.name.toTitleCase()}",
                                                  style: appStyle(
                                                      size: 14,
                                                      color: mainBlack,
                                                      fw: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10.h),
                                            Row(
                                              children: [
                                                Text(
                                                  "Provinsi",
                                                  style: appStyle(
                                                      size: 14,
                                                      color: mainBlack,
                                                      fw: FontWeight.w500),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  "${r?.customer?.address?.city?.province?.name.toTitleCase()}",
                                                  style: appStyle(
                                                      size: 14,
                                                      color: mainBlack,
                                                      fw: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10.h),
                                            Row(
                                              children: [
                                                Text(
                                                  "Negara",
                                                  style: appStyle(
                                                      size: 14,
                                                      color: mainBlack,
                                                      fw: FontWeight.w500),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  "${r?.customer?.address?.country?.toTitleCase()}",
                                                  style: appStyle(
                                                      size: 14,
                                                      color: mainBlack,
                                                      fw: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10.h),
                                            Row(
                                              children: [
                                                Text(
                                                  "Kode Pos",
                                                  style: appStyle(
                                                      size: 14,
                                                      color: mainBlack,
                                                      fw: FontWeight.w500),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  "${r?.customer?.address?.postalCode}",
                                                  style: appStyle(
                                                      size: 14,
                                                      color: mainBlack,
                                                      fw: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                Card(
                                  surfaceTintColor: Colors.white,
                                  elevation: 5,
                                  child: ExpansionTile(
                                    title: Text("Ringkasan Pesanan",
                                        style: appStyle(
                                            size: 16,
                                            color: mainBlack,
                                            fw: FontWeight.w600)),
                                    subtitle: Text(
                                        PriceFormatter.getFormattedValue(r!
                                            .cartItemList
                                            .map((e) =>
                                                (e.amount ?? 0) *
                                                ((e.produkCombination?.product?.promo ==
                                                                null ||
                                                            (e.produkCombination?.product?.promo?.expiredAt ?? DateTime.now()).isBefore(
                                                                DateTime.now())
                                                        ? e
                                                                .produkCombination
                                                                ?.product
                                                                ?.price ??
                                                            0
                                                        : (e.produkCombination?.product?.price ?? 0) -
                                                            (e.produkCombination?.product?.price ?? 0) *
                                                                ((e.produkCombination?.product?.promo?.discountPercent?.toInt() ?? 0) / 100))
                                                    .toDouble()))
                                            .toList()
                                            .reduce((value, element) => value + element)),
                                        style: appStyle(size: 16, color: mainBlack, fw: FontWeight.w600)),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 0, 15, 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Subtotal (${r.cartItemList.map((e) => e.amount).reduce((value, element) => value! + element!)} barang)",
                                                  style: appStyle(
                                                      size: 14,
                                                      color: mainBlack,
                                                      fw: FontWeight.w500),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  PriceFormatter.getFormattedValue(r
                                                      .cartItemList
                                                      .map((e) =>
                                                          (e.amount ?? 0) *
                                                          (e
                                                                  .produkCombination
                                                                  ?.product
                                                                  ?.price ??
                                                              0.toDouble()))
                                                      .toList()
                                                      .reduce(
                                                          (value, element) =>
                                                              value + element)),
                                                  style: appStyle(
                                                      size: 14,
                                                      color: mainBlack,
                                                      fw: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10.h),
                                            Row(
                                              children: [
                                                Text(
                                                  "Total Diskon",
                                                  style: appStyle(
                                                      size: 14,
                                                      color: mainBlack,
                                                      fw: FontWeight.w500),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  "- ${PriceFormatter.getFormattedValue(r.cartItemList.map((e) {
                                                        double discount = 0;

                                                        if (e
                                                                    .produkCombination
                                                                    ?.product
                                                                    ?.promo !=
                                                                null &&
                                                            (e
                                                                        .produkCombination
                                                                        ?.product
                                                                        ?.promo
                                                                        ?.expiredAt ??
                                                                    DateTime
                                                                        .now())
                                                                .isAfter(DateTime
                                                                    .now())) {
                                                          double discountPercent = e
                                                                  .produkCombination
                                                                  ?.product
                                                                  ?.promo
                                                                  ?.discountPercent
                                                                  ?.toDouble() ??
                                                              0;
                                                          double itemPrice = e
                                                                  .produkCombination
                                                                  ?.product
                                                                  ?.price
                                                                  ?.toDouble() ??
                                                              0;
                                                          double
                                                              discountedPrice =
                                                              itemPrice *
                                                                  (discountPercent /
                                                                      100);
                                                          discount =
                                                              discountedPrice *
                                                                  (e.amount ??
                                                                      0);
                                                        }

                                                        return discount;
                                                      }).toList().reduce((value, element) => value + element))}",
                                                  style: appStyle(
                                                      size: 14,
                                                      color: mainBlack,
                                                      fw: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5.h),
                                            Divider(
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                            SizedBox(height: 5.h),
                                            Row(
                                              children: [
                                                Text(
                                                  "Total Keseluruhan",
                                                  style: appStyle(
                                                      size: 15,
                                                      color: mainBlack,
                                                      fw: FontWeight.bold),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  PriceFormatter.getFormattedValue(r
                                                      .cartItemList
                                                      .map((e) =>
                                                          (e.amount ?? 0) *
                                                          ((e.produkCombination?.product?.promo == null || (e.produkCombination?.product?.promo?.expiredAt ?? DateTime.now()).isBefore(DateTime.now())
                                                                  ? e
                                                                          .produkCombination
                                                                          ?.product
                                                                          ?.price ??
                                                                      0
                                                                  : (e.produkCombination?.product?.price ??
                                                                          0) -
                                                                      (e.produkCombination?.product?.price ??
                                                                              0) *
                                                                          ((e.produkCombination?.product?.promo?.discountPercent?.toInt() ?? 0) /
                                                                              100))
                                                              .toDouble()))
                                                      .toList()
                                                      .reduce((value, element) =>
                                                          value + element)),
                                                  style: appStyle(
                                                      size: 15,
                                                      color: mainBlack,
                                                      fw: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                ElevatedButton(
                                  onPressed: () async {
                                    List<Invoice> invoiceList =
                                        r.cartItemList.map((e) {
                                      return Invoice(
                                          customer: r.customer,
                                          toko: r.cartItemList[0]
                                              .produkCombination?.product?.toko,
                                          cartItem: e);
                                    }).toList();

                                    ref
                                        .read(customerCartViewModelProvider
                                            .notifier)
                                        .createOrder(
                                          cart: r,
                                          whatsAppNumber: r
                                                  .cartItemList
                                                  .first
                                                  .produkCombination
                                                  ?.product
                                                  ?.toko
                                                  ?.whatsAppURL ??
                                              "",
                                          invoiceList: invoiceList,
                                          finalPriceTotal: r.cartItemList
                                              .map((e) =>
                                                  (e.amount ?? 0) *
                                                  ((e.produkCombination?.product?.promo == null || (e.produkCombination?.product?.promo?.expiredAt ?? DateTime.now()).isBefore(DateTime.now())
                                                          ? e
                                                                  .produkCombination
                                                                  ?.product
                                                                  ?.price ??
                                                              0
                                                          : (e
                                                                      .produkCombination
                                                                      ?.product
                                                                      ?.price ??
                                                                  0) -
                                                              (e.produkCombination?.product
                                                                          ?.price ??
                                                                      0) *
                                                                  ((e.produkCombination?.product?.promo?.discountPercent?.toInt() ??
                                                                          0) /
                                                                      100))
                                                      .toDouble()))
                                              .toList()
                                              .reduce((value, element) => value + element),
                                          discountAmountTotal: r.cartItemList
                                              .map((e) {
                                                double discount = 0;

                                                if (e.produkCombination?.product
                                                            ?.promo !=
                                                        null &&
                                                    (e
                                                                .produkCombination
                                                                ?.product
                                                                ?.promo
                                                                ?.expiredAt ??
                                                            DateTime.now())
                                                        .isAfter(
                                                            DateTime.now())) {
                                                  double discountPercent = e
                                                          .produkCombination
                                                          ?.product
                                                          ?.promo
                                                          ?.discountPercent
                                                          ?.toDouble() ??
                                                      0;
                                                  double itemPrice = e
                                                          .produkCombination
                                                          ?.product
                                                          ?.price
                                                          ?.toDouble() ??
                                                      0;
                                                  double discountedPrice =
                                                      itemPrice *
                                                          (discountPercent /
                                                              100);
                                                  discount = discountedPrice *
                                                      (e.amount ?? 0);
                                                }

                                                return discount;
                                              })
                                              .toList()
                                              .reduce((value, element) =>
                                                  value + element),
                                          originalPriceTotal: r.cartItemList
                                              .map((e) =>
                                                  (e.amount ?? 0) *
                                                  (e.produkCombination?.product
                                                          ?.price ??
                                                      0.toDouble()))
                                              .toList()
                                              .reduce((value, element) =>
                                                  value + element),
                                        )
                                        .then((value) => null);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 20),
                                    minimumSize: const Size.fromHeight(50),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  child: Text(
                                    "Pesan Sekarang",
                                    style: appStyle(
                                        size: 18,
                                        color: Colors.white,
                                        fw: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const Center(child: CircularProgressIndicator());
              });
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            orElse: () => const SizedBox.shrink()));
  }
}
