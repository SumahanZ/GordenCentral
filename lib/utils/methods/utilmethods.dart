// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
  ));
}

void showPopupModal({
  required BuildContext context,
  String? title,
  required DialogType info,
  required AnimType animType,
  required String desc,
  Function? onCancelPress,
  Function? onOkPress,
}) {
  AwesomeDialog(
    dismissOnTouchOutside: false,
    // dismissOnBackKeyPress: false,
    // showCloseIcon: true,
    headerAnimationLoop: false,
    buttonsTextStyle:
        appStyle(size: 16, color: Colors.white, fw: FontWeight.w600),
    descTextStyle: appStyle(size: 12, color: Colors.black, fw: FontWeight.w500),
    titleTextStyle:
        appStyle(size: 18, color: Colors.black, fw: FontWeight.bold),
    context: context,
    dialogType: info,
    animType: animType,
    title: title,
    desc: desc,
    btnCancelOnPress: onCancelPress != null
        ? () {
            onCancelPress();
          }
        : null,
    btnOkOnPress: onOkPress != null
        ? () {
            onOkPress();
          }
        : null,
  ).show();
}

Future<File?> pickImage() async {
  File? selectedImage;
  String? path;
  try {
    var filesResult = await FilePicker.platform.pickFiles(
        type: FileType.image, allowMultiple: false, compressionQuality: 10);

    if (filesResult != null) {
      path = filesResult.files.single.path!;
    }

    //check if filesResult not null and the files that they give us is not empty
    if (filesResult != null && filesResult.files.isNotEmpty) {
      selectedImage = (File(path!));
    }
  } catch (error) {
    debugPrint(error.toString());
  }

  return selectedImage;
}

Future<List<File>> pickMultipleImages() async {
  List<File> selectedImages = [];
  try {
    var filesResult = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);

    if (selectedImages.length <= 5) {
      if (filesResult != null && filesResult.files.isNotEmpty) {
        for (final file in filesResult.files) {
          selectedImages.add(File(file.path!));
        }
      }
    } else {
      throw "Image selected is more than 5";
    }
  } catch (error) {
    debugPrint(error.toString());
  }

  return selectedImages;
}
