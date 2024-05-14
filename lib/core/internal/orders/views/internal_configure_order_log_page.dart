import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/core/customer/orders/providers/order_detail_selection_notifier.dart';
import 'package:tugas_akhir_project/core/internal/orders/repositories/implementations/internal_order_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/orders/viewmodels/internal_order_configure_log_viewmodel.dart';
import 'package:tugas_akhir_project/models/order.dart';
import 'package:tugas_akhir_project/models/orderstatus.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';
import 'package:tugas_akhir_project/utils/methods/utilmethods.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/widgets/custom_dropdown_button_widget.dart';
import 'package:tugas_akhir_project/widgets/form_textarea_widget.dart';

class InternalConfigureOrderLogPage extends ConsumerStatefulWidget {
  const InternalConfigureOrderLogPage({super.key});

  @override
  ConsumerState<InternalConfigureOrderLogPage> createState() =>
      _InternalConfigureOrderLogPageState();
}

class _InternalConfigureOrderLogPageState
    extends ConsumerState<InternalConfigureOrderLogPage> {
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool initializeFirst = true;
  OrderStatus? selectedStatus;

  void initializeFields(Order orderDetail) {
    _descriptionController.text = orderDetail.note ?? "Tidak ada deskripsi";
    selectedStatus = orderDetail.status;
  }

  @override
  Widget build(BuildContext context) {
    final orderDetail = ref.watch(orderDetailSelectionNotifierProvider);
    final availableOrderStatus = ref.watch(fetchOrderStasuses);

    ref.listen(internalOrderConfigureLogViewModelProvider, (previous, state) {
      if (previous != state) {
        if (state is AsyncData<void>) {
          showPopupModal(
              context: context,
              title: "Berhasil",
              info: DialogType.success,
              animType: AnimType.scale,
              desc: "Berhasil mengkonfigurasi catatan pesanan!",
              onOkPress: () {
                ref.invalidate(fetchAllCustomerOrders);
                Routemaster.of(context).replace('/internal-order');
              });
        } else if (state is AsyncError && state.error is ResponseAPIError) {
          showPopupModal(
              context: context,
              title: "Peringatan",
              info: DialogType.error,
              animType: AnimType.scale,
              desc: (state.error as RequestError).errorMessage,
              onOkPress: () {});
        } else if (state is AsyncError && state.error is RequestError) {
          showPopupModal(
              context: context,
              title: "Peringatan",
              info: DialogType.error,
              animType: AnimType.scale,
              desc: (state.error as RequestError).errorMessage,
              onOkPress: () {});
        } else if (state is AsyncError) {
          showPopupModal(
              context: context,
              title: "Peringatan",
              info: DialogType.error,
              animType: AnimType.scale,
              desc: (state.error as ApiError).message,
              onOkPress: () {});
        }
      }
    });
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Konfigurasi Catatan Pesanan",
            style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: availableOrderStatus.maybeWhen(
            data: (data) {
              return data.match(
                  (l) => Center(
                      child: Text(l.message,
                          style: appStyle(
                              size: 16,
                              color: mainBlack,
                              fw: FontWeight.w600))), (r) {
                if (initializeFirst) {
                  initializeFields(orderDetail!);
                  initializeFirst = false;
                }
                return SafeArea(
                    child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Column(children: [
                        const TopSectionAuth(
                            name: "Konfigurasi Catatan Pesanan",
                            description:
                                "Konfigurasikan status pesanan dan catatan pesanan",
                            isAvatarNeeded: false),
                        SizedBox(height: 20.h),
                        CustomDropdown(
                          values: r.map((e) => e.name).toList(),
                          labelText: "Status Pesanan",
                          hintText: "Pilih Status Pesanan",
                          preValue: selectedStatus?.name,
                          validator: (value) {
                            if (value?.isEmpty ?? false) {
                              return "Anda harus memilih status pesanan.";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              selectedStatus = r
                                  .where((element) => element.name == value)
                                  .toList()
                                  .first;
                            });
                          },
                        ),
                        SizedBox(height: 20.h),
                        CustomTextArea(
                            hintText: "Masukkan Catatan Pesanan",
                            controller: _descriptionController,
                            labelText: "Catatan Pesanan",
                            validator: (value) {
                              if (!(value!.isNotEmpty)) {
                                return "Format catatan pesanan tidak valid. Harap masukkan format catatan pesanan yang valid.";
                              } else {
                                return null;
                              }
                            },
                            obscureText: false),
                        SizedBox(height: 20.h),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                (_descriptionController.text !=
                                        orderDetail?.note ||
                                    selectedStatus?.name !=
                                        orderDetail?.status?.name) &&
                                selectedStatus != null &&
                                orderDetail != null) {
                              showPopupModal(
                                  context: context,
                                  title: "Peringatan",
                                  info: DialogType.warning,
                                  animType: AnimType.scale,
                                  desc:
                                      "Apakah Anda yakin ingin mengkonfigurasi pesanan ini?",
                                  onOkPress: () {
                                    ref
                                        .read(
                                            internalOrderConfigureLogViewModelProvider
                                                .notifier)
                                        .configureOrderLog(
                                            orderId: orderDetail.id,
                                            statusId: selectedStatus!.id,
                                            logNote:
                                                _descriptionController.text);
                                  },
                                  onCancelPress: () {});
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor: Colors.purple,
                          ),
                          child: Text(
                            "Konfigurasi Catatan Pesanan",
                            style: appStyle(
                                size: 16,
                                color: Colors.white,
                                fw: FontWeight.w500),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ));
              });
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            orElse: () => const SizedBox.shrink()));
  }
}
