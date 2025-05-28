// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/view/user/user_booking/view/user_booking_screen.dart';
import 'package:tatify_app/view/user/user_discover/view/user_discover_screen.dart';
import 'package:tatify_app/view/user/user_favorite/view/user_favorite_screen.dart';
import 'package:tatify_app/view/user/user_home/view/home_screen.dart';
import 'package:tatify_app/view/user/user_profile/view/user_profile_screen.dart';
import 'package:tatify_app/view/vendor/vendor_add_item/views/added_all_item_screen.dart';
import 'package:tatify_app/view/vendor/vendor_home/views/vendor_home_screen.dart';
import 'package:tatify_app/view/vendor/vendor_profile/views/vendor_profile_screen.dart';
import 'package:tatify_app/view/vendor/vendor_redeem/views/vendor_redeem_screen.dart';

import '../../../../res/app_images/App_images.dart';

class VendorHomeDashboard extends StatefulWidget {
  @override
  _VendorHomeDashboardState createState() => _VendorHomeDashboardState();
}

class _VendorHomeDashboardState extends State<VendorHomeDashboard> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  static List<Widget> _widgetOptions = <Widget>[
    VendorHomeScreen(),
    AddedAllItemScreen(),
    VendorRedeemScreen(),
    VendorProfileScreen()
    ];

  @override
  Widget build(BuildContext context) {
    TextStyle navBarStyle =GoogleFonts.poppins(
        fontSize: 10,
        fontWeight: FontWeight.w400,
      color: Colors.white
    );
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.greenLightHover,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              duration: Duration(milliseconds: 150),
              tabBackgroundColor: AppColors.primaryColor,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: Icons.home,
                  leading: SizedBox(
                    width: 24,  // Set appropriate width
                    height: 24,  // Set appropriate height
                    child: _selectedIndex == 0
                        ? Image.asset(AppImages.homeActive, scale: 4)
                        : Image.asset(AppImages.homeInactive, scale: 4),
                  ),
                  text: 'home'.tr,
                  textStyle: navBarStyle,
                  /*GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: _selectedIndex == 0 ? Colors.white : Color(0xff9DB2CE)
                  ),*/
                ),
                GButton(
                  icon: Icons.home,
                  text: 'add_item'.tr,
                  leading: SizedBox(
                    width: 24,  // Set appropriate width
                    height: 24,  // Set appropriate height
                    child: _selectedIndex == 1 ? Image.asset(AppImages.addItemActive, scale: 4,):
                    Image.asset(AppImages.addItemInActive, scale: 4,),
                  ),
                  textStyle: navBarStyle,
                ),
                GButton(
                  icon: Icons.home,
                  text: 'redeem'.tr,
                  leading: SizedBox(
                    width: 24,  // Set appropriate width
                    height: 24,  // Set appropriate height
                    child: _selectedIndex == 2 ?
                    Image.asset(AppImages.redeemActive, scale: 4,)
                        :Image.asset(AppImages.redeemInActive, scale: 4,),
                  ),
                  textStyle: navBarStyle,
                ),
                GButton(
                  icon: Icons.home,
                  text: 'profile'.tr,
                  leading: SizedBox(
                    width: 24,  // Set appropriate width
                    height: 24,  // Set appropriate height
                    child: _selectedIndex == 3 ?
                    Image.asset(AppImages.profileActive, scale: 4,) :
                    Image.asset(AppImages.profileInactive, scale: 4,),
                  ),
                  textStyle: navBarStyle,
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}