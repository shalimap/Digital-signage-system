import '../data/models/content_model.dart';

class ContentController {
  int currentIndex = 0;
  List<ContentModel> contents = [];

  void nextContent() {
    currentIndex = (currentIndex + 1) % contents.length;
  }
}