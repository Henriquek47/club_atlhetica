import 'package:club_atlhetica/pages/home_page/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerHome extends GetView<HomeController> {
  const DrawerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool expanded = false;
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
                          return ListTile(
                            title: Text('Competições', style: TextStyle(fontWeight: FontWeight.w300),),
                          );
                        },
                        body: Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                          ListTile(
                          tileColor: Colors.green[400],
                          title: Text('Brasileirão', style: TextStyle(fontWeight: FontWeight.w300),),
                        ),
                        ListTile(
                          tileColor: Colors.transparent,
                          title: Text('Champions', style: TextStyle(fontWeight: FontWeight.w300),),
                        ),
                        ListTile(
                          tileColor: Colors.transparent,
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
