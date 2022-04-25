import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/provider/api.dart';
import '/data/repository/repository.dart';
import '/logic/app_event.dart';
import '/logic/app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppStateInitialize(isLoading: false, data: null)) {
    on<AppEventInitialize>((event, emit) async {
      emit(const AppStateLoading(isLoading: true));
      final repository = Repository(api: Api());
      final result = await repository.getData();
      if (result == null) {
        return;
      }
      emit(AppStateInitialize(isLoading: false, data: result));
    });

    // on<AppEventGoToDetailScreen>((event, emit) async {
    //   emit(const AppStateLoading(isLoading: true));
    //   final repository = Repository(api: Api());
    //   final result = await repository.getData();
    //   if (result == null) {
    //     return;
    //   }
    //   emit(AppStateShowDetailScreen(
    //     isLoading: false,
    //     data: result[event.index],
    //   ));
    // });
  }
}
