// ignore_for_file: unnecessary_string_escapes

import 'package:club_atlhetica/layers/entities/team.dart';
import 'package:club_atlhetica/layers/infra/repository/repository.dart';
import 'package:club_atlhetica/layers/use_cases/get_statistic_teams.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_statistic_teams_test.mocks.dart';
@GenerateMocks([IRepository])


  final client = MockIRepository();
  final getTeams = GetStatisticTeams(client);

void main() async {
  final statistic = Statistic(1,1,1,1,1,1,1,1,1,1,'',1,1,1,1,1,'');
  when(getTeams.execute(125, 125)).thenAnswer((_) async => List<TeamStatistic>.from([TeamStatistic(1, 1, 1, 1, statistic, statistic)]));
  final result = await getTeams.execute(125, 125);
  test('Verificar o tipo do retorno', ()async{
    expect(result, isA<List<TeamStatistic>>());
  });
}