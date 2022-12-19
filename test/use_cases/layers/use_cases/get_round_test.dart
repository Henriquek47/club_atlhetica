import 'package:clock/clock.dart';
import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/infra/repository/repository.dart';
import 'package:club_atlhetica/layers/use_cases/get_round.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_round_test.mocks.dart';

@GenerateMocks([IRepository])


  final client = MockIRepository();
  final getRound = GetRound(repository: client);

void main() async {
 await withClock(Clock.fixed(DateTime(2022, 9, 2)), ()async{
  
  when(client.getRounds(1)).thenAnswer((_) async => List<Round>.from([Round(1, '2022-09-03T21:00:00+00:00','','', '', '',1,1,null, false, 'Analisando',1,1), Round(1, '2022-09-03T21:00:00+00:00','','', '', '',1,1,1, false, '',1,1)]));
  List<Round> allRounds = await getRound.beforeRounds(71);
  List<Round> nextRounds = await getRound.nextRounds(71);
  test('Retornar round que nao aconteceram na lista', ()async{
    expect(nextRounds.length, equals(1));
    expect(nextRounds, isA<List<Round>>());
  });

  test('retornar todos os rounds', ()async{
    expect(allRounds, isA<List<Round>>());
    expect(allRounds.length, equals(0));
    });
  });
}