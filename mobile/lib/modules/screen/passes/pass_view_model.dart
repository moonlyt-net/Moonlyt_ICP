import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moonlyt/modules/model/pass_content.dart';

class ContentListStateNotifier extends StateNotifier<List<Content>> {
  ContentListStateNotifier(List<Content> initialContents)
      : super(initialContents);

  void addContent(Content content) {
    state = [...state, content];
  }

  void incrementCurrentPurchases(String title) {
    state = state.map((content) {
      if (content.title == title) {
        return content.copyWith(currentPurchases: content.currentPurchases + 1);
      }
      return content;
    }).toList();
  }
}

final contentListProvider =
    StateNotifierProvider<ContentListStateNotifier, List<Content>>((ref) {
  return ContentListStateNotifier(contents);
});
