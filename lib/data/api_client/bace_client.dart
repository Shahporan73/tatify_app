import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart' hide Response;
import 'package:http/http.dart' as http;
import 'package:tatify_app/data/utils/const_value.dart';

import '../../view/authenticate/view/sign_in_screen.dart';
import '../local_database/local_data_base.dart';



class BaseClient {

  static getRequest({required String api, params, headers}) async {
    debugPrint("API Hit: $api");
    http.Response response = await http.get(
        Uri.parse(api).replace(queryParameters: params),
        headers: headers
    );
    return response;
  }

  static postRequest({required String api, body, Map? headers}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    debugPrint("API Hit: $api");
    debugPrint("body: $body");
    http.Response response = await http.post(
      Uri.parse(api),
      body: jsonEncode(body),
      headers: headers,
    );
    debugPrint("<================= response =================>");
    return response;
  }


  static putRequest({required String api, body, headers}) async {
    debugPrint("API Hit: $api");
    debugPrint("body: $body");

    http.Response response = await http.put(
      Uri.parse(api),
      body: jsonEncode(body),
      headers: headers,
    );

    debugPrint("<================= response =================>");
    debugPrint('statusCode: ${response.statusCode}');
    debugPrint('Response: ${response.body}');

    return response;
  }


  static deleteRequest({required String api, body, headers}) async {
    debugPrint("API Hit: $api");
    debugPrint("body: $body");
    http.Response response = await http.delete(
      Uri.parse(api),
      body: body,
      headers: headers,
    );
    debugPrint("<================= response =================>");
    return response;
  }


  static patchRequest({required String api, body, headers}) async {
    debugPrint("API Hit: $api");
    debugPrint("body: $body");

    http.Response response = await http.patch(
      Uri.parse(api),
      body: jsonEncode(body),
      headers: headers,
    );
    return response;
  }


  static handleResponse(http.Response response) async {
    try {
      debugPrint('statusCode: ${response.statusCode}');
      debugPrint('Response: ${response.body}');
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        debugPrint('SuccessCode: ${response.statusCode}');
        debugPrint('SuccessResponse: ${response.body}');

        if (response.body.isNotEmpty) {
          return json.decode(response.body);
        } else {
          return response.body;
        }
      } else if (response.statusCode == 401) {

        /* try {
            var response = await http.post(
              Uri.parse(ApiConstant.refreshToken),
              headers: {
                'Accept': 'application/json',
                'refreshToken': '${LocalStorage.getData(key: AppConstant.refreshToken)}',

              },
            );
            if (response.statusCode == 200) {
              final Map<String, dynamic> responseData = jsonDecode(response.body);
              LocalStorage.saveData(key: AppConstant.token, data: responseData["data"]["accessToken"].toString());
              Get.snackbar('Success', 'Token Updated.');
            } else {
              Get.snackbar('Error', 'Failed Token Updated');
            }
          } catch (e) {
            Get.snackbar('Error', 'Failed to Token Updated: $e');
          }*/

        Get.offAll(
              () => SignInScreen(),
        );

        print("Unauthorized");
        // LocalStorage.removeData(key: accessToken);
        //  logout();
        String msg = "Unauthorized";
        if (response.body.isNotEmpty) {
          if(json.decode(response.body)['errors'] != null){
            msg = json.decode(response.body)['errors'];
          }
        }
        throw msg;
      } else if (response.statusCode == 404) {
        Get.snackbar('Error', json.decode(response.body)['message'],
            snackPosition: SnackPosition.BOTTOM);
        throw 'Page Not Found!';
      }
      else if(response.statusCode == 403){

        Get.snackbar('Error', json.decode(response.body)['message'],
            snackPosition: SnackPosition.BOTTOM);

      }

      else if(response.statusCode == 400){

        Get.snackbar('Error', json.decode(response.body)['message'],
            snackPosition: SnackPosition.BOTTOM);

      }else if(response.statusCode == 406){

        Get.snackbar('Error', json.decode(response.body)['message'],
            snackPosition: SnackPosition.BOTTOM);

      }
      else if(response.statusCode == 406){

        Get.snackbar('Error', json.decode(response.body)['message'],
            snackPosition: SnackPosition.BOTTOM);

      }else if (response.statusCode == 500) {
        throw "Server Error";
      } else {
        debugPrint('ErrorCode: ${response.statusCode}');
        debugPrint('ErrorResponse: ${response.body}');

        String msg = "Something went wrong";
        if (response.body.isNotEmpty) {
          var data = jsonDecode(response.body)['errors'];
          if(data == null){
            msg = jsonDecode(response.body)['message'] ?? msg;
          }
          else if (data is String) {
            msg = data;
          } else if (data is Map) {
            msg = data['email'][0];
          }
        }

        throw msg;
      }
    } on SocketException catch (_) {
      throw "noInternetMessage";
    } on FormatException catch (_) {
      throw "Bad response format";
    } catch (e) {
      throw e.toString();
    }
  }

  static void logout() {
     // LocalStorage.removeData(key: accessToken);
     Get.offAll(() => SignInScreen());
  }
}