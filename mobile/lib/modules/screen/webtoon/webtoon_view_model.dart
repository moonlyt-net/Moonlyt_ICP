import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moonlyt/modules/model/webtoon_content.dart';
// 적절한 경로로 변경하세요.

final webtoonContentsProvider = Provider<List<WebtoonContent>>((ref) {
  return webtoonContents;
});
