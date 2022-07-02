import 'package:club_atlhetica/pages/home_page/home_controller.dart';
import 'package:club_atlhetica/pages/home_page/widgets/last_games.dart';
import 'package:club_atlhetica/pages/home_page/widgets/next_games.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) => SafeArea(child: Scaffold(
      body: Stack(children: [
        Container(
          height: Get.height,
          width: Get.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.transparent
              ],
              begin: Alignment(0, -3),
              end: Alignment.center
            )
          ),
        ),
        Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
        NextGames(),
        LastGames(),
      ])
    ]))));
  }
}