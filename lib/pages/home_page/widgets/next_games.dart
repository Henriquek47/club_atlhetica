import 'package:club_atlhetica/pages/home_page/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NextGames extends GetView<HomeController> {
  const NextGames({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: PageView.builder(
      itemCount: 1,
      itemBuilder: (conxtext, index){
      return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(children: [
            Container(color: Colors.blue, padding: const EdgeInsets.all(50)),
            FutureBuilder(
              future: controller.getNamedTeam(true, index),
              builder: (context, snapshot) =>
            Text(snapshot.data.toString())
        )]),
            Column(children: const [
              Text('Data do jogo'),
              SizedBox(height: 5,),
              Text('22/05', style: TextStyle(fontSize: 20),),
            ]),
            Column(
              children: [
            Container(color: Colors.amber, padding: const EdgeInsets.all(50)),
            const Text('São Paulo')
            ]),          ]
        ),
        const SizedBox(height: 10),
        Column(
          children: const [
          Text('Aposta', style: TextStyle(fontSize: 17),),
          SizedBox(height: 10,),
          Text('Cor-Hand.FT 0.0', style: TextStyle(fontSize: 17),),
          SizedBox(height: 10,),
          Text('Ver mais', style: TextStyle(),)
        ]),
      ]
    );
  }));
  }
}