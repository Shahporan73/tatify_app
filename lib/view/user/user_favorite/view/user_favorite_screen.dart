
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import 'package:tatify_app/view/user/user_favorite/view/user_fav_details_screen.dart';

import '../../../../res/custom_style/custom_style.dart';
import '../widget/favorite_widget.dart';

class UserFavoriteScreen extends StatelessWidget {
  const UserFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: MainAppBar(
          title: 'Favorite',
        leading: SizedBox(),
        backgroundColor: AppColors.bgColor,
      ),
      body: Padding(
        padding: bodyPadding,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 15,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => UserFavDetailsScreen());
              },
              child: FavoriteWidget(
                imagePath: 'https://t4.ftcdn.net/jpg/02/74/99/01/360_F_274990113_ffVRBygLkLCZAATF9lWymzE6bItMVuH1.jpg',
                title:  'SPICETRAILS Altstadt',
                reviewsAndRating: '4.3(17)',
                distance: '2km',
                on2for1Click: () {},
                onFreeSoftClick: () {},
              ),
            );
          },
        ),
      ),
    );
  }
}
