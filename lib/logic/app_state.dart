import 'package:flutter/foundation.dart' show immutable;

import '/data/model/data.dart';

@immutable
abstract class AppState {
  final bool isLoading;
  const AppState({required this.isLoading});
}

@immutable
class AppStateInitialize extends AppState {
  final List<Data>? data;
  const AppStateInitialize({
    required bool isLoading,
    this.data,
  }) : super(isLoading: isLoading);
}

@immutable
class AppStateLoading extends AppState {
  const AppStateLoading({required bool isLoading}) : super(isLoading: isLoading);
}

// @immutable
// class AppStateShowDetailScreen extends AppState {
//   const AppStateShowDetailScreen({
//     required bool isLoading,
//     required Data data,
//   }) : super(isLoading: isLoading);
// }

extension GetData on AppState {
  List<Data>? get data {
    final cls = this;
    if (cls is AppStateInitialize) {
      return cls.data;
    } else {
      return null;
    }
  }
}

// extension GetItem on AppState {
//   Data? get item {
//     final cls = this;
//     if (cls is AppStateShowDetailScreen) {
//       return cls.item;
//     } else {
//       return null;
//     }
//   }
// }
