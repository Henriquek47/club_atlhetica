import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/entities/team.dart';
import 'package:club_atlhetica/layers/infra/repository/repository.dart';
import 'package:club_atlhetica/layers/service/repository/round_api.dart';
import 'package:club_atlhetica/layers/service/repository/url.dart';
import 'package:club_atlhetica/pages/home_page/home_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../utils/utils.dart';
import '../utils/utils2.dart';
import 'home_controller_test.mocks.dart';

@GenerateMocks([http.Client])
@GenerateMocks([IRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;
  });

  final client = MockClient();
  final repository = MockIRepository();

  test('get winner', ()async{
   when(client.get(Uri.parse(setUrlTeamsStatistic([1,2,3,4,5,6,7,8,9,10,11])), headers: headers)).thenAnswer((_) async => http.Response(teamStatisticBody, 200));
   when(client.get(Uri.parse(setUrlTeams(125)), headers: headers)).thenAnswer((_) async => http.Response(last10RoundsOfTeam, 200));
   when(repository.getRounds()).thenAnswer((_) async => List<Round>.from([Round(1, '2022-08-13T22:00:00+00:00', 'Sport', '', 'São Paulo', '', 131, 121, null)]));
   final statistic = Statistic(1,1,1,1,1,1,1,1,1,1,'',1,1,1,1,1,'');
   when(repository.getStatisticTeam(131, 121)).thenAnswer((_) async => List<TeamStatistic>.from([TeamStatistic(131, 121, 1, 1, statistic, statistic)]));
   HomeController homeController = HomeController(client: client, repository: repository);
   int home = await homeController.statisticsTeam();
   expect(home, isA<int>());
  });
    
  test('get Rounds', ()async{
   when(client.get(Uri.parse(roundsUrl), headers: headers)).thenAnswer((_) async => http.Response(nextRounds, 200));
   when(repository.getRounds()).thenAnswer((_) async => List<Round>.from([]));
   HomeController homeController = HomeController(client: client, repository: repository);
   List<Round> home = await homeController.getRound();
   expect(home, isA<List<Round>>());
  });
}