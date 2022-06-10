import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LastGames extends StatelessWidget {
  const LastGames({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.only(left: 20),
        child: Text('Resultado dos jogos', style: TextStyle(fontSize: 25),)),
        const SizedBox(height: 15,),
      SizedBox(
      height: Get.height /2.2,
      width: Get.width,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: ((context, index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 20),
        child: Column(children: [
        Row(
        children: [
          Container(
            color: index >= 2 ? Colors.red : Colors.blue,
            height: 25,
            width: 5,
          ),
          const SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const Text('Data: 23/02', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, height: 2)),
            Row(children: const[
              Text('Atletico-MG ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
              SizedBox(width: 5,),
              Text('1 x 1 ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
              SizedBox(width: 5,),
              Text('Sport', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
              SizedBox(width: 60,),
              Text('Ver mais', style: TextStyle(fontSize: 12),)
            ],)
          ]),
        ],
      ),
      const SizedBox(height: 8,),
      const Divider(color: Colors.white70, indent: 25, endIndent: 20, thickness: 1.5,)
      ]));
    })))]);
  }
}