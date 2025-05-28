// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/data/utils/launch_url_service.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/app_images/App_images.dart';
import 'package:tatify_app/res/common_widget/custom_network_image_widget.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/common_widget/dialog/show_full_screen_image_dialog.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';

class RequestRedeemWidget extends StatelessWidget {
  final String title;
  final String price;
  final String description;
  final String location;
  final String? imagePath;
  final bool isRedeem;
  final String userImage;
  final String userName;
  final String userEmail;
  final String userPhone;
  const RequestRedeemWidget(
      {super.key,
      required this.title,
      required this.price,
      required this.description,
      required this.location,
      this.imagePath,
      required this.isRedeem,
      required this.userImage,
      required this.userName,
      required this.userEmail,
      required this.userPhone});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: height / 1.6,
      margin: EdgeInsets.only(bottom: 10),
      color: Colors.white,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImages.historyBackground,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8),
                    ),
                    child: CustomNetworkImage(
                      imageUrl: imagePath ??
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvC1pGhW7_BRwnGuBguLE99tfA0faYflekCA&s',
                      height: height / 5,
                      width: double.infinity,
                    ),
                  ),
                  heightBox5,
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: title,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: AppColors.secondaryColor,
                        ),
                        CustomText(
                          title: '🌟€$price 🌟',
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: AppColors.blackColor,
                        ),
                        heightBox5,
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(0, 1))
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // CustomText(
                              //   title: '2for1 Turkish Mocca',
                              //   fontSize: 18,
                              //   fontWeight: FontWeight.w700,
                              //   color: AppColors.secondaryColor,
                              // ),
                              CustomText(
                                textAlign: TextAlign.start,
                                title: description,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: AppColors.blackColor,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Colors.grey.shade300),
                          shape: BoxShape.circle),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                ShowFullScreenImageDialog(imageUrl: userImage),
                          );
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(userImage),
                        ),
                      ),
                    ),
                    trailing: InkWell(
                      onTap: () => LaunchUrlService()
                          .makePhoneCall(phoneNumber: userPhone),
                      child: Icon(
                        Icons.phone,
                        color: AppColors.blackColor,
                      ),
                    ),
                    title: CustomText(
                      title: userName,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AppColors.blackColor,
                    ),
                    subtitle: InkWell(
                      onTap: () =>
                          LaunchUrlService().sendEmail(email: userEmail),
                      child: CustomText(
                        title: userEmail,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Spacer(),
                  isRedeem?Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: isRedeem ? Colors.green : Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(width: 1, color: Colors.green)),
                        child: Icon(
                          Icons.done,
                          color: isRedeem ? Colors.white : Colors.green,
                        ),
                      ),
                      widthBox10,
                      CustomText(
                        title: isRedeem ? 'COMPLETED' : 'REDEEM',
                        fontWeight: FontWeight.w600,
                        color: isRedeem ? Colors.green : AppColors.black100,
                        fontSize: 18,
                      )
                    ],
                  ):
                  Container(
                    width: Get.width,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1))
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.document_scanner_outlined,
                          color: AppColors.secondaryColor,
                          size: 16,
                        ),
                        widthBox10,
                        CustomText(title: 'scan_to_redeem'.tr,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColors.black100
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height / 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
