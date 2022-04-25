import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:game_data_bloc/logic/app_event.dart';
import 'package:game_data_bloc/presentation/screen/detail_screen.dart';
import 'package:game_data_bloc/utility/extensions.dart';

import '/logic/app_state.dart';
import '../../logic/app_bloc.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageHeight = MediaQuery.of(context).size.height / 5;
    final opacity = useAnimationController(
      duration: const Duration(milliseconds: 250),
      reverseDuration: const Duration(milliseconds: 500),
      initialValue: 1.0,
      upperBound: 1.0,
      lowerBound: 0.0,
    );
    final size = useAnimationController(
      duration: const Duration(milliseconds: 250),
      reverseDuration: const Duration(milliseconds: 500),
      initialValue: 1.0,
      upperBound: 1.0,
      lowerBound: 0.0,
    );
    final controller = useScrollController();
    useEffect(() {
      controller.addListener(() {
        final newOpacity = max(imageHeight - controller.offset, 0.0);
        final normalized = newOpacity.nomalize(0.0, imageHeight).toDouble();
        opacity.value = normalized;
        size.value = normalized;
      });
      return null;
    }, [controller]);
    final data = context.watch<AppBloc>().state.data;
    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: SafeArea(
          child: Column(
            children: [
              SizeTransition(
                sizeFactor: size,
                axis: Axis.vertical,
                child: FadeTransition(
                  opacity: opacity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Image.asset(
                      "./assets/images/logo.png",
                      height: imageHeight,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  controller: controller,
                  children: data
                          ?.map((e) => ListTile(
                                title: Text(
                                  e.title.toString(),
                                  style: TextStyle(color: Colors.orangeAccent[400]),
                                ),
                                leading: ClipRRect(
                                  child: Image.network(
                                    e.image,
                                    width: MediaQuery.of(context).size.width / 4,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(MediaQuery.of(context).size.height / 5),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (_) => DetailScreen(data: e)));
                                },
                              ))
                          .toList() ??
                      [],
                ),
              ),
            ],
          ),
        ));
  }
}
