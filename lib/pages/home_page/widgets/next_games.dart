import 'package:club_atlhetica/pages/home_page/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NextGames extends StatefulWidget {
  const NextGames({Key? key}) : super(key: key);

  @override
  State<NextGames> createState() => _NextGamesState();
}

class _NextGamesState extends State<NextGames> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      String data(int index) {
        var data = DateTime.parse(controller.roundNext[index].date!);
        String dataFormat =
            '${data.day <= 9 ? data.day.toString().padLeft(2, '0') : data.day}-${data.month <= 9 ? data.month.toString().padLeft(2, '0') : data.month}';
        String format24hour = data.hour.isEqual(0)
            ? ('${data.day <= 9 ? (data.day - 1).toString().padLeft(2, '0') : data.day - 1}-${data.month <= 9 ? data.month.toString().padLeft(2, '0') : data.month}')
                .toString()
            : dataFormat;
        return format24hour;
      }

      String hour(int index) {
        var data = DateTime.parse(controller.roundNext[index].date!);
        int hour = data.hour.isEqual(0) ? (data.hour + 24) - 3 : data.hour - 3;
        String dataFormat =
            '${hour <= 9 ? hour.toString().padLeft(2, '0') : hour}:${data.minute <= 9 ? data.minute.toString().padLeft(2, '0') : data.minute}';
        return dataFormat;
      }
      return Stack(children: [
        if (controller.roundNext.isNotEmpty)
          Container(
              color: Colors.transparent,
              height: Get.height * 0.45,
              width: Get.width,
              child: Obx(() {
                if (controller.roundNext.isEmpty) {
                  return const Center(child: Text('Sem jogos no momento'));
                } else {
                  return PageView.builder(
                      onPageChanged: ((value) =>
                          controller.details.value = false),
                      itemCount: controller.roundNext.length,
                      itemBuilder: (conxtext, index) {
                        return Stack(children: [
                          Align(
                            alignment: const Alignment(0, -0.9),
                            child: Text(
                              'Club Athletica',
                              style:
                                  TextStyle(fontSize: Get.textScaleFactor * 10),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: Get.height * 0.155),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(children: [
                                            SizedBox(
                                                height: Get.height * 0.1,
                                                width: Get.width * 0.3,
                                                child: Image.network(
                                                    controller.roundNext[index]
                                                        .imageHome!,
                                                    errorBuilder:
                                                        (BuildContext context,
                                                            Object exception,
                                                            StackTrace?
                                                                stackTrace) {
                                                  return const Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                })),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                                alignment: Alignment.center,
                                                width: Get.width * 0.2,
                                                color: Colors.transparent,
                                                child: Text(
                                                  controller.roundNext[index]
                                                      .nameHome!,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize:
                                                          Get.textScaleFactor *
                                                              12),
                                                )),
                                          ]),
                                          Column(children: [
                                            const Text('Data do jogo'),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              data(index),
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Provavel vencedor',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Theme.of(context).hintColor),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                             GestureDetector(
                                          onTap: () async {
                                            await controller.showRewardedAd(
                                                controller
                                                    .roundNext[index].idHome,
                                                controller
                                                    .roundNext[index].idAway,
                                                controller
                                                    .roundNext[index].nameHome!,
                                                controller
                                                    .roundNext[index].nameAway!,
                                                controller.roundNext[index].id);
                                            setState(() {});
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: Get.isDarkMode ? const Color.fromARGB(255, 65, 65, 65) : const Color.fromARGB(255, 19, 19, 19),
                                              borderRadius: BorderRadius.circular(2)
                                            ),
                                            child: controller.analyzing.value == false ? Text(
                                              controller.roundNext[index].winner ?? 'Analisar',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: controller.roundNext[index].winner == null ? 15 : 12,
                                                  color: controller
                                                              .roundNext[index]
                                                              .winner ==
                                                          null
                                                      ? Colors.amber
                                                      : Colors.green),
                                            ): const SizedBox(
                                              height: 15,
                                              width: 15,
                                              child: CircularProgressIndicator(strokeWidth: 2,))),),
                                          ],),
                                          Column(children: [
                                            SizedBox(
                                                height: Get.height * 0.1,
                                                width: Get.width * 0.3,
                                                child: Image.network(
                                                    controller.roundNext[index]
                                                        .imageAway!,
                                                    errorBuilder:
                                                        (BuildContext context,
                                                            Object exception,
                                                            StackTrace?
                                                                stackTrace) {
                                                  return const Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                })),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                                alignment: Alignment.center,
                                                width: Get.width * 0.2,
                                                color: Colors.transparent,
                                                child: Text(
                                                    controller.roundNext[index]
                                                        .nameAway!,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize:
                                                            Get.textScaleFactor *
                                                                12)))
                                          ])
                                        ]),
                                    Column(children: [
                                    const Text('Horário',
                                            style: TextStyle(fontSize: 14)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        hour(index),
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      GestureDetector(
                                          onTap: () async {
                                            controller.details.value =
                                                !controller.details.value;
                                            if (controller.details.value) {
                                              await controller
                                                  .statisticTeamHome(controller
                                                      .roundNext[index].idHome);
                                              await controller
                                                  .statisticTeamAway(controller
                                                      .roundNext[index].idAway);
                                            }
                                          },
                                          child: const Text('Ver mais',
                                              style: TextStyle(fontSize: 12))),
                                    ]),
                                  ]))
                        ]);
                      });
                }
              }))
        else
          const Center(
            child: Text('Sem jogos no momento'),
          ),
      ]);
    });
  }
}
