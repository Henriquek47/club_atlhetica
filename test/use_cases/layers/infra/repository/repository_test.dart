import 'dart:convert';

import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/infra/adapter/round_adapter.dart';
import 'package:club_atlhetica/layers/infra/repository/repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../utils/utils.dart';
import 'repository_test.mocks.dart';

@GenerateMocks([IRepository])

void main()async{

  final repository = MockIRepository();
  var round = jsonDecode(nextRounds);
  List rounds = round['response'];
  List<Round> listRound = rounds.map((e) => RoundAdapter.fromJson(e)).toList();
  when(repository.getRounds()).thenAnswer((_) async => listRound);
  List<Round> result = await repository.getRounds();
  test('Get all status of Round', ()async{
    expect(result[0].id, 837991);
  });
}