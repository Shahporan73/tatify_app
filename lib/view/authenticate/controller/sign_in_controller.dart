import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:tatify_app/data/local_database/local_data_base.dart';
import 'package:tatify_app/view/user/user_home/view/home_dashboard.dart';
import 'package:tatify_app/view/vendor/payment/views/pay_now_screen.dart';
import 'package:tatify_app/view/vendor/vendor_home/views/vendor_home_dashboard.dart';

import '../../../data/api_client/bace_client.dart';
import '../../../data/api_client/end_point.dart';
import '../../../data/utils/const_value.dart';

class SignInController extends GetxController {
  var isSelected = false.obs;
  var isLoading = false.obs;
  var isGoogleSignInLoading = false.obs;
  RxBool isPasswordVisible = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Stream<User?> authStateChange() => _auth.authStateChanges();
  String getUserEmail() => _auth.currentUser?.email ?? 'user';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _loadRememberedState();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();

  // String? validateField(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return 'This field cannot be empty';
  //   }
  //   return null;
  // }

  void checkUser() {
    /*if(emailC.text.isEmpty && passC.text.isEmpty){
      Get.rawSnackbar(message: "Please enter email and password");
    }else if(emailC.text.contains('@') == false){
      Get.rawSnackbar(message: "Please enter valid email");
    }else if(passC.text.length < 6){
      Get.rawSnackbar(message: "Password must be at least 6 characters");
    }else*/

    /*if(emailC.text == 'user@gmail.com' && passC.text == '123456'){
      Get.to(()=>HomeDashboard());
    }else */
    if (emailC.text == 'vendor@gmail.com' && passC.text == '123456') {
      Get.to(() => VendorHomeDashboard());
    }
  }

  String? validateLogin() {
    if (emailC.text.isEmpty) {
      return "Email is required";
    } else if (!GetUtils.isEmail(emailC.text)) {
      return "Enter a valid email address";
    }

    if (passC.text.isEmpty) {
      return "Password is required";
    } else if (passC.text.length < 6) {
      return "Password should be at least 6 characters long";
    }
    // All validations passed
    return null;
  }

  // Load saved remember me state and other data
  _loadRememberedState() async {
    // Load checkbox state (remember me)
    String? rememberMe = await LocalStorage.getData(key: saveRememberMe);
    if (rememberMe != null && rememberMe == 'true') {
      isSelected.value = true;
      emailC.text = await LocalStorage.getData(key: saveEmail) ?? '';
      passC.text = await LocalStorage.getData(key: savePassword) ?? '';
    }
  }

  // Save email, password, and checkbox state
  isRemembered() async {
    if (isSelected.value) {
      await LocalStorage.saveData(key: saveEmail, data: emailC.text);
      await LocalStorage.saveData(key: savePassword, data: passC.text);
      await LocalStorage.saveData(key: saveRememberMe, data: 'true');
    } else {
      await LocalStorage.removeData(key: saveEmail);
      await LocalStorage.removeData(key: savePassword);
      await LocalStorage.saveData(key: saveRememberMe, data: 'false');
    }
  }

  /// sign in
  Future<void> loginMethod() async {
    isLoading.value = true;

    String fcmToken = await getFcmTokenForLoggedInUser() ?? '';
    if (fcmToken != null) {
      print('FCM Token: $fcmToken');
    }
    try {
      Map<String, String> body = {
        'email': emailC.text,
        'password': passC.text,
        'fcmToken': fcmToken
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
          api: EndPoint.loginURL,
          body: body,
        ),
      );

      if (responseBody != null) {
        if (responseBody['success'] == true) {
          String token = responseBody['data']['accessToken'];
          print('accessToken $token');

          LocalStorage.saveData(key: accessToken, data: token);
          print('accessToken main ${LocalStorage.getData(key: accessToken)}');

          String role = responseBody['data']['user']['role'];

          LocalStorage.saveData(key: userType, data: role);

          if (responseBody['data']['user']['role'] == 'vendor' &&
              responseBody['data']['user']['payment']['status'] != 'paid') {
            Get.to(() => PayNowScreen());
          } else if (responseBody['data']['user']['role'] == 'vendor' &&
              responseBody['data']['user']['payment']['status'] == 'paid') {
            Get.to(() => VendorHomeDashboard());
          } else {
            Get.rawSnackbar(
                message: responseBody['message'],
                snackPosition: SnackPosition.TOP);
          }

          if (responseBody['data']['user']['role'] == 'user') {
            Get.to(() => HomeDashboard());
          }

          Get.rawSnackbar(
              message: responseBody['message'],
              backgroundColor: Colors.green,
              snackPosition: SnackPosition.TOP
          );

        }  if (responseBody['success'] == false) {
          Get.rawSnackbar(
              message: 'User not found',
              snackPosition: SnackPosition.TOP);
        }

      }else {
        Get.rawSnackbar(
            message: responseBody['message'],
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      print('sign in error $e');
    } finally {
      // Handle sign up success
      isLoading.value = false;
    }
  }

  // get fcm token
  Future<String?> getFcmTokenForLoggedInUser() async {
    try {
      await FirebaseMessaging.instance.requestPermission();
      String? token = await FirebaseMessaging.instance.getToken();

      if (token != null) {
        print('FCM Token: $token');
      } else {
        print('Failed to get FCM token');
      }

      return token;
    } catch (e) {
      print('Error getting FCM token: $e');
      return null;
    }
  }

  // sign in with google
  Future<void> onGoogleSignIn() async {
    isGoogleSignInLoading(true);
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in to Firebase with the Google credential
        UserCredential userCredential = await _auth.signInWithCredential(credential);
        User? firebaseUser = userCredential.user;

        if (firebaseUser != null) {
          String email = firebaseUser.email ?? '';
          String name = firebaseUser.displayName ?? '';
          String photoUrl = firebaseUser.photoURL ?? '';
          String firebaeAccessToken = googleAuth.accessToken ?? '';

          // Call the API with Firebase user details
          await onInitGoogle(
            email: email,
            firebaeAccessToken: firebaeAccessToken,
            name: name,
            profilePicture: photoUrl,
          );

          print("firebase Token: $firebaeAccessToken, email: $email, name: $name, photoUrl: $photoUrl");
        } else {
          Get.rawSnackbar(
              message: 'User not found', backgroundColor: Colors.red);
          print("Firebase user not found after Google Sign-In.");
        }
      } else {
        print("Google sign-in was aborted.");
      }
    } catch (e) {
      Get.rawSnackbar(
          message: 'Connection error...', backgroundColor: Colors.red);
      print("Error signing in with Google: ${e.toString()}");
    } finally {
      isGoogleSignInLoading(false);
    }
  }

/*
  // sign in with apple id
  Future<void> onAppleSignIn() async {
    print('Click apple Sign in');
    isAppleSignInLoading(true);
    try {
      // Step 1: Request Apple credentials
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Step 2: Create an OAuth credential for Firebase
      final oAuthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // Step 3: Sign in with Firebase
      final userCredential =
      await FirebaseAuth.instance.signInWithCredential(oAuthCredential);

      // Step 4: Retrieve the signed-in user's info
      final user = userCredential.user;

      // Fetch email and name from Apple Sign-In response
      final email = user?.email ?? appleCredential.email;
      final fullName =
      "${appleCredential.givenName ?? ''} ${appleCredential.familyName ?? ''}".trim();

      // Step 5: Get Firebase Messaging Token
      final fcmToken = await FirebaseMessaging.instance.getToken();

      // Step 6: Prepare user data
      final userData = {
        "uid": user?.uid,
        "email": email,
        "name": fullName,
        "photoURL": user?.photoURL,
        "fcmToken": fcmToken,
      };

      onInitGoogle(
          email!,
          fullName,
          user?.photoURL??'',
          fcmToken!
      );

    } catch (e) {
      print("Error during Apple Sign-In: $e");
      rethrow;
    }finally{
      isAppleSignInLoading(false);
    }
  }
*/

  Future<void> onInitGoogle(
      {required String email,
      required String name,
      required String profilePicture,
      required String firebaeAccessToken
      }) async {
    print('init social auth');
    try {
      final headers = {'Content-Type': 'application/json'};
      String fcmToken = await getFcmTokenForLoggedInUser() ?? '';
      final body = {
        'email': email,
        'name': name,
        'profilePicture': profilePicture,
        'fcmToken': fcmToken,
      };

      var response = await http.post(
        Uri.parse(EndPoint.socialAuthURL),
        body: jsonEncode(body),
        headers: headers,
      );

      print('API called: ${EndPoint.socialAuthURL}');
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print('Response data: $responseBody');
        // Ensure the data structure from the response is valid
        if (responseBody['data'] != null) {
          String userId = responseBody['data']['id'];
          String accessToken = responseBody['data']['accessToken'];
          String refreshToken = responseBody['data']['refreshToken'];

          // Save necessary data to local storage
          // LocalStorage.saveData(key: "userId", data: userId);
          // LocalStorage.saveData(key: "access_token", data: accessToken);
          // LocalStorage.saveData(key: "refreshToken", data: refreshToken);

          LocalStorage.saveData(key: "access_token", data: accessToken);
          LocalStorage.saveData(key: userId, data: userId);
          LocalStorage.saveData(key: "refreshToken", data: refreshToken);

          print('Google token : $accessToken');
          print('Google refresh token : $refreshToken');
          print('Google userId : $userId');
        } else {
          print("Unexpected API response structure: ${response.body}");
          throw "API response is missing required fields.";
        }
      } else {
        print("Sign-in failed with status: ${response.statusCode}");
        throw 'Sign-in failed with status: ${response.statusCode}';
      }
    } on SocketException catch (_) {
      Get.rawSnackbar(
          message: 'Not connected to the internet.',
          backgroundColor: Colors.red);
    } catch (e) {
      print("Error during Google API sign-in: ${e.toString()}");
    }
  }
}
