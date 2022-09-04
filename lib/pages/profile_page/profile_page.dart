import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
                  color: Colors.transparent,
                  height: Get.height * 0.5,
                   width: Get.width,
                  child: Stack(children: [
                    Align(
                      alignment: const Alignment(0, -0.9),
                      child: Text('Club Athletica', style: TextStyle(fontSize: Get.textScaleFactor * 10),),
                    ),
                    Padding(padding: EdgeInsets.only(top: Get.height * 0.05),
                  child:Center(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(color: Colors.black, blurRadius: 10, spreadRadius: -1, offset: Offset(0, 6))
          ],
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[900],
            ),
        height: Get.height * 0.32,
        width: Get.width * 0.65,
        child: Column(children: [
          const SizedBox(height: 25,),
          Container(
            height: Get.height * 0.12,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20,),
          Text('Laura Gomes', style: TextStyle(fontSize: Get.textScaleFactor * 15)),
          const SizedBox(height: 20,),
          Container(
            alignment: Alignment.center,
            height: Get.height * 0.04,
            width: Get.width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.green[400],
            ),
            child: Text('Lucro R\$ 520,00', style: TextStyle(fontSize: Get.textScaleFactor * 10)),
          )
        ]),
      )
    ))]));
  }
}