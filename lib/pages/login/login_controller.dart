import 'package:club_atlhetica/layers/entities/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  RxBool login = false.obs;
  RxBool signIn = true.obs;
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerPasswordConfirm = TextEditingController();
  UserData? userData;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserData?> register(TextEditingController email, TextEditingController password, BuildContext context)async{
    try {
      //final credential  = 
      await _auth.createUserWithEmailAndPassword(email: email.text, password: password.text);
      //await credential.user?.updateDisplayName(name);
      //await credential.user?.updatePhotoURL(photoURL);
      userData = UserData(email.text, 'url', 'name');
      return userData;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Ocorreu um erro desconhecido"))
      );
    }catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()))
      );
    }
    return null;
  }
  Future<UserData?> loginSubmit(TextEditingController email, TextEditingController password, BuildContext context)async{
    try {
      //final credential  = 
      await _auth.signInWithEmailAndPassword(email: email.text, password: password.text);
      //await credential.user?.updateDisplayName(name);
      //await credential.user?.updatePhotoURL(photoURL);
      userData = UserData(email.text, 'url', 'name');
      return userData;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Ocorreu um erro desconhecido"))
      );
    }catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()))
      );
    }
    return null;
  }

  Future<void> logout(BuildContext context)async{
    try {
      await _auth.signOut();
      userData = null;
      Get.offAndToNamed('/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()))
      );
    }
  }
}