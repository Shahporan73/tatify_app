// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/app_images/App_images.dart';
import 'package:tatify_app/res/common_widget/custom_network_image_widget.dart';
import 'package:tatify_app/res/common_widget/custom_row_widget.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';

class HistoryWidget extends StatelessWidget {
  final String foodImage;
  final String foodName;
  final String foodPrice;
  final String foodDescription;
  final String redeemDate;
  final String userName;
  final String userEmail;
  final String userPhone;
  const HistoryWidget(
      {super.key,
      required this.foodImage,
      required this.foodName,
      required this.foodPrice,
      required this.foodDescription,
      required this.redeemDate,
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
                      imageUrl: foodImage.isNotEmpty
                          ? foodImage:
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
                          title: foodName,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: AppColors.secondaryColor,
                        ),
                        CustomText(
                          title: '🌟€$foodPrice Bowl 🌟',
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: AppColors.blackColor,
                        ),
                        heightBox5,
                        Container(
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
                                title: foodDescription,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.blackColor,
                              ),
                            ],
                          ),
                        ),
                        heightBox5,
                        CustomRowWidget(
                            title: Text(
                              'Date : ',
                              style: keyStyle,
                            ),
                            value: Text(
                              redeemDate,
                              style: keyStyle,
                            )),
                        CustomRowWidget(
                            title: Text(
                              'Name :',
                              style: keyStyle,
                            ),
                            value: Text(
                              userName,
                              style: keyStyle,
                            )),
                        CustomRowWidget(
                            title: Text(
                              'Gmail :',
                              style: keyStyle,
                            ),
                            value: Text(
                              userEmail,
                              style: keyStyle,
                            )),
                        CustomRowWidget(
                            title: Text(
                              'Phone Number :',
                              style: keyStyle,
                            ),
                            value: Text(
                              userPhone,
                              style: keyStyle,
                            )),
                      ],
                    ),
                  ),
                  Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(width: 1, color: Colors.green)),
                        child: Icon(
                          Icons.done,
                          color: Colors.green,
                        ),
                      ),
                      widthBox10,
                      CustomText(
                        title: 'Complete',
                        fontWeight: FontWeight.w600,
                        color: AppColors.black100,
                        fontSize: 18,
                      )
                    ],
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

final TextStyle keyStyle = TextStyle(
    fontSize: 10, fontWeight: FontWeight.w400, color: AppColors.black100);

/*Container(
width: double.infinity,
margin: EdgeInsets.only(bottom: 10),
height: height / 1.8,
child: Stack(children: [
Positioned.fill(
child: Image.asset(AppImages.historyBackground, fit: BoxFit.fill, width: double.infinity,),),
Positioned(
child: Column(
children: [
ClipRRect(
child: CustomNetworkImage(
imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvC1pGhW7_BRwnGuBguLE99tfA0faYflekCA&s',
height: height / 5,
width: double.infinity
),
),

],
),)
]),
);*/
/*

Container(
width: double.infinity,
height: height / 1.5,
decoration: BoxDecoration(
boxShadow: [
BoxShadow(
color: Colors.grey.withOpacity(0.5),
spreadRadius: 1,
blurRadius: 1,
offset: const Offset(0, 1), // changes position of shadow
),
],
image: DecorationImage(
image: AssetImage(AppImages.historyBackground),
fit: BoxFit.cover,
scale: 4,
alignment: Alignment.center
)
),
)*/
