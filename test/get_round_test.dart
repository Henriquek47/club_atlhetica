// ignore_for_file: unnecessary_string_escapes

import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/service/repository/get_round_api.dart';
import 'package:club_atlhetica/layers/service/repository/url.dart';
import 'package:club_atlhetica/layers/use_cases/get_round.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'get_round_test.mocks.dart';
@GenerateMocks([http.Client])

void main() {

final client = MockClient(); 
  GetRoundApi repository = GetRoundApi(client: client);
  const bodyJson = '{"get":"fixtures","parameters":{"season":"2022","from":"2022-06-02","to":"2022-06-08","league":"71"},"errors":[],"results":15,"paging":{"current":1,"total":1},"response":[{"fixture":{"id":838071,"referee":"Raphael Claus","timezone":"UTC","date":"2022-06-04T10:40:00+00:00","timestamp":1654371000,"periods":{"first":null,"second":null},"venue":{"id":206,"name":"Est\u00e1dio Raimundo Sampaio","city":"Belo Horizonte, Minas Gerais"},"status":{"long":"Not Started","short":"NS","elapsed":null}},"league":{"id":71,"name":"Serie A","country":"Brazil","logo":"https:\/\/media.api-sports.io\/football\/leagues\/71.png","flag":"https:\/\/media.api-sports.io\/flags\/br.svg","season":2022,"round":"Regular Season - 9"},"teams":{"home":{"id":125,"name":"America Mineiro","logo":"https:\/\/media.api-sports.io\/football\/teams\/125.png","winner":null},"away":{"id":1193,"name":"Cuiaba","logo":"https:\/\/media.api-sports.io\/football\/teams\/1193.png","winner":null}},"goals":{"home":null,"away":null},"score":{"halftime":{"home":null,"away":null},"fulltime":{"home":null,"away":null},"extratime":{"home":null,"away":null},"penalty":{"home":null,"away":null}}}]}';
//
  test('Get round information', () async {
   when(client.get(Uri.parse(urlAllNextRound), headers: headers)).thenAnswer((_) async => http.Response(bodyJson, 200));
  // Round result = await repository.getRoundApi(0);
   var getRound = GetRound(repository: repository);
   List<Round> getRoundFunc = await getRound.execute(0);
   final date = getRoundFunc[0].date;
    DateTime now = DateTime.parse(date.toString());
   expect(getRoundFunc[0].id, equals(838071));
   expect(now.year, equals(2022));
   expect(getRoundFunc[0].idHome, equals(125));
   expect(getRoundFunc[0].idAway, equals(1193));
   expect('${now.hour <= 9 ? now.hour.toString().padLeft(2, '0') : now.hour.toString()}:${now.minute.toString()}', equals('10:40'));
   expect(getRoundFunc[0].imageHome, "https:\/\/media.api-sports.io\/football\/teams\/125.png");
   expect(getRound.finishedOrInProgress(now, now), true);
   //expect(result.dateTime, equals('2022-06-0419:30:00+00:00'));
  });
}
