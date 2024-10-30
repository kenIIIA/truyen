import 'dart:convert';
import 'dart:isolate';

class Helper {
  static void parseDataIsolate(List<dynamic> send, Object a) {
    SendPort sendPort = send[0];

    // final parsed = jsonDecode(jsonEncode(send[1]));

    sendPort.send(a);
  }
}
