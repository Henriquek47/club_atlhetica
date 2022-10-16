import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextBarField extends StatefulWidget {
  const TextBarField({Key? key}) : super(key: key);

  @override
  State<TextBarField> createState() => _TextBarFieldState();
}

TextEditingController controller = TextEditingController();
final _formKey = GlobalKey<FormState>();

class _TextBarFieldState extends State<TextBarField> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('E-mail', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),),
                const SizedBox(height: 5),
              SizedBox(
            height: Get.height * 0.08,
          child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 20),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 0.5, color: Colors.white),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'Digite seu e-mail',
                  hintStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
              onSubmitted: (value) {},
              controller: controller,
              onChanged: (text) {},
            ),
          ),])),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Senha', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),),
                const SizedBox(height: 5),
              SizedBox(
            height: Get.height * 0.08,
          child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 20),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 0.5, color: Colors.white),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'Digite sua senha',
                  hintStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
              onSubmitted: (value) {},
              controller: controller,
              onChanged: (text) {},
            ),
          ),],),),
        ],
      ),
    );
  }
}
