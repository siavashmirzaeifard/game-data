import 'package:http/http.dart' as http;

class Api {
  Future<http.Response> getRawData() async {
    final http.Response response;
    try {
      response = await http.get(Uri.parse("https://www.gamerpower.com/api/giveaways"));
    } on Exception catch (_) {
      rethrow;
    }
    return response;
  }
}
