// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tatify_app/res/app_images/App_images.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/view/splash/view/welcome_screen.dart';

import '../../../res/app_colors/App_Colors.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});
  final PageController _pageController = PageController();

  // Translation keys for titles
  final List<String> titleKeys = [
    'ramadan_dining_reimagined',
    'savor_every_flavor',
    'exclusive_iftar_deals',
  ];

  // Translation keys for descriptions
  final List<String> descriptionKeys = [
    'discover_a_world_of_culinary_experiences_for_the_holy_month',
    'explore_a_rich_variety_of_dishes_crafted_to_delight_your_taste_buds',
    'enjoy_special_offers_on_iftar_meals_crafted_just_for_you',
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xffFFFAFB),
              const Color(0xFFFFD7C599),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        title: 'taste_hub'.tr,
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      CustomText(
                        title: 'restaurant_app'.tr,
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: height / 7,
                      ),
                      Container(
                        height: height / 1.68,
                        width: width,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding:
                        EdgeInsets.only(left: 20, right: 20, top: 100, bottom: 100),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xffFF4F00).withOpacity(0.5),
                                Color(0xFFF04B6C),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(38)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // PageView Builder
                            Expanded(
                              child: PageView.builder(
                                itemCount: titleKeys.length,
                                controller: _pageController,
                                onPageChanged: (index) {
                                  // setState(() {
                                  //   _currentPage = index;
                                  // });
                                },
                                itemBuilder: (context, index) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        title: titleKeys[index].tr,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.lato(
                                          color: AppColors.whiteColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 26,
                                        ),
                                      ),
                                      heightBox10,
                                      CustomText(
                                        title: descriptionKeys[index].tr,
                                        style: GoogleFonts.lato(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),

                            // SmoothPageIndicator
                            SmoothPageIndicator(
                              controller: _pageController,
                              count: titleKeys.length,
                              effect: ExpandingDotsEffect(
                                dotHeight: 8,
                                dotWidth: 8,
                                spacing: 6,
                                activeDotColor: Colors.white,
                                dotColor: Colors.white.withOpacity(0.4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // image
                Positioned(
                  top: height / 8,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    AppImages.onBoardingImage,
                    width: width / 4,
                    height: height / 4,
                  ),
                ),

                // button
                Positioned(
                  bottom: height / 10,
                  left: 60,
                  right: 60,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            spreadRadius: 0,
                            blurRadius: 24,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]),
                    child: CustomButton(
                      title: 'get_started'.tr,
                      borderRadius: 16,
                      onTap: () {
                        Get.to(() => WelcomeScreen());
                      },
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
