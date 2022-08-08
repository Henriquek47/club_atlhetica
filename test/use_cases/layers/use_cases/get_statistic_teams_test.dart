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
  final getTeams = TeamWinner(client);

void main() async {
  when(getTeams.execute()).thenAnswer((_) async => 0);
  when(client.getRounds()).thenAnswer((_) async => List<Round>.from([]));
  final result = await getTeams.execute();
  test('Verificar o tipo do retorno', ()async{
    expect(result, isA<int>());
  });
}