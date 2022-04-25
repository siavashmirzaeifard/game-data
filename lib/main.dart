import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_data_bloc/presentation/screen/detail_screen.dart';
import 'package:lottie/lottie.dart';

import 'logic/app_bloc.dart';
import 'logic/app_event.dart';
import 'logic/app_state.dart';
import 'presentation/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (_) => AppBloc()..add(const AppEventInitialize()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AppBloc, AppState>(builder: (context, appState) {
          if (appState is AppStateInitialize) {
            return const HomeScreen();
          } else if (appState is AppStateLoading) {
            return Scaffold(
              body: Center(
                  child: Lottie.asset(
                "./assets/loading.json",
                width: 100,
              )),
            );
          } else {
            return const Scaffold(
                body: Center(child: Text("Error happened, please Restart the application")));
          }
        }),
      ),
    );
  }
}
