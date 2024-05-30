import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';
import 'package:tugas_akhir_project/core/customer/cart/repositories/implementations/customer_cart_repository_impl.dart';
import 'package:tugas_akhir_project/core/customer/cart/widgets/customer_cart_item.dart';
import 'package:tugas_akhir_project/utils/extensions/double_extension.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class CustomerCartPage extends ConsumerWidget {
  const CustomerCartPage({super.key});

  void countPrice() {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartInformation = ref.watch(fetchCart);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Keranjang",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: cartInformation.maybeWhen(
          data: (data) {
            return data.match(
                (l) => Center(
                        child: Text(
                      "Tidak ada barang di keranjang Anda!",
                      textAlign: TextAlign.center,
                      style: appStyle(
                          size: 18, color: mainBlack, fw: FontWeight.w600),
                    )), (r) {
              if (r?.cartItemList.isEmpty ?? true) {
                return Center(
                    child: Text(
                  "Tidak ada barang di keranjang Anda!",
                  textAlign: TextAlign.center,
                  style:
                      appStyle(size: 18, color: mainBlack, fw: FontWeight.w600),
                ));
              } else {
                return SlidingUpPanel(
                  borderRadius: BorderRadius.circular(10),
                  minHeight: 130,
                  isDraggable: false,
                  panelBuilder: () => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total:",
                                  style: appStyle(
                                    size: 18,
                                    color: mainBlack,
                                    fw: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  PriceFormatter.getFormattedValue(r!.cartItemList
                                      .map((e) =>
                                          (e.amount ?? 0) *
                                          ((e.produkCombination?.product?.promo == null ||
                                                      (e
                                                                  .produkCombination
                                                                  ?.product
                                                                  ?.promo
                                                                  ?.expiredAt ??
                                                              DateTime.now())
                                                          .isBefore(
                                                              DateTime.now())
                                                  ? e.produkCombination?.product
                                                          ?.price ??
                                                      0
                                                  : (e.produkCombination?.product?.price ?? 0) -
                                                      (e.produkCombination?.product?.price ?? 0) *
                                                          ((e.produkCombination?.product?.promo?.discountPercent?.toInt() ?? 0) / 100))
                                              .toDouble()))
                                      .toList()
                                      .reduce((value, element) => value + element)),
                                  style: appStyle(
                                    size: 20,
                                    color: mainBlack,
                                    fw: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (r.cartItemList.isNotEmpty) {
                                  Routemaster.of(context)
                                      .push("/customer-account/cart/checkout");
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                backgroundColor: Colors.greenAccent,
                              ),
                              child: Text(
                                "Pesan Sekarang",
                                style: appStyle(
                                    size: 16,
                                    color: Colors.white,
                                    fw: FontWeight.w500),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  backdropEnabled: false,
                  body: SafeArea(
                    child: ListView.builder(
                        itemCount: r?.cartItemList.length,
                        itemBuilder: (context, index) {
                          return CustomerCartItem(
                              cartItem: r?.cartItemList[index]);
                        }),
                  ),
                );
              }
            });
          },
          loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
          orElse: () => const SizedBox.shrink()),
    );
  }
}
