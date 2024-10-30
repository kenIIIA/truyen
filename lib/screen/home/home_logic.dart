part of 'home.dart';

class HomeLogic extends ChangeNotifier {
  final BuildContext context;

  HomeLogic({required this.context}) {
    getCategory1();
  }

  CategoryApi service = CategoryApi.client(isLoading: true);

  List<Category> dataCategory = [];

  void getCategory() async {
    try {
      var receivePort = ReceivePort();

      await service.getCategory().then((value) {
        Isolate.spawn(parseDataIsolate, [receivePort.sendPort, value])
            .then((valueIsolate) async {
          dataCategory = await receivePort.first;

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

    sendPort
        .send(parsed.map<Category>((json) => Category.fromJson(json)).toList());
  }

  void getCategory1() async {
    try {
      await service.getCategory().then((value) => dataCategory = value);

      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
    notifyListeners();
  }
}
