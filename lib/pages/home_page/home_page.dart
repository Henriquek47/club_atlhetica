import 'package:club_atlhetica/pages/details/details_next_games.dart';
import 'package:club_atlhetica/pages/home_page/home_controller.dart';
import 'package:club_atlhetica/pages/home_page/widgets/drawer_home.dart';
import 'package:club_atlhetica/pages/home_page/widgets/last_games.dart';
import 'package:club_atlhetica/pages/home_page/widgets/next_games.dart';
import 'package:club_atlhetica/pages/profile_page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class HomePage extends GetView<HomeController> {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var safePadding = MediaQuery.of(context).padding.top;
    return LayoutBuilder(builder: (context, constraints) => 
    SafeArea(child: Scaffold(
      endDrawer: const Drawer(
        child: DrawerHome()),
      body: Stack(
        children: [
        Container(
          height: MediaQuery.of(context).size.height - safePadding,
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
        Obx((){
          if(controller.roundAll.isEmpty && controller.timer.value == 0){
            controller.timerLoad();
            return const Center(child: CircularProgressIndicator(),);
          }else if(controller.roundAll.isEmpty  && controller.timer.value == 1){
            return const Center(child: Text('Sem conexão com a internet'));
          }else if(controller.roundAll.isNotEmpty){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            controller.screen.value == 0 ? const NextGames() : const ProfilePage(),
            controller.details.value ? const DetailsNextGames() : const LastGames(),
      ]);}else{
        return const Center(child: Text('Sem jogos no momento'));
      }},),
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