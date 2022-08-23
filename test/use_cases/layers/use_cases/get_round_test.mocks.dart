// Mocks generated by Mockito 5.2.0 from annotations
// in club_atlhetica/test/use_cases/layers/use_cases/get_round_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:club_atlhetica/layers/entities/round.dart' as _i5;
import 'package:club_atlhetica/layers/entities/team.dart' as _i4;
import 'package:club_atlhetica/layers/infra/repository/repository.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [IRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockIRepository extends _i1.Mock implements _i2.IRepository {
  MockIRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.TeamStatistic>> getStatisticTeam(
          int? idTeamHome, int? idTeamAway, int? index) =>
      (super.noSuchMethod(
          Invocation.method(#getStatisticTeam, [idTeamHome, idTeamAway, index]),
          returnValue: Future<List<_i4.TeamStatistic>>.value(
              <_i4.TeamStatistic>[])) as _i3.Future<List<_i4.TeamStatistic>>);
  @override
  _i3.Future<List<_i5.Round>> getRounds() =>
      (super.noSuchMethod(Invocation.method(#getRounds, []),
              returnValue: Future<List<_i5.Round>>.value(<_i5.Round>[]))
          as _i3.Future<List<_i5.Round>>);
  @override
  _i3.Future<List<_i5.Round>> updateData(int? index, String? winner) =>
      (super.noSuchMethod(Invocation.method(#updateData, [index, winner]),
              returnValue: Future<List<_i5.Round>>.value(<_i5.Round>[]))
          as _i3.Future<List<_i5.Round>>);
}
