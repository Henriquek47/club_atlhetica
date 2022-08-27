import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class DrawerHome extends StatefulWidget {
  const DrawerHome({Key? key}) : super(key: key);

  @override
  State<DrawerHome> createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  int selectElement = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text('Clube Atletic')),
          Expanded(child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
          children: [
            ListTile(
              title: Text('Competições', style: TextStyle(fontSize: Get.textScaleFactor * 14, fontWeight: FontWeight.w300),),
            ),
            const SizedBox(height: 10,),
            ListTile(
              onTap: (){
                setState(() {
                  selectElement = 0;
                });
              },
              tileColor: selectElement == 0 ? Colors.green[400] : Colors.transparent,
              title: Text('Perfil', style: TextStyle(fontSize: Get.textScaleFactor * 14, fontWeight: FontWeight.w300)),
            ),
            const SizedBox(height: 10,),
            ListTile(
              onTap: (){
                setState(() {
                  selectElement = 1;
                });
              },
              tileColor: selectElement == 1 ? Colors.green[400] : Colors.transparent,
              title: Text('Próximos Jogos', style: TextStyle(fontSize: Get.textScaleFactor * 14, fontWeight: FontWeight.w300)),
            ),
            const SizedBox(height: 10,),
            ListTile(
              title: Text('Modo dark', style: TextStyle(fontSize: Get.textScaleFactor * 14, fontWeight: FontWeight.w300)),
            ),
            const SizedBox(height: 10,),
            ListTile(
              title: Text('Desconectar/Sair', style: TextStyle(fontSize: Get.textScaleFactor * 14, fontWeight: FontWeight.w300)),
            ),
          ],
        )),
      ]);
  }
}