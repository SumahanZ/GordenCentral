import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:tugas_akhir_project/core/internal/internaltoko/repositories/implementations/internal_internaltoko_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/internaltoko/viewmodels/internal_internaltoko_viewmodel.dart';
import 'package:tugas_akhir_project/models/internal.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/extensions/string_extension.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/widgets/global_providers/user_state.dart';

class InternalInternalTokoPage extends ConsumerStatefulWidget {
  const InternalInternalTokoPage({super.key});

  @override
  ConsumerState<InternalInternalTokoPage> createState() =>
      _InternalInternalTokoPageState();
}

class _InternalInternalTokoPageState
    extends ConsumerState<InternalInternalTokoPage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final userState = ref.read(userStateProvider);
    return Scaffold(
        appBar: AppBar(
          actions: [
            if (userState?.type == "pemilik")
              GestureDetector(
                onTap: () => Routemaster.of(context)
                    .push('/internal-account/internal-toko/add'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      const Icon(AntIcons.usergroupAddOutlined, size: 30),
                      Text("Tambah",
                          style: appStyle(
                              size: 14, color: mainBlack, fw: FontWeight.w500))
                    ],
                  ),
                ),
              )
          ],
          title: Text(
            "Internal Toko",
            style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: ref.watch(fetchInternals).when(
            data: (data) {
              return data.match(
                  (l) => Center(
                      child: Text(l.message,
                          style: appStyle(
                              size: 16,
                              color: mainBlack,
                              fw: FontWeight.w600))), (internalData) {
                print(internalData);
                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Expanded(
                            child: SearchableList<Internal>(
                              style: appStyle(
                                  size: 16,
                                  color: mainBlack,
                                  fw: FontWeight.w500),
                              initialList: internalData,
                              searchTextController: searchController,
                              filter: (searchQuery) {
                                return internalData
                                    .where((element) =>
                                        element.user!.name
                                            .toLowerCase()
                                            .contains(searchQuery
                                                .toLowerCase()
                                                .toString()) ||
                                        element.userCode!
                                            .toLowerCase()
                                            .contains(searchQuery
                                                .toLowerCase()
                                                .toString()))
                                    .toList();
                              },
                              emptyWidget: const Center(
                                  child: Text(
                                      "Internal yang dicari tidak ditemukan")),
                              builder: (list, index, item) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Card(
                                    surfaceTintColor: Colors.white,
                                    elevation: 5,
                                    child: ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 15),
                                      title: Column(children: [
                                        IntrinsicHeight(
                                          child: Row(children: [
                                            item.profilePhotoURL == null
                                                ? CircleAvatar(radius: 30.r)
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    child: Image.network(
                                                        item.profilePhotoURL!,
                                                        width: 60.w, )),
                                            const SizedBox(width: 15),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "${item.user?.name} #${item.userCode}",
                                                      style: appStyle(
                                                          size: 14,
                                                          color: mainBlack,
                                                          fw: FontWeight.w600)),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Role: ${item.role?.toCapitalized()}",
                                                        style: appStyle(
                                                          size: 12,
                                                          color: mainBlack,
                                                          fw: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Status: ${item.status?.toCapitalized()}",
                                                        style: appStyle(
                                                          size: 12,
                                                          color: mainBlack,
                                                          fw: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // const Spacer(),

                                            Builder(builder: (context) {
                                              if (userState?.type ==
                                                      "pemilik" &&
                                                  userState?.id !=
                                                      item.user?.id &&
                                                  item.status == "pending") {
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        ref
                                                            .read(
                                                                internalTokoViewModelProvider
                                                                    .notifier)
                                                            .acceptJoinRequest(
                                                                targetInternalId:
                                                                    internalData[
                                                                            index]
                                                                        .id!)
                                                            .then((value) =>
                                                                ref.invalidate(
                                                                    fetchInternals));
                                                      },
                                                      child: Material(
                                                        color:
                                                            Colors.greenAccent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              const Icon(
                                                                AntIcons
                                                                    .checkCircleOutlined,
                                                                size: 18,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              const SizedBox(
                                                                  width: 5),
                                                              Text(
                                                                "ACCEPT",
                                                                style: appStyle(
                                                                  size: 10,
                                                                  color: Colors
                                                                      .white,
                                                                  fw: FontWeight
                                                                      .bold,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.h),
                                                    GestureDetector(
                                                      onTap: () {
                                                        ref
                                                            .read(
                                                                internalTokoViewModelProvider
                                                                    .notifier)
                                                            .declineJoinRequest(
                                                                targetInternalId:
                                                                    internalData[
                                                                            index]
                                                                        .id!)
                                                            .then((value) =>
                                                                ref.invalidate(
                                                                    fetchInternals));
                                                      },
                                                      child: Material(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                                side:
                                                                    const BorderSide(
                                                                  color: Colors
                                                                      .black,
                                                                )),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              const Icon(
                                                                  AntIcons
                                                                      .closeCircleOutlined,
                                                                  size: 18),
                                                              const SizedBox(
                                                                  width: 5),
                                                              Text(
                                                                "CANCEL",
                                                                style: appStyle(
                                                                  size: 10,
                                                                  color:
                                                                      mainBlack,
                                                                  fw: FontWeight
                                                                      .w600,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              } else if (item.user?.type ==
                                                      "pemilik" &&
                                                  userState?.id !=
                                                      item.user?.id) {
                                                return const Icon(
                                                    AntIcons.crownFilled);
                                              } else if (userState?.id ==
                                                  item.user?.id) {
                                                return Text("You",
                                                    style: appStyle(
                                                      size: 14,
                                                      color: mainBlack,
                                                      fw: FontWeight.bold,
                                                    ));
                                              } else {
                                                return const SizedBox.shrink();
                                              }
                                            }),
                                          ]),
                                        ),
                                      ]),
                                    ),
                                  ),
                                );
                              },
                              inputDecoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                hintStyle: appStyle(
                                    size: 16,
                                    color: mainBlack,
                                    fw: FontWeight.w500),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                hintText: "Search Internal Toko...",
                                fillColor: Colors.white,
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 1),
                                ),
                                disabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
                                  borderSide: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: 2),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
            },
            error: (error, stackTrace) => const SizedBox.shrink(),
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}
