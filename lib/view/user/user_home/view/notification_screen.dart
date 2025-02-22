// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../res/app_colors/App_Colors.dart';
import '../../../../res/common_widget/custom_app_bar.dart';
import '../../../../res/common_widget/custom_text.dart';
import '../../../../res/custom_style/custom_size.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  appBarName: "Notification",
                  onTap: () {
                    Get.back();
                  },
                ),

                heightBox20,
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Container(
                        // color: Colors.green,
                        width: width * 0.15,
                        child: Row(
                          children: [
                            CircleAvatar(radius: 5, backgroundColor: AppColors.primaryColor,),
                            widthBox5,
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Color(0xffE8EBF0),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.notifications_outlined,
                                color: AppColors.primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      title: CustomText(
                        title: 'Welcome, Your account has been created successfully.',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black33,
                      ),
                      subtitle: CustomText(
                        title: '1 day ago',
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black100,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
