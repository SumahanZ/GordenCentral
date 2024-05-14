import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class InternalLayananPage extends StatelessWidget {
  const InternalLayananPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Layanan",
            style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                onTap: () {
                  
                },
                child: Row(
                  children: [
                    const Icon(Icons.add),
                    SizedBox(width: 5.w),
                    Text("Add",
                        style: appStyle(
                            size: 14, color: mainBlack, fw: FontWeight.w500)),
                  ],
                ),
              ),
            )
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(children: [
              GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 8,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.59),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Routemaster.of(context).push('/internal-dashboard/layanan/detail'),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Card(
                          surfaceTintColor: Colors.white,
                          elevation: 5,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: DecoratedBox(
                                        decoration: const BoxDecoration(
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6.0, horizontal: 10),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("15% OFF",
                                                  style: appStyle(
                                                      size: 13,
                                                      color: Colors.white,
                                                      fw: FontWeight.w600)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () => Routemaster.of(context).push('/internal-dashboard/layanan/edit'),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.deepPurpleAccent,
                                        radius: 14.r,
                                        child: Icon(Icons.edit,
                                            size: 16, color: Colors.white),
                                      ),
                                    )
                                  ]),
                                ),
                                Expanded(
                                  child: ClipRRect(
                                    child: Image.asset(
                                      "assets/images/test-image-2.avif",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Nike Air Max K200",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: appStyle(
                                                size: 16,
                                                color: mainBlack,
                                                fw: FontWeight.w600),
                                            textAlign: TextAlign.center),
                                        const SizedBox(height: 5),
                                        Text(
                                          "Rp 97.000",
                                          style: appStyle(
                                              size: 18,
                                              color: mainBlack,
                                              fw: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            RatingBar.builder(
                                              ignoreGestures: true,
                                              itemSize: 16,
                                              initialRating: 3,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2.0),
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {},
                                            ),
                                            SizedBox(width: 5.w),
                                            Text("(3.5)",
                                                style: appStyle(
                                                    size: 13,
                                                    color: mainBlack,
                                                    fw: FontWeight.w600)),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                )
                              ]),
                        ),
                      ),
                    );
                  }),
            ]),
          ),
        )));
  }
}
