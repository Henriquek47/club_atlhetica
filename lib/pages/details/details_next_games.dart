import 'package:club_atlhetica/pages/home_page/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsNextGames extends GetView<HomeController> {
  const DetailsNextGames({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> list = ['Goals', 'Chures no gol', 'Defesas', 'Posse de bola', 'Escanteio', 'Faltas', 'Cartão amarelo', 'Cartão Vermelho'];
    return Expanded(child: Obx(() => Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: Get.height * 0.4,
      width: Get.width * 0.8,
      decoration: BoxDecoration(
        color: controller.darkBool.value ?Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: controller.statistic.isEmpty ? const Center(child: CircularProgressIndicator())
       : 
       Column(children: [
        const SizedBox(height: 20,),
        const Text('Estatistica das 10 partidas'),
        const SizedBox(height: 20,),
        Expanded(
          child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          List listStatisticHome = [
      controller.statistic['home']?.goalsHome, controller.statistic['home']?.shotsOnGoal, controller.statistic['home']?.goalkeeperSaves,
      controller.statistic['home']?.ballPossession, controller.statistic['home']?.cornerKicks, controller.statistic['home']?.fouls,
      controller.statistic['home']?.yellowCards, controller.statistic['home']?.redCards,
    ];
    List listStatisticAway = [
      controller.statistic['away']?.goalsAway, controller.statistic['away']?.shotsOnGoal, controller.statistic['away']?.goalkeeperSaves,
      controller.statistic['away']?.ballPossession, controller.statistic['away']?.cornerKicks, controller.statistic['away']?.fouls,
      controller.statistic['away']?.yellowCards, controller.statistic['away']?.redCards,
    ];
        return Padding(padding: const EdgeInsets.only(top: 20, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('${listStatisticHome[index] ?? ''}', style: const TextStyle(fontSize: 12)),
            Center(child: Text(list[index], style: const TextStyle(fontSize: 10),)),
            Text('${listStatisticAway[index] ?? ''}', style: const TextStyle(fontSize: 12)),
          ],
        )); 
       })),
    ]))));
  }
}