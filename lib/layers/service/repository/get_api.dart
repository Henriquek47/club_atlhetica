import 'dart:convert';
import 'package:club_atlhetica/layers/service/url.dart';
import 'package:http/http.dart' as http;

class GetApi{

  getApi(String urls) async {
   http.Response response = await http.get(Uri.parse(urls), headers: headers);
    var body = jsonDecode(response.body);
    return await body;
  }
  
}