import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tugas_akhir_project/models/toko.dart';

class TokoConfigureImage extends StatelessWidget {
  final Toko? toko;
  final File? selectedImage;
  final Function() pickTheImage;
  const TokoConfigureImage(
      {super.key, this.selectedImage, required this.pickTheImage, this.toko});

  @override
  Widget build(BuildContext context) {
    return toko?.profilePhotoURL != null
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
                      child: Image.network(toko!.profilePhotoURL ?? ""))),
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
                          borderRadius: BorderRadius.circular(200),
                          color: Colors.black,
                          border: Border.all(width: 2.w)),
                      width: 150.w,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(200),
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
