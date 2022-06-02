import 'package:club_atlhetica/layers/service/repository/repository.dart';
import 'package:club_atlhetica/layers/service/repository/round/get_round_api.dart';
import 'package:club_atlhetica/layers/use_cases/get_round.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Get round id', () async {
    Repository repository = GetRoundApi();
    var getRound = GetRound(repository);
    expect(getRound.execute(1), 1);
  });
}