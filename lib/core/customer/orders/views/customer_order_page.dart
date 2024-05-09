import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tugas_akhir_project/core/customer/orders/providers/order_detail_selection_notifier.dart';
import 'package:tugas_akhir_project/core/customer/orders/repositories/implementations/customer_order_repository_impl.dart';
import 'package:tugas_akhir_project/core/customer/orders/viewmodels/customer_order_viewmodel.dart';
import 'package:tugas_akhir_project/models/order.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';
import 'package:tugas_akhir_project/utils/extensions/date_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/double_extension.dart';
import 'package:tugas_akhir_project/utils/methods/utilmethods.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class CustomerOrderPage extends ConsumerStatefulWidget {
  const CustomerOrderPage({super.key});

  @override
  ConsumerState<CustomerOrderPage> createState() => _CustomerOrderPageState();
}

class _CustomerOrderPageState extends ConsumerState<CustomerOrderPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(customerOrderViewModelProvider, (_, state) {
      if (state is AsyncData<void>) {
        showPopupModal(
            context: context,
            title: "Berhasil",
            info: DialogType.success,
            animType: AnimType.scale,
            desc: "Berhasil membatalkan permintaan pesanan!",
            onOkPress: () {
              ref.invalidate(fetchOrders);
            });
      } else if (state is AsyncError && state.error is ResponseAPIError) {
        showPopupModal(
            context: context,
            title: "Peringatan",
            info: DialogType.error,
            animType: AnimType.scale,
            desc: (state.error as RequestError).errorMessage,
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
              Tab(text: "Diproses"),
              Tab(text: "Dibatalkan"),
              Tab(text: "Selesai")
            ],
          ),
          title: Text(
            "Pesanan",
            style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: ref.watch(fetchOrders).maybeWhen(
            data: (data) {
              return data.match(
                  (l) => Center(
                      child: Text(l.message,
                          style: appStyle(
                              size: 16,
                              color: mainBlack,
                              fw: FontWeight.w600))), (r) {
                return ref.watch(customerOrderViewModelProvider).when(
                    data: (data) {
                      return TabBarView(controller: _tabController, children: [
                        SafeArea(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                children: [
                                  _buildOrderGroup(
                                      ref: ref,
                                      context: context,
                                      orders: r,
                                      status: "Processing"),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SafeArea(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14.0),
                              child: Column(
                                children: [
                                  _buildOrderGroup(
                                      ref: ref,
                                      context: context,
                                      orders: r,
                                      status: "Cancelled"),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SafeArea(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14.0),
                              child: Column(
                                children: [
                                  _buildOrderGroup(
                                      ref: ref,
                                      context: context,
                                      orders: r,
                                      status: "Completed"),
                                ],
                              ),
                            ),
                          ),
                        )
                      ]);
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stack) {
                      return Center(child: Text(error.toString()));
                    });
              });
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            orElse: () => const SizedBox.shrink()));
  }
}

Widget _buildOrderGroup({
  required BuildContext context,
  required List<Order> orders,
  required String status,
  required WidgetRef ref,
}) {
  final filteredOrdersComplete = orders.where((element) {
    return element.status?.name == "Completed";
  }).toList();

  filteredOrdersComplete.sort((a, b) {
    int aDate = a.createdAt?.microsecondsSinceEpoch ?? 0;
    int bDate = b.createdAt?.microsecondsSinceEpoch ?? 0;
    return aDate.compareTo(bDate);
  });

  final filteredOrdersCancelled = orders.where((element) {
    return element.status?.name == "Cancelled";
  }).toList();

  filteredOrdersComplete.sort((a, b) {
    int aDate = a.createdAt?.microsecondsSinceEpoch ?? 0;
    int bDate = b.createdAt?.microsecondsSinceEpoch ?? 0;
    return aDate.compareTo(bDate);
  });

  final filteredOrdersProcessing = orders.where((element) {
    return element.status?.name != "Completed" &&
        element.status?.name != "Cancelled";
  }).toList();

  filteredOrdersComplete.sort((a, b) {
    int aDate = a.createdAt?.microsecondsSinceEpoch ?? 0;
    int bDate = b.createdAt?.microsecondsSinceEpoch ?? 0;
    return aDate.compareTo(bDate);
  });

  return (status == "Completed"
              ? filteredOrdersComplete
              : status == "Cancelled"
                  ? filteredOrdersCancelled
                  : filteredOrdersProcessing)
          .isEmpty
      ? Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.3),
            Text("Tidak ada pesanan dengan status ${status.toLowerCase()}.",
                style:
                    appStyle(size: 16, color: mainBlack, fw: FontWeight.w600), textAlign: TextAlign.center,),
          ],
        ))
      : Column(
          children: (status == "Completed"
                  ? filteredOrdersComplete
                  : status == "Cancelled"
                      ? filteredOrdersCancelled
                      : filteredOrdersProcessing)
              .map(
                (order) => Column(
                  children: [
                    Card(
                      surfaceTintColor: Colors.white,
                      elevation: 5,
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        style: ListTileStyle.list,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  child: Icon(
                                    (order.status?.name == "Completed")
                                        ? AntIcons.checkOutlined
                                        : (order.status?.name == "Cancelled")
                                            ? AntIcons.closeOutlined
                                            : AntIcons.loading3QuartersOutlined,
                                    size: 25,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("ID Pesanan: #${order.code}",
                                        style: appStyle(
                                            size: 14,
                                            color: mainBlack,
                                            fw: FontWeight.w500)),
                                    Text("${order.createdAt?.formatDate()}",
                                        style: appStyle(
                                            size: 14,
                                            color: mainBlack,
                                            fw: FontWeight.w500)),
                                  ],
                                ),
                                const Spacer(),
                                GestureDetector(
                                    onTap: () {},
                                    child: const Icon(
                                        Icons.chevron_right_outlined))
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Text(
                                  "Harga (${order.orderItemList.map((e) => e.amount).reduce((value, element) => value! + element!)} barang)",
                                  style: appStyle(
                                      size: 14,
                                      color: mainBlack,
                                      fw: FontWeight.w600),
                                ),
                                const Spacer(),
                                Text(
                                  PriceFormatter.getFormattedValue(
                                      order.finalPriceTotal),
                                  style: appStyle(
                                      size: 14,
                                      color: mainBlack,
                                      fw: FontWeight.w500),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.black.withOpacity(0.5),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Status",
                                  style: appStyle(
                                      size: 14,
                                      color: mainBlack,
                                      fw: FontWeight.w600),
                                ),
                                const Spacer(),
                                Text(
                                  order.status?.name ?? "Tidak ada status",
                                  style: appStyle(
                                      size: 14,
                                      color: mainBlack,
                                      fw: FontWeight.w500),
                                ),
                              ],
                            ),
                            Divider(color: Colors.black.withOpacity(0.5)),
                            Row(
                              children: [
                                Text(
                                  "Toko",
                                  style: appStyle(
                                      size: 14,
                                      color: mainBlack,
                                      fw: FontWeight.w600),
                                ),
                                const Spacer(),
                                Text(
                                  "${order.toko?.name}",
                                  style: appStyle(
                                      size: 14,
                                      color: mainBlack,
                                      fw: FontWeight.w500),
                                ),
                              ],
                            ),
                            if (status == "Cancelled") ...[
                              Divider(color: Colors.black.withOpacity(0.5)),
                              Row(
                                children: [
                                  Text("Cancelled At",
                                      style: appStyle(
                                          size: 14,
                                          color: mainBlack,
                                          fw: FontWeight.w600)),
                                  const Spacer(),
                                  Text("${order.cancelledAt?.formatDate()}",
                                      style: appStyle(
                                          size: 14,
                                          color: mainBlack,
                                          fw: FontWeight.w500)),
                                ],
                              ),
                            ] else if (status == "Completed") ...[
                              Divider(color: Colors.black.withOpacity(0.5)),
                              Row(
                                children: [
                                  Text("Completed At",
                                      style: appStyle(
                                          size: 14,
                                          color: mainBlack,
                                          fw: FontWeight.w600)),
                                  const Spacer(),
                                  Text("${order.completedAt?.formatDate()}",
                                      style: appStyle(
                                          size: 14,
                                          color: mainBlack,
                                          fw: FontWeight.w500)),
                                ],
                              ),
                            ],
                            const SizedBox(height: 15),
                            if (order.status?.name != "Cancelled" &&
                                order.status?.name != "Delivered" &&
                                order.status?.name != "Completed" &&
                                order.status?.name != "On Hold")
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    showPopupModal(
                                        context: context,
                                        title: "Peringatan",
                                        info: DialogType.warning,
                                        animType: AnimType.scale,
                                        desc:
                                            "Apakah anda mau membatalkan pesanan tersebut?",
                                        onOkPress: () {
                                          ref
                                              .read(
                                                  customerOrderViewModelProvider
                                                      .notifier)
                                              .cancelOrderCustomer(
                                                  orderId: order.id);
                                        },
                                        onCancelPress: () {});
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(40),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  child: Text(
                                    "Cancel",
                                    style: appStyle(
                                        size: 14,
                                        color: Colors.white,
                                        fw: FontWeight.w500),
                                  ),
                                ),
                              ),
                            if (order.status?.name == "Delivered")
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Routemaster.of(context).push(
                                        '/customer-account/orders/complete-order-review/${order.id}');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(40),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    backgroundColor: Colors.greenAccent,
                                  ),
                                  child: Text(
                                    "Complete",
                                    style: appStyle(
                                        size: 14,
                                        color: Colors.white,
                                        fw: FontWeight.w500),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        onTap: () {
                          ref
                              .read(
                                  orderDetailSelectionNotifierProvider.notifier)
                              .selectOrder(order);
                          Routemaster.of(context)
                              .push("/customer-account/orders/detail");
                        },
                      ),
                    ),
                    const SizedBox(height: 15)
                  ],
                ),
              )
              .toList(),
        );
}
