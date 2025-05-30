import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tatify_app/res/app_images/App_images.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_network_image_widget.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/view/splash/controller/splash_controller.dart';
import 'package:tatify_app/view/splash/view/welcome_screen.dart';

import '../../../res/app_colors/App_Colors.dart';
import '../model/get_banner_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final SplashController splashController = Get.put(SplashController());
  final PageController _pageController = PageController(initialPage: 0);

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    splashController.getBanner();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xffF5EAE9),
      body: SafeArea(
        child: Obx(() {
          final banners = splashController.bannerList;

          if (banners.isEmpty) {
            return const Center(child: SpinKitCubeGrid(color: AppColors.primaryColor));
          }

          final banner = banners[_currentPage];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                const SizedBox(height: 20),
                CustomText(
                  title: 'Taste Point',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                CustomText(
                  title: 'Restaurant App',
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: Get.height / 10),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(24, 80, 24, 40),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xffFF4F00).withOpacity(0.8),
                            const Color(0xFFF04B6C),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          SizedBox(
                            height: height / 2.5,
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: banners.length,
                              onPageChanged: (index) {
                                setState(() {
                                  _currentPage = index;
                                });
                              },
                              itemBuilder: (context, index) {
                                final bannerItem = banners[index];
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      bannerItem.title?.tr ?? '',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.lato(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      bannerItem.description?.tr ?? '',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.lato(
                                        color: Colors.white70,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                          SmoothPageIndicator(
                            controller: _pageController,
                            count: banners.length,
                            effect: ExpandingDotsEffect(
                              activeDotColor: Colors.white,
                              dotColor: Colors.white54,
                              dotHeight: 8,
                              dotWidth: 8,
                              spacing: 8,
                            ),
                          ),
                          const SizedBox(height: 32),
                          CustomButton(
                            title: 'Get Started',
                            borderRadius: 25,
                            onTap: () {
                              Get.to(() => WelcomeScreen());
                            },
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: - Get.height / 12,
                      left: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        child: ClipOval(
                          child: CustomNetworkImage(
                            imageUrl: banner.image ?? '',
                            width: Get.width / 3,
                            height: Get.height / 6.5,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
