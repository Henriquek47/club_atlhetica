// ignore_for_file: unnecessary_string_escapes

import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/entities/team.dart';
import 'package:club_atlhetica/layers/infra/repository/repository.dart';
import 'package:club_atlhetica/layers/use_cases/team_winner.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_statistic_teams_test.mocks.dart';
@GenerateMocks([IRepository])


  final client = MockIRepository();
  final team_winner= TeamWinner(client);

void main() async {
  when(client.getRounds()).thenAnswer((_) async => List<Round>.from([Round(1, '2022-09-03T21:00:00+00:00','','', '', '',1,1,null, false, ''),Round(1, '2022-09-03T21:00:00+00:00','','', '', '',1,1,null, false,'')]));
  when(client.updateData(0, '')).thenAnswer((_) async => List<Round>.from([Round(1, '2022-09-03T21:00:00+00:00','','', '', '',1,1,null, false, ''),Round(1, '2022-09-03T21:00:00+00:00','','', '', '',1,1,null, false,'')]));
  Statistic statistic = Statistic(1,1,1,1,1,1,1,1,1,1,'',1,1,1,1,1,'');
  TeamStatistic teamStatistic = TeamStatistic(1, 1, 1, 0, statistic, statistic);
  for (var i = 0; i < 2; i++) {
    when(client.getStatisticTeam(1, 1, i)).thenAnswer((_) async => List<TeamStatistic>.from([teamStatistic, teamStatistic, teamStatistic, teamStatistic]));
  }
  final result = await team_winner.execute();
  test('Verificar o tipo do retorno', ()async{
    expect(result, isA<List>());
    expect(result, equals([0, '']));
  });
}