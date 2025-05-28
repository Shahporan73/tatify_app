// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatify_app/data/utils/custom_loader.dart';
import '../app_colors/App_Colors.dart';
import '../custom_style/custom_size.dart';
import 'custom_button.dart';
import 'dialog/show_full_screen_image_dialog.dart';

class CustomAlertDialog {

  Future<void> customAlert({
    required BuildContext context,
    required String title,
    required String message,
    required String NegativebuttonText,
    required String PositivvebuttonText,
    required VoidCallback onPositiveButtonPressed,
    required VoidCallback onNegativeButtonPressed,
    RxBool? isLoading, // Optional RxBool
    bool loadingFallback = false, // fallback for non-reactive usage
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        Widget content() {
          final bool loading = isLoading?.value ?? loadingFallback;

          if (loading) {
            return SizedBox(
              height: 100,
              child: Center(child: CustomLoader(size: 32)),
            );
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      title: PositivvebuttonText,
                      padding_vertical: 10,
                      fontSize: 14,
                      onTap: onPositiveButtonPressed,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomButton(
                      title: NegativebuttonText,
                      padding_vertical: 10,
                      buttonColor: Colors.transparent,
                      titleColor: AppColors.darkPink,
                      border: Border.all(color: AppColors.darkPink),
                      fontSize: 14,
                      onTap: onNegativeButtonPressed,
                    ),
                  ),
                ],
              ),
            ],
          );
        }

        if (isLoading != null) {
          // Reactive mode: wrap content in Obx to listen to RxBool changes
          return AlertDialog(
            backgroundColor: Colors.white,
            content: Obx(content),
          );
        } else {
          // Non-reactive mode: just show once with bool fallback
          return AlertDialog(
            backgroundColor: Colors.white,
            content: content(),
          );
        }
      },
    );
  }

  void showDeleteAccountDialog(
      BuildContext context,
      VoidCallback onPositiveButtonPressed,
      bool isLoading
      ) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Delete Account",
      transitionDuration: Duration(milliseconds: 300), // Animation duration
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.red, size: 40),
                SizedBox(height: 20),
                Text(
                  "Delete Account",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    decoration: TextDecoration.none,
                    fontFamily: 'Montserrat',
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Are you sure you want to delete your account? This action cannot be undone.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    decoration: TextDecoration.none,
                    fontFamily: 'Montserrat',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                isLoading ? CustomLoader() : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close dialog
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: onPositiveButtonPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedValue = Curves.easeInOut.transform(animation.value) - 1;
        return Transform.translate(
          offset: Offset(0, curvedValue * -50),
          child: Opacity(
            opacity: animation.value,
            child: child,
          ),
        );
      },
    );
  }

  void showLoaderDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text("Please wait..."),
            ],
          ),
        );
      },
    );
  }

  void showFullScreenImageDialog({required BuildContext context, required String imageUrl}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShowFullScreenImageDialog(imageUrl: imageUrl);
      },
    );
  }

}
