import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefe{
  late SharedPreferences _pref;
  bool darkMode = false;
  int screen = 0;

  initSharedPrefe()async{
    _pref = await SharedPreferences.getInstance();
    await _readData();
  }

  Future<bool> _readData()async{
    final dark = _pref.getBool("dark") ?? false;
    final getScreen = _pref.getInt("screen") ?? 0;
    screen = getScreen;
    darkMode = dark;
    return darkMode;
  }

  setDarkMode(bool darkMode)async{
    await _pref.setBool("dark", darkMode);
    await _readData();
  }

  setScreen(int screen)async{
    await _pref.setInt("screen", screen);
    await _readData();
  }

}