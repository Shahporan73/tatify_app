import 'package:get/get.dart';
import 'package:tatify_app/data/local_database/local_data_base.dart';

class FilterController extends GetxController {
  final selectedDay = "7days".obs;

  final RxList<String> tags = <String>[].obs;
  final RxList<String> historyTags = <String>[].obs;

  // Internal storage list for history tags (not reactive)
  List<String> _historyTagsStorage = [];

  @override
  void onInit() {
    super.onInit();

    final savedTags = LocalStorage.getData(key: 'tags');
    if (savedTags != null && savedTags is List) {
      try {
        tags.assignAll(savedTags.cast<String>());
      } catch (_) {
        tags.clear();
      }
    }

    final savedHistoryTags = LocalStorage.getData(key: 'historyTags');
    if (savedHistoryTags != null && savedHistoryTags is List) {
      try {
        _historyTagsStorage = savedHistoryTags.cast<String>();
        historyTags.assignAll(_historyTagsStorage);
      } catch (_) {
        _historyTagsStorage.clear();
        historyTags.clear();
      }
    }

  }

  void selectDay(String day) {
    selectedDay.value = day;
  }

  void addTag(String tag) {
    if (tag.isNotEmpty && !tags.contains(tag)) {
      tags.add(tag);
    }
  }

  void removeTag(String tag) {
    tags.remove(tag);
  }

  void addHistoryTag(String tag) {
    if (tag.isNotEmpty && !_historyTagsStorage.contains(tag)) {
      _historyTagsStorage.add(tag);
    }
  }

  void removeHistoryTag(String tag) {
    _historyTagsStorage.remove(tag);
    historyTags.remove(tag);
  }

  void saveTags() {
    LocalStorage.saveData(key: 'tags', data: tags.toList());
  }

  void saveHistoryTags() {
    LocalStorage.saveData(key: 'historyTags', data: _historyTagsStorage);
  }

  void refreshHistoryTagsUI() {
    historyTags.assignAll(_historyTagsStorage);
  }
}
