import 'package:clock/clock.dart';
import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/entities/team.dart';
import 'package:club_atlhetica/layers/infra/repository/repository.dart';
import 'package:club_atlhetica/layers/use_cases/team_winner.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'team_winner_test.mocks.dart';

@GenerateMocks([IRepository])


  final client = MockIRepository();
  final teamWinner = TeamWinner(client);

void main() async {
  await withClock(Clock.fixed(DateTime(2022, 9, 3, 15)), ()async{
    when(client.getRounds()).thenAnswer((_) async => List<Round>.from([Round(1, '2022-09-03T19:00:00+00:00','','', '', '',1,2,null, false, '',1,1),Round(1, '2022-09-03T21:00:00+00:00','','', '', '',1,2,1, false,'',1,1)]));
    Statistic statistic = Statistic(1,10,1,1,1,1,1,1,1,'30',1,1,1,1,1,'');
    Statistic statistic2 = Statistic(2,30,1,1,1,1,1,1,1,'30',1,1,1,1,1,'');
    TeamStatistic teamStatistic = TeamStatistic(1, 2, 1, 2, statistic, statistic2);
    when(client.updateData(any, '', any, any)).thenAnswer((_) async => List<Round>.from([Round(1, '2022-09-03T21:00:00+00:00','','', '', '',1,2,null, false, '',1,1),Round(1, '2022-09-03T21:00:00+00:00','','', '', '',1,2,null, false,'',1,1)]));
    //when(client.getStatisticTeam(1, 2)).thenAnswer((_) async => List<TeamStatistic>.generate(20, (index) => teamStatistic ));
    final result = await teamWinner.execute();
    Map getStatistic= await teamWinner.getStatisticTeam(1,2);
    test('Verificar o tipo do retorno', ()async{
      expect(result, [1, '']);
      expect(result, isA<List>());
      expect(getStatistic['home']['goals'], 10);
      expect(getStatistic['away']['goals'], 20);
      expect(getStatistic['away']['redCards'], 10);
    });
  });
}