import 'package:club_atlhetica/layers/service/url.dart';
import 'package:http/http.dart' as http;

class GetApi{

   Future<String> getApi(String urls) async {
   http.Response response = await http.get(Uri.parse(urls), headers: headers);
    return response.body;
  }
  
}