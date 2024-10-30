part of 'story.dart';

class StoryLogic extends ChangeNotifier {
  final BuildContext context;

  StoryLogic({required this.context}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Category arg = ModalRoute.of(context)!.settings.arguments as Category;

      getStory(arg.id.toString());
    });
  }

  final CategoryApi service = CategoryApi.client(isLoading: true);

  List<StoryModel> data = [];

  // List<String> data = [];

  // void getStory(String id) async {
  //   try {
  //     await service.getStory(id).then((value) => data = value);
  //     notifyListeners();
  //   } catch (e) {
  //     debugPrint('$e');
  //   }
  // }

  void getStory(String id) async {
    try {
      var receivePort = ReceivePort();

      await service.getStory(id).then((value) {
        Isolate.spawn(parseDataIsolate, [receivePort.sendPort, value])
            .then((valueIsolate) async {
          data = await receivePort.first;

          notifyListeners();

          valueIsolate.kill(priority: Isolate.immediate);

          return;
        });
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  static void parseDataIsolate(List<dynamic> send) {
    SendPort sendPort = send[0];

    final parsed = jsonDecode(jsonEncode(send[1]));

    sendPort.send(
        parsed.map<StoryModel>((json) => StoryModel.fromJson(json)).toList());
  }
}
