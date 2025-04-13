// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/custom_button.dart';
import 'package:tatify_app/res/common_widget/custom_text.dart';
import 'package:tatify_app/res/custom_style/custom_size.dart';
import 'package:tatify_app/view/user/user_discover/controller/filter_controller.dart';
import 'package:tatify_app/view/user/user_discover/view/filtered_result_screen.dart';

class UserFilterBottomSheet extends StatefulWidget {
  const UserFilterBottomSheet({super.key});

  @override
  State<UserFilterBottomSheet> createState() => _UserFilterBottomSheetState();
}

class _UserFilterBottomSheetState extends State<UserFilterBottomSheet> {
  final List<String> days = [
    "Today",
    "Tomorrow",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  final FilterController controller = Get.put(FilterController());

  final TextEditingController decorationController = TextEditingController();
  final List<String> _tags = ['Burgers', 'meat'];

  final List<String> historyTags = [
    'Hamburger','Sandwich','Burrito'
  ];

  void _addTag(String tag) {
    if (tag.isNotEmpty && !_tags.contains(tag)) {
      setState(() {
        _tags.add(tag);
      });
    }
    decorationController.clear();
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  void _removeHistoryTag(String tag) {
    setState(() {
      historyTags.remove(tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            height: height / 1.1,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: ()=> Navigator.pop(context),
                      child: Icon(Icons.cancel_outlined, color: Colors.redAccent, size: 30),
                    ),
                  ),

                  heightBox10,
                  CustomText(
                    title: "Day",
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  const SizedBox(height: 10),
                  Obx(() => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: days.map((day) {
                        bool isSelected = controller.selectedDay.value == day;
                        return GestureDetector(
                          onTap: () => controller.selectDay(day),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.green.withOpacity(0.1)
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              day,
                              style: TextStyle(
                                color: isSelected ? Colors.green : Colors.black54,
                                fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),),

                  // category
                  heightBox20,
                  CustomText(title: "Category", fontWeight: FontWeight.w600, fontSize: 16),
                  heightBox10,
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _tags.map((tag) {
                            return Chip(
                              label: Text(tag, style: TextStyle(color: Colors.grey[700])),
                              backgroundColor: Colors.green[50],
                              deleteIcon: Icon(Icons.close, size: 16, color: Colors.red),
                              onDeleted: () => _removeTag(tag),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            );
                          }).toList(),
                        ),
                        TextField(
                          controller: decorationController,
                          decoration: InputDecoration(
                            hintText: 'Enter style and press Enter',
                            border: InputBorder.none,
                            hintStyle: GoogleFonts.urbanist(
                                color: Color(0xff595959),
                                fontWeight: FontWeight.w400,
                                fontSize: 14
                            ),
                          ),
                          onSubmitted: _addTag,
                        ),
                      ],
                    ),
                  ),
                  heightBox5,

                  Column(
                    children: historyTags.map((tag) {
                      return SizedBox(
                        height: 40,
                        child: ListTile(
                          title: CustomText(title: tag, color: Colors.grey,),
                          leading: Icon(Icons.history, color: Colors.grey,),
                          onTap: () {
                            print("Tapped on $tag");
                          },
                          trailing: GestureDetector(
                            onTap: () => _removeHistoryTag(tag),
                            child: Icon(Icons.clear, color: Colors.grey,),
                          ),
                        ),
                      );
                    }).toList(),
                  ),



                  heightBox50,
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          title: 'Reset all',
                          buttonColor: Colors.white,
                          titleColor: AppColors.secondaryColor,
                          border: Border.all(color: AppColors.secondaryColor),
                          onTap: (){
                            Navigator.pop(context);
                          }
                        ),
                      ),
                      widthBox20,
                      Expanded(
                        child: CustomButton(
                            title: 'Apply',
                            buttonColor: AppColors.secondaryColor,
                            titleColor: AppColors.whiteColor,
                            onTap: (){
                              Navigator.pop(context);
                              Get.to(()=> FilteredResultScreen(),
                              );
                            }
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
    );
  }
}

