part of 'list_chapter.dart';

class ListChapterLogic extends ChangeNotifier {
  final BuildContext context;

  ListChapterLogic({required this.context}) {
    // getCategory();
  }

  final CategoryApi service = CategoryApi.client(isLoading: true);

  // List<Category> dataCategory = [];

  void getListChapter() async {
    try {
      // await service.getCategory().then((value) => dataCategory = value);

      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
    notifyListeners();
  }
}
