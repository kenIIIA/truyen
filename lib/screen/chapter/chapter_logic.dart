part of 'chapter_ui.dart';

class ChapterLogic extends ChangeNotifier {
  final BuildContext context;

  ChapterLogic({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      StoryModel agr = ModalRoute.of(context)!.settings.arguments as StoryModel;
      getChapter(agr.slug);
    });
  }

  final CategoryApi service = CategoryApi.client(isLoading: false);

  List<ChapterModel> data = [];

  List<ChapterModel> dataArg = [];

  void getChapter(String slug) async {
    try {
      await service.getChapters(slug).then((value) {
        dataArg = value.reversed.toList();
        int startIndex = 0;
        int endIndex = 5;
        data = value.sublist(startIndex, endIndex);
        notifyListeners();
      });
    } catch (e) {
      debugPrint('$e');
    }
  }
}
