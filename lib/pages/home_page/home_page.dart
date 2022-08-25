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
      endDrawer: Drawer(
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text('Clube Atletic')),
          Expanded(child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
          children: [
            ListTile(
              tileColor: 0==0 ? Colors.green[400] : Colors.transparent,
              title: Text('Competições', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),),
            ),
            SizedBox(height: 10,),
            ListTile(
              title: Text('Perfil', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
            ),
            SizedBox(height: 10,),
            ListTile(
              title: Text('Próximos Jogos', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
            ),
            SizedBox(height: 10,),
            ListTile(
              title: Text('Modo dark', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
            ),
            SizedBox(height: 10,),
            ListTile(
              title: Text('Desconectar/Sair', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
            ),
          ],
        )),
      ])),
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
      }),
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