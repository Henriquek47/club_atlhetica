// ignore_for_file: unnecessary_string_escapes

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
  when(getRound.execute()).thenAnswer((_) async => List<Round>.from([]));
  final result = await getRound.execute();
  test('Get id team', ()async{
    expect(result, isA<List<Round>>());
  });
}