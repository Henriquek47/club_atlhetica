import 'package:club_atlhetica/pages/home_page/home_controller.dart';
import 'package:club_atlhetica/pages/home_page/widgets/last_games.dart';
import 'package:club_atlhetica/pages/home_page/widgets/next_games.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../layers/entities/round.dart';

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
                Colors.transparent,
                Colors.transparent
              ],
              begin: Alignment(0, -3),
              end: Alignment.center
            )
          ),
        ),
        FutureBuilder<List<Round>>(
      future: controller.getRound(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            NextGames(snapshot),
            LastGames(snapshot: snapshot),
      ]);
      }else{
        return Center(child: Container(
          color: Colors.transparent,
          height: Get.height * 0.445,
          width: Get.width,
          alignment: Alignment.center,
            child: const CircularProgressIndicator()));
      }
      })
    ]))));
  }
}