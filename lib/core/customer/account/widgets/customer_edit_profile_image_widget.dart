import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tugas_akhir_project/models/customer.dart';

class CustomerEditProfileImage extends StatelessWidget {
  final Customer? customer;
  final File? selectedImage;
  final Function() pickTheImage;
  final bool imageFromfile;
  const CustomerEditProfileImage(
      {super.key,
      this.selectedImage,
      required this.pickTheImage,
      this.customer,
      required this.imageFromfile});

  @override
  Widget build(BuildContext context) {
    print(customer);
    return customer?.profilePhotoURL != null && imageFromfile == false
        ? Center(
            child: Stack(alignment: Alignment.bottomRight, children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      color: Colors.black,
                      border: Border.all(width: 2.w)),
                  width: 150.w,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Image.network(customer?.profilePhotoURL ?? ""))),
              GestureDetector(
                onTap: () {
                  pickTheImage();
                },
                child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 215, 230, 255),
                    radius: 20.r,
                    child: Icon(Icons.edit, size: 18, color: Colors.black)),
              )
            ]),
          )
        : selectedImage == null
            ? Center(
                child: Stack(alignment: Alignment.bottomRight, children: [
                  CircleAvatar(
                      foregroundColor: Colors.white,
                      radius: 75.r,
                      child: Icon(Icons.person, size: 50)),
                  GestureDetector(
                    onTap: () {
                      pickTheImage();
                    },
                    child: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 215, 230, 255),
                        radius: 20.r,
                        child: Icon(Icons.edit, size: 18, color: Colors.black)),
                  ),
                ]),
              )
            : Center(
                child: Stack(alignment: Alignment.bottomRight, children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200.r),
                          color: Colors.black,
                          border: Border.all(width: 2.w)),
                      width: 150.w,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(200.r),
                          child: Image.file(selectedImage!))),
                  GestureDetector(
                    onTap: () {
                      pickTheImage();
                    },
                    child: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 215, 230, 255),
                        radius: 20.r,
                        child: Icon(Icons.edit, size: 18, color: Colors.black)),
                  )
                ]),
              );
  }
}
