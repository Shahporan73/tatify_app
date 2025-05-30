import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../data/api_client/bace_client.dart';
import '../../../../data/api_client/end_point.dart';
import '../../../../data/local_database/local_data_base.dart';
import '../../../../data/utils/const_value.dart';
import 'package:path/path.dart' as path;

class VendorProfileController extends GetxController {
  var isLoading = false.obs;

  var fullName = ''.obs;
  var dateOfBirth = ''.obs;
  var gender = ''.obs;
  var phoneNumber = ''.obs;
  var email = ''.obs;
  var profileImage = ''.obs;
  var address = ''.obs;
  var id = ''.obs;
  var paymentStatus = ''.obs;

  // Rx variable to hold the image
  var imagePath = Rxn<String>();
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    LocalStorage.getData(key: accessToken) != null ? getProfile() : null;
  }

  Future<void> getProfile() async {
    isLoading.value = true;

    var token = LocalStorage.getData(key: accessToken);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    try {
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
          api: EndPoint.profileURL,
          headers: headers,
        ),
      );

      if (responseBody != null && responseBody['success'] == true) {
        print('responseBody $responseBody');

        // Ensure values are never null by providing default values if null
        fullName.value = responseBody['data']['name'] ?? '';
        dateOfBirth.value = responseBody['data']['dob']?.toString() ?? '';
        gender.value = responseBody['data']['gender']?.toString() ?? '';
        phoneNumber.value = responseBody['data']['phoneNumber']?.toString() ?? '';
        address.value = responseBody['data']['address']?.toString() ?? '';
        email.value = responseBody['data']['email']?.toString() ?? '';
        paymentStatus.value = responseBody['data']['payment']['status']?.toString() ?? 'Unpaid';
        profileImage.value = responseBody['data']['profileImage']?.toString() ?? '';
        id.value = responseBody['data']['_id']?.toString() ?? '';
        print('phoneNumber $phoneNumber');
      }
    } catch (e) {
      print('get profile error $e');
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> updateProfile({
    required String fullName,
    required String dateOfBirth,
    required String gender,
    required String phoneNumber,
    required String address,
    required String id,
    required BuildContext context
  }) async {
    isLoading.value = true;
    try {
      var token = await LocalStorage.getData(key: accessToken);

      Map<String, String> headers = {
        'Authorization': token ?? '',
      };

      var request = http.MultipartRequest(
        'PUT',
        Uri.parse(EndPoint.editProfileURL(id: id)),
      );
      request.headers.addAll(headers);

      Map<String, dynamic> data = {
        "name": fullName,
        "phoneNumber": phoneNumber,
        "gender": gender,
        'address': address,
        if(dateOfBirth.isNotEmpty && dateOfBirth != "") "dob": dateOfBirth,
        // "dob": dateOfBirth,
      };
      request.fields['data'] = jsonEncode(data);

      if (imagePath.value != null) {
        if (File(imagePath.value!).existsSync()) {
          String fileExtension = imagePath.value!.split('.').last.toLowerCase();
          String mimeType = '';

          if (fileExtension == 'jpg' || fileExtension == 'jpeg') {
            mimeType = 'image/jpeg';
          } else if (fileExtension == 'png') {
            mimeType = 'image/png';
          } else {
            mimeType = 'application/octet-stream';
          }

          var file = await http.MultipartFile.fromPath(
            'profileImage',
            imagePath.value ?? '',
            contentType: MediaType.parse(mimeType),
          );
          request.files.add(file);
        }
      }

      print('request fields ${request.fields}');
      print('request image files ${request.files}');
      print('image path ${imagePath.value}');

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);

        if (jsonResponse['success'] == true) {
          profileImage.value = jsonResponse['data']['profileImage'] ?? '';

          Get.snackbar('Success', 'Profile updated successfully',
              backgroundColor: Colors.green, snackPosition: SnackPosition.TOP);
          Navigator.of(context).pop();
          imagePath.value = null;
          await getProfile();

        } else {
          Get.snackbar('Error', 'Failed to update profile: ${jsonResponse['message']}',
              backgroundColor: Colors.red, snackPosition: SnackPosition.TOP);
        }
      }if (response.statusCode == 413) {
        Get.rawSnackbar(message: 'Image size is too large');
      }else {
        var responseBody = await response.stream.bytesToString();
        print('Error updating profile: $responseBody');
      }
    } catch (e) {
      print('Error updating profile: $e');
    } finally {
      isLoading.value = false;
    }
  }



  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (pickedFile != null) {
      final File originalFile = File(pickedFile.path);
      final int fileSize = await originalFile.length();

      // If image is > 1MB, compress it
      if (fileSize > 1 * 1024 * 1024) {
        final dir = await getTemporaryDirectory();
        final targetPath = path.join(dir.path, 'compressed_${path.basename(pickedFile.path)}');

        final compressedFile = await FlutterImageCompress.compressAndGetFile(
          pickedFile.path,
          targetPath,
          quality: 70, // Reduce quality to shrink size
        );

        if (compressedFile != null) {
          imagePath.value = compressedFile.path;
        } else {
          Get.snackbar('Error', 'Image compression failed',
              backgroundColor: Colors.red, snackPosition: SnackPosition.TOP);
        }
      } else {
        imagePath.value = pickedFile.path;
      }
    }
  }
}
