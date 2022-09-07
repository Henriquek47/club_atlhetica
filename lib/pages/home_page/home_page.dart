import 'dart:async';

import 'package:club_atlhetica/layers/service/repository/url.dart';
import 'package:club_atlhetica/pages/home_page/home_controller.dart';
import 'package:club_atlhetica/pages/home_page/widgets/drawer_home.dart';
import 'package:club_atlhetica/pages/home_page/widgets/last_games.dart';
import 'package:club_atlhetica/pages/home_page/widgets/next_games.dart';
import 'package:club_atlhetica/pages/profile_page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../layers/entities/round.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) => SafeArea(child: Scaffold(
      endDrawer: const Drawer(
        child: DrawerHome()),
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
        Obx(() {
          if(controller.roundAll.isEmpty || controller.roundNext.isEmpty && controller.timer.value == 0){
            controller.timerLoad();
            return const Center(child: CircularProgressIndicator(),);
          }else if(controller.roundNext.isEmpty && controller.timer.value == 1){
            return const Center(child: Text('Sem jogos no momento'));
          }else{
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            controller.screen.value == 0 ? const NextGames() : const ProfilePage(),
            const LastGames()
      ]);}},),
      Builder(
        builder: (context) => Positioned(
          right: 10,
          height: 60,
        child: IconButton(
          icon: const Icon(Icons.view_headline_outlined),
          onPressed: (){
            Scaffold.of(context).openEndDrawer();
          },
          )))
    ]))));
  }
}