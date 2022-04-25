import 'package:flutter/foundation.dart' show immutable;
import 'package:game_data_bloc/data/model/data.dart';

@immutable
abstract class AppEvent {
  const AppEvent();
}

@immutable
class AppEventInitialize implements AppEvent {
  const AppEventInitialize();
}

// @immutable
// class AppEventGoToDetailScreen implements AppEvent {
//   final int index;
//   const AppEventGoToDetailScreen({required this.index});
// }
