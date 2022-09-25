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
        const Text('Estatística das partidas'),
        const SizedBox(height: 20,),
        Expanded(
          child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          List listStatisticHome = [
      controller.statistic['home']['goals'] ?? 0, controller.statistic['home']['shotsOnGoal'] ?? 0, controller.statistic['home']['goalkeeperSaves'] ?? 0,
      controller.statistic['home']['ballPossession'] ?? 0, controller.statistic['home']['cornerKicks'] ?? 0, controller.statistic['home']['fouls'] ?? 0,
      controller.statistic['home']['yellowCards'] ?? 0, controller.statistic['home']['redCards'] ?? 0,
    ];
    List listStatisticAway = [
      controller.statistic['away']['goals'] ?? 0, controller.statistic['away']['shotsOnGoal'] ?? 0, controller.statistic['away']['goalkeeperSaves'] ?? 0,
      controller.statistic['away']['ballPossession'] ?? 0, controller.statistic['away']['cornerKicks'] ?? 0, controller.statistic['away']['fouls'] ?? 0,
      controller.statistic['away']['yellowCards'] ?? 0, controller.statistic['away']['redCards'] ?? 0,
    ];
        return Padding(padding: const EdgeInsets.only(top: 20, bottom: 20),
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