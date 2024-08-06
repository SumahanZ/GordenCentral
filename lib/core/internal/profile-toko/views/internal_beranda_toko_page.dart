import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/viewmodels/toko_information_viewmodel.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/widgets/toko_carousel_slider_widget.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';
import 'package:tugas_akhir_project/utils/methods/utilmethods.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class InternalBerandaTokoPage extends ConsumerStatefulWidget {
  const InternalBerandaTokoPage({Key? key}) : super(key: key);

  @override
  ConsumerState<InternalBerandaTokoPage> createState() =>
      _InternalBerandaTokoPageState();
}

class _InternalBerandaTokoPageState
    extends ConsumerState<InternalBerandaTokoPage> {
  List<File> selectedImages = [];
  void pickTheImage() async {
    final image = await pickMultipleImages();
    setState(() {
      selectedImages = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tokoInformation = ref.watch(fetchBerandaTokoProvider);
    ref.listen(tokoInformationViewModelProvider, (_, state) {
      if (state is AsyncData<void>) {
        showPopupModal(
            context: context,
            title: "Berhasil",
            info: DialogType.success,
            animType: AnimType.scale,
            desc: "Berhasil mengonfigurasi beranda toko!",
            onOkPress: () {
              Routemaster.of(context).replace('/internal-account');
            });
      } else if (state is AsyncError && state.error is ResponseAPIError) {
        showPopupModal(
            context: context,
            title: "Peringatan",
            info: DialogType.error,
            animType: AnimType.scale,
            desc: "Kesalahan respons telah terjadi!",
            onOkPress: () {});
      } else if (state is AsyncError && state.error is RequestError) {
        showPopupModal(
            context: context,
            title: "Peringatan",
            info: DialogType.error,
            animType: AnimType.scale,
            desc: "Permintaan jaringan telah terjadi!",
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
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Beranda Toko",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: tokoInformation.maybeWhen(data: (data) {
          return data.match(
            (l) {
              return Center(
                  child: Text(l.message,
                      style: appStyle(
                          size: 16, color: mainBlack, fw: FontWeight.w600)));
            },
            (r) {
              return ref.watch(tokoInformationViewModelProvider).when(
                    data: (data) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            const TopSectionAuth(
                                name: "Beranda Toko",
                                description: "Konfigurasi beranda toko Anda",
                                isAvatarNeeded: false),
                            SizedBox(height: 30.h),
                            BerandaTokoCarouselSlider(
                                berandaImageUrls: r
                                    .map((e) => e.berandaImageUrl ?? "")
                                    .toList(),
                                selectedImages: selectedImages,
                                pickTheImage: pickTheImage),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                if (selectedImages.isNotEmpty) {
                                  ref
                                      .read(tokoInformationViewModelProvider
                                          .notifier)
                                      .configureBerandaToko(
                                          imageUrls: selectedImages
                                              .map((e) => e.path)
                                              .toList())
                                      .then((value) {});
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 20),
                                minimumSize: const Size.fromHeight(50),
                                backgroundColor: selectedImages.isNotEmpty
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.grey,
                              ),
                              child: Text(
                                "Confirm",
                                style: appStyle(
                                    size: 16,
                                    color: Colors.white,
                                    fw: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    error: ((error, stackTrace) =>
                        Center(child: Text(error.toString()))),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                  );
            },
          );
        }, loading: () {
          return const Center(child: CircularProgressIndicator());
        }, orElse: () {
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}
