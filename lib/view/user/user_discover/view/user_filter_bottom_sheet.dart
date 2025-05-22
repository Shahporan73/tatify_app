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
    "7days",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  final FilterController controller = Get.put(FilterController());
  final TextEditingController decorationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.refreshHistoryTagsUI();
  }

  void _addTag(String tag) {
    if (tag.isEmpty) return;
    controller.addTag(tag);
    controller.addHistoryTag(tag);
    controller.saveHistoryTags();
    decorationController.clear();
  }

  void _removeTag(String tag) {
    controller.removeTag(tag);
  }

  void _removeHistoryTag(String tag) {
    controller.removeHistoryTag(tag);
    controller.saveHistoryTags();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Container(
          height: height / 1.1,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: const BoxDecoration(
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
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.cancel_outlined,
                      color: Colors.redAccent,
                      size: 30,
                    ),
                  ),
                ),
                heightBox10,
                CustomText(
                  title: "Day",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                const SizedBox(height: 10),
                Obx(
                      () => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: days.map((day) {
                        bool isSelected = controller.selectedDay.value == day;
                        return GestureDetector(
                          onTap: () => controller.selectDay(day),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
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
                  ),
                ),
                heightBox20,
                CustomText(
                  title: "Kitchen Style",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                heightBox10,
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                            () => Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: controller.tags.map((tag) {
                            return Chip(
                              label: Text(
                                tag,
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              backgroundColor: Colors.green[50],
                              deleteIcon: const Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.red,
                              ),
                              onDeleted: () => _removeTag(tag),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      TextField(
                        controller: decorationController,
                        decoration: InputDecoration(
                          hintText: 'Enter style and press Enter',
                          border: InputBorder.none,
                          hintStyle: GoogleFonts.urbanist(
                            color: const Color(0xff595959),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        onSubmitted: _addTag,
                      ),
                    ],
                  ),
                ),
                heightBox5,
                Obx(
                      () => Column(
                    children: controller.historyTags.map((tag) {
                      return SizedBox(
                        height: 40,
                        child: ListTile(
                          title: CustomText(
                            title: tag,
                            color: Colors.grey,
                          ),
                          leading: const Icon(
                            Icons.history,
                            color: Colors.grey,
                          ),
                          onTap: () {
                            if (!controller.tags.contains(tag)) {
                              controller.addTag(tag);
                            }
                          },
                          trailing: GestureDetector(
                            onTap: () {
                              _removeHistoryTag(tag);
                            },
                            child: const Icon(
                              Icons.clear,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
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
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    widthBox20,
                    Expanded(
                      child: CustomButton(
                        title: 'Apply',
                        buttonColor: AppColors.secondaryColor,
                        titleColor: AppColors.whiteColor,
                        onTap: () {
                          controller.saveTags();
                          controller.saveHistoryTags();
                          Navigator.pop(context);
                          Get.to(() => FilteredResultScreen());

                        },
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
