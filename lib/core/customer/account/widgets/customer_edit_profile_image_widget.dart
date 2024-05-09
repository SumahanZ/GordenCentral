import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
    return customer?.profilePhotoURL != null && imageFromfile == false
        ? Center(
            child: Stack(alignment: Alignment.bottomRight, children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      color: Colors.black,
                      border: Border.all(width: 2)),
                  width: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: CachedNetworkImage(
                      imageUrl: customer!.profilePhotoURL ?? "",
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      // placeholder: (context, url) =>
                      //     const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  )),
              GestureDetector(
                onTap: () {
                  pickTheImage();
                },
                child: const CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 215, 230, 255),
                    radius: 20,
                    child: Icon(Icons.edit, size: 18, color: Colors.black)),
              )
            ]),
          )
        : selectedImage == null
            ? Center(
                child: Stack(alignment: Alignment.bottomRight, children: [
                  const CircleAvatar(
                      foregroundColor: Colors.white,
                      radius: 75,
                      child: Icon(Icons.person, size: 50)),
                  GestureDetector(
                    onTap: () {
                      pickTheImage();
                    },
                    child: const CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 215, 230, 255),
                        radius: 20,
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
                          border: Border.all(width: 2)),
                      width: 150,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(200),
                          child: Image.file(selectedImage!))),
                  GestureDetector(
                    onTap: () {
                      pickTheImage();
                    },
                    child: const CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 215, 230, 255),
                        radius: 20,
                        child: Icon(Icons.edit, size: 18, color: Colors.black)),
                  )
                ]),
              );
  }
}
