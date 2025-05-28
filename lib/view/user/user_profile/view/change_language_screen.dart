import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatify_app/res/app_colors/App_Colors.dart';
import 'package:tatify_app/res/common_widget/main_app_bar.dart';
import '../../../../data/local_database/local_data_base.dart';
import '../../../../data/utils/const_value.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({Key? key}) : super(key: key);

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  String selectedLanguage = 'de';

  final Map<String, String> languages = {
    'de': 'Deutsch',
    'en': 'English',
    'tr': 'Türkçe',
    'es': 'Español',
    'zh': '中文',
  };

  @override
  void initState() {
    super.initState();
    loadSavedLanguage();
  }

  Future<void> loadSavedLanguage() async {
    String? langCode = await LocalStorage.getData(key: language);
    if (langCode != null && languages.containsKey(langCode)) {
      setState(() {
        selectedLanguage = langCode;
      });
      Get.updateLocale(Locale(langCode));
    } else {
      setState(() {
        selectedLanguage = 'de';
      });
      Get.updateLocale(Locale('de'));
    }
  }

  void selectLanguage(String langCode) async {
    if (!languages.containsKey(langCode)) return;
    await LocalStorage.saveData(key: language, data: langCode);
    setState(() {
      selectedLanguage = langCode;
    });
    Get.updateLocale(Locale(langCode));
    print('Language changed to: $langCode');
  }

  @override
  Widget build(BuildContext context) {
    const Color goldColor = AppColors.primaryColor;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(title: 'language'.tr),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: languages.entries.map((entry) {
            final langCode = entry.key;
            final langName = entry.value;
            final isSelected = selectedLanguage == langCode;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: GestureDetector(
                onTap: () => selectLanguage(langCode),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: isSelected ? goldColor : goldColor.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        langName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      if (isSelected)
                        Positioned(
                          right: 16,
                          child: Icon(
                            Icons.check_box,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
