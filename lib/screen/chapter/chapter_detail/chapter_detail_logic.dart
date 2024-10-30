part of 'chapter_detail.dart';

class ChapterDetailLogic extends ChangeNotifier {
  final BuildContext context;

  ChapterDetailLogic({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      List<ChapterModel> agr =
          ModalRoute.of(context)!.settings.arguments as List<ChapterModel>;
      getChapterDetail(agr.first.id.toString());
    });
  }

  final CategoryApi service = CategoryApi.client(isLoading: true);

  ChapterIDModel? data;

  bool dark = false;

  bool checkHorizontal = false;

  double count = 18;

  String font = '';

  void getChapterDetail(String id) async {
    try {
      await service.getChaptersID(id).then((value) {
        data = value;
        // print(data.id);
        notifyListeners();
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  void tang() {
    count++;
    notifyListeners();
  }

  void changDark() {
    dark = !dark;
    notifyListeners();
  }

  void giam() {
    count--;
    notifyListeners();
  }

  void checkFullScreen() {
    checkHorizontal = !checkHorizontal;
    checkHorizontal
        ? SystemChrome.setPreferredOrientations(
            [DeviceOrientation.landscapeRight])
        : SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    notifyListeners();
  }

  void changFont(int value) {
    if (value == 0) {
      font = '';
      notifyListeners();
      return;
    }
    if (value == 1) {
      font = GoogleFonts.lato().fontFamily!;
      notifyListeners();
      return;
    }
    font = GoogleFonts.montserrat().fontFamily!;
    notifyListeners();
  }
}
