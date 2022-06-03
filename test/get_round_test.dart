import 'package:club_atlhetica/layers/domain/round.dart';
import 'package:club_atlhetica/layers/service/repository/repository.dart';
import 'package:club_atlhetica/layers/service/repository/get_round_api.dart';
import 'package:club_atlhetica/layers/use_cases/get_round.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Get round id', () async {
    Repository repository = GetRoundApi();
    var getRound = GetRound(repository);
    Round result = await repository.getRoundApi(1);
    expect(result.id, 838071);
  });
}
