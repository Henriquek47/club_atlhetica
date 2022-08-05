// Mocks generated by Mockito 5.2.0 from annotations
// in club_atlhetica/test/use_cases/layers/infra/repository/repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;
import 'dart:convert' as _i6;
import 'dart:typed_data' as _i7;

import 'package:club_atlhetica/layers/entities/round.dart' as _i11;
import 'package:club_atlhetica/layers/entities/team.dart' as _i10;
import 'package:club_atlhetica/layers/infra/datadource/team_datasource.dart'
    as _i12;
import 'package:club_atlhetica/layers/infra/repository/repository.dart' as _i9;
import 'package:http/src/base_request.dart' as _i8;
import 'package:http/src/client.dart' as _i4;
import 'package:http/src/response.dart' as _i2;
import 'package:http/src/streamed_response.dart' as _i3;
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

class _FakeResponse_0 extends _i1.Fake implements _i2.Response {}

class _FakeStreamedResponse_1 extends _i1.Fake implements _i3.StreamedResponse {
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockClient extends _i1.Mock implements _i4.Client {
  MockClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i5.Future<_i2.Response>);
  @override
  _i5.Future<_i2.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i5.Future<_i2.Response>);
  @override
  _i5.Future<_i2.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i6.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i5.Future<_i2.Response>);
  @override
  _i5.Future<_i2.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i6.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i5.Future<_i2.Response>);
  @override
  _i5.Future<_i2.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i6.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i5.Future<_i2.Response>);
  @override
  _i5.Future<_i2.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i6.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i5.Future<_i2.Response>);
  @override
  _i5.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i5.Future<String>);
  @override
  _i5.Future<_i7.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i7.Uint8List>.value(_i7.Uint8List(0)))
          as _i5.Future<_i7.Uint8List>);
  @override
  _i5.Future<_i3.StreamedResponse> send(_i8.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue:
                  Future<_i3.StreamedResponse>.value(_FakeStreamedResponse_1()))
          as _i5.Future<_i3.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
}

/// A class which mocks [IRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockIRepository extends _i1.Mock implements _i9.IRepository {
  MockIRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<List<_i10.TeamStatistic>> getStatisticTeam(
          int? idTeamHome, int? idTeamAway) =>
      (super.noSuchMethod(
          Invocation.method(#getStatisticTeam, [idTeamHome, idTeamAway]),
          returnValue: Future<List<_i10.TeamStatistic>>.value(
              <_i10.TeamStatistic>[])) as _i5.Future<List<_i10.TeamStatistic>>);
  @override
  _i5.Future<List<_i11.Round>> getRounds() =>
      (super.noSuchMethod(Invocation.method(#getRounds, []),
              returnValue: Future<List<_i11.Round>>.value(<_i11.Round>[]))
          as _i5.Future<List<_i11.Round>>);
}

/// A class which mocks [TeamDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTeamDataSource extends _i1.Mock implements _i12.TeamDataSource {
  MockTeamDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<Map<dynamic, dynamic>> last10RoundsTeam(int? idTeam) =>
      (super.noSuchMethod(Invocation.method(#last10RoundsTeam, [idTeam]),
              returnValue:
                  Future<Map<dynamic, dynamic>>.value(<dynamic, dynamic>{}))
          as _i5.Future<Map<dynamic, dynamic>>);
  @override
  _i5.Future<Map<dynamic, dynamic>> statisticRound(List<int>? ids) =>
      (super.noSuchMethod(Invocation.method(#statisticRound, [ids]),
              returnValue:
                  Future<Map<dynamic, dynamic>>.value(<dynamic, dynamic>{}))
          as _i5.Future<Map<dynamic, dynamic>>);
}
