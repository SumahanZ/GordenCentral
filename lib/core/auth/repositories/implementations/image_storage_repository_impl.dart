import 'dart:convert';

import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';
import 'package:tugas_akhir_project/core/auth/repositories/sources/storage_repository.dart';
import 'package:tugas_akhir_project/utils/constants/global_variables.dart';

final imageStorageRepositoryProvider =
    Provider<ImageStorageRepositoryImpl>((ref) {
  return ImageStorageRepositoryImpl();
});

class ImageStorageRepositoryImpl implements StorageRepository {
  @override
  Cloudinary getInstance() {
    return Cloudinary.fromCloudName(cloudName: GlobalVariables.cloudinaryName);
  }

  Future<String> uploadImage(String path) async {
    var url = Uri.parse('https://api.cloudinary.com/v1_1/dkintlemd/upload');
    String returnedPath = "";

    final request = http.MultipartRequest('POST', url);
    request.fields["upload_preset"] = "oj9qtmcx";
    request.files.add(await http.MultipartFile.fromPath("file", path));
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);
      returnedPath = jsonMap['url'];
    }
    return returnedPath;
  }
}
