import 'package:club_atlhetica/pages/home_page/home_controller.dart';
import 'package:club_atlhetica/pages/home_page/widgets/last_games.dart';
import 'package:club_atlhetica/pages/home_page/widgets/next_games.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          SizedBox(height: 20,),
        Text('Club Atlhetica'),
        SizedBox(height: 90),
        NextGames(),
        LastGames(),
      ])
    );
  }
}