import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefe{
  late SharedPreferences _pref;
  bool darkMode = false;

  initSharedPrefe()async{
    _pref = await SharedPreferences.getInstance();
    await _readData();
  }

  Future<bool> _readData()async{
    final dark = _pref.getBool("dark") ?? false;
    darkMode = dark;
    return darkMode;
  }

  setData(bool darkMode)async{
    await _pref.setBool("dark", darkMode);
    await _readData();
  }

}