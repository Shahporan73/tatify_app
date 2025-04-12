// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/common_widget/custom_drop_down_widget.dart';
import 'package:tatify_app/res/common_widget/custom_row_widget.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/view/vendor/vendor_home/views/search_on_going_item_screen.dart';
import 'package:tatify_app/view/vendor/vendor_home/views/vendor_restaurant_details_screen.dart';
import 'package:tatify_app/view/vendor/vendor_home/widget/first_grap_widget.dart';
import 'package:tatify_app/view/vendor/vendor_home/widget/home_menu_widget.dart';
import 'package:tatify_app/view/vendor/vendor_home/widget/second_grap_widget.dart';
import 'package:tatify_app/view/vendor/vendor_home/widget/v_home_header_widget.dart';

import '../../../../res/app_colors/App_Colors.dart';

class VendorHomeScreen extends StatelessWidget {
  const VendorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //   header
            VHomeHeaderWidget(),

            Column(
              children: [
                heightBox10,
                Center(
                  child: CustomText(
                    title: 'Net Income',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                Center(
                  child: CustomText(
                    title: '\$9,349.85',
                    fontSize: 28,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                heightBox10,
                SizedBox(
                  height: height / 3.2,
                  child: FirstGrapWidget(),
                ),

                heightBox10,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(children: [
                            TextSpan(
                                text: 'Total Commission this month: ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12)),
                            TextSpan(
                                text: '\$1,530',
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16))
                          ])),
                      widthBox10,
                      CustomDropDownWidget(
                          width: width / 4,
                          selectedValue: 'Year',
                          items: ['Year', 'Month', 'Weeks', 'Today'],
                          onChanged: (value) {},
                          hintText: 'Year'),
                    ],
                  ),
                ),

                heightBox20,
                SizedBox(
                  height: height / 4.5,
                  child: SecondGrapWidget(),
                ),

                // OnGoing list
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                child: CustomRowWidget(
                  crossAxisAlignment: CrossAxisAlignment.center,
                    title: CustomText(title: 'Ongoing Menu', fontSize: 16, fontWeight: FontWeight.w600,),
                    value: IconButton(
                      onPressed: () {
                        Get.to(()=>SearchOnGoingItemScreen(), transition: Transition.downToUp);
                      },
                      icon: Icon(Icons.search_outlined, size: 24,),
                    )
                ),),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: 3,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => VendorRestaurantDetailsScreen());
                        },
                        child: HomeMenuWidget(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
