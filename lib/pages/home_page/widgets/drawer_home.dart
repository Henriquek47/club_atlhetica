import 'package:club_atlhetica/layers/service/repository/url.dart';
import 'package:club_atlhetica/pages/home_page/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerHome extends GetView<HomeController> {
  const DrawerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text('Clube Atletic')),
      Expanded(
          child: Obx(() => ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
                children: [
                  ListTile(
                    onTap: () async {
                      await controller.setScreen(1);
                    },
                    tileColor: controller.screen.value == 1
                        ? Colors.green[400]
                        : Colors.transparent,
                    title: Text('Perfil',
                        style: TextStyle(
                            fontSize: Get.textScaleFactor * 14,
                            fontWeight: FontWeight.w300)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    onTap: () async {
                      await controller.setScreen(0);
                    },
                    tileColor: controller.screen.value == 0
                        ? Colors.green[400]
                        : Colors.transparent,
                    title: Text('Próximos Jogos',
                        style: TextStyle(
                            fontSize: Get.textScaleFactor * 14,
                            fontWeight: FontWeight.w300)),
                  ),
                  const SizedBox(height: 10,),
                  ExpansionPanelList(
                    elevation: 0,
                    expansionCallback: (int index, bool isExpanded) {
                      controller.expanded.value = !controller.expanded.value;
                    },
                    children: [
                      ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return const ListTile(
                            title: Text('Competições', style: TextStyle(fontWeight: FontWeight.w300),),
                          );
                        },
                        body: Obx(() => ListView(
                            shrinkWrap: true,
                            children: [
                          ListTile(
                            onTap: (){
                              controller.details.value = false;
                              controller.select.value = 0;
                              controller.repository.posLeague = 0;
                              controller.getAllRound();
                              controller.nextRound();
                            },
                          tileColor: controller.select.value == 0 ? Colors.green[400] : Colors.transparent,
                          title: const Text('Brasileirão', style: TextStyle(fontWeight: FontWeight.w300),),
                        ),
                        ListTile(
                          onTap: ()async{
                            controller.details.value = false;
                            controller.select.value = 1;
                            controller.repository.posLeague = 1;
                            controller.getAllRound();
                            controller.nextRound();
                            },
                          tileColor: controller.select.value == 1 ? Colors.green[400] : Colors.transparent,
                          title: Text('Champions', style: TextStyle(fontWeight: FontWeight.w300),),
                        ),
                        ListTile(
                          onTap: (){
                            controller.details.value = false;
                            controller.select.value = 2;
                            controller.repository.posLeague = 2;
                            controller.getAllRound();
                            controller.nextRound();
                            },
                          tileColor: controller.select.value == 2 ? Colors.green[400] : Colors.transparent,
                          title: Text('Copa do Brasil', style: TextStyle(fontWeight: FontWeight.w300),),
                        ),
                      ])),
                        isExpanded: controller.expanded.value,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    title: Text('Modo dark',
                        style: TextStyle(
                            fontSize: Get.textScaleFactor * 14,
                            fontWeight: FontWeight.w300)),
                    trailing: Switch(
                        activeColor: Colors.green,
                        value: controller.darkBool.value,
                        onChanged: (value) async {
                          await controller.darkMode(value);
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    title: Text('Desconectar/Sair',
                        style: TextStyle(
                            fontSize: Get.textScaleFactor * 14,
                            fontWeight: FontWeight.w300)),
                  ),
                ],
              ))),
    ]);
  }
}
