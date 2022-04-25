import 'dart:io';

import '/data/model/data.dart';
import '/data/provider/api.dart';

class Repository {
  final Api api;
  const Repository({required this.api});
  Future<List<Data>?> getData() async {
    try {
      final rawData = await api.getRawData();
      if (rawData.statusCode >= 200 && rawData.statusCode <= 300) {
        return dataFromJson(rawData.body);
      } else {
        return null;
      }
    } on HttpException catch (_) {
      rethrow;
    } on SocketException catch (_) {
      rethrow;
    } on Exception {
      rethrow;
    }
  }
}
