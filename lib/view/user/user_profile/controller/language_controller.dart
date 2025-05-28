import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../data/local_database/local_data_base.dart';
import '../../../../data/utils/const_value.dart';

class LanguageController extends GetxController {
  // Primary language is German
  var selectedLanguage = 'de'.obs;

  final Map<String, String> languages = {
    'de': 'Deutsch',
    'en': 'English',
    'tr': 'Türkçe',
    'es': 'Español',
    'zh': '中文',
  };

  @override
  void onInit() {
    super.onInit();
    loadSavedLanguage();
  }

  Future<void> loadSavedLanguage() async {
    String? langCode = await LocalStorage.getData(key: language);
    if (langCode != null && languages.containsKey(langCode)) {
      selectedLanguage.value = langCode;
      Get.updateLocale(Locale(langCode));
    } else {
      selectedLanguage.value = 'de';
      Get.updateLocale(Locale('de'));
    }
  }

  void selectLanguage(String langCode) async {
    selectedLanguage.value = langCode;
    await LocalStorage.saveData(key: language, data: langCode);
    Get.updateLocale(Locale(langCode));
  }
}
