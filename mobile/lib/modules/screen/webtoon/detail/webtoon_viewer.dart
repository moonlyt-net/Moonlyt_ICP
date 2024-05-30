import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WebtoonViewer extends ConsumerStatefulWidget {
  const WebtoonViewer({required this.id, super.key});
  final String id;
  @override
  ConsumerState<WebtoonViewer> createState() => _WebtoonViewerState();
}

class _WebtoonViewerState extends ConsumerState<WebtoonViewer> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
