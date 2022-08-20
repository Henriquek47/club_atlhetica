import 'dart:convert';

import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/entities/team.dart';
import 'package:club_atlhetica/layers/infra/adapter/round_adapter.dart';
import 'package:club_atlhetica/layers/infra/datadource/team_datasource.dart';
import 'package:club_atlhetica/layers/infra/repository/repository.dart';
import 'package:club_atlhetica/layers/service/database/db.dart';
import 'package:club_atlhetica/layers/service/repository/round_api.dart';
import 'package:club_atlhetica/layers/service/repository/statistic_teams_api.dart';
import 'package:club_atlhetica/layers/service/repository/url.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../../utils/utils.dart';
import '../../../../utils/utils2.dart';
import 'repository_test.mocks.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([http.Client])
@GenerateMocks([IRepository])
@GenerateMocks([TeamDataSource])

void main()async{
  TestWidgetsFlutterBinding.ensureInitialized();

  final client = MockClient();
  final repositoryMock = MockIRepository();
  final teamDataSource = MockTeamDataSource();
  
   setUpAll(() {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;
  });
  
  test('Verificar se o retorno está acontecendo', () async {
    var db = await openDatabase(inMemoryDatabasePath, version: 3,
        onCreate: (db, version) async {
      await db
          .execute('CREATE TABLE round (id INTEGER PRIMARY KEY, response TEXT, day INTEGER, month INTEGER)');
    });
    await db.insert('round', {'response': nextRounds, 'day': dateTime.day, 'month': dateTime.month});
    when(client.get(Uri.parse(setUrlTeamsStatistic([838131, 838122, 838117, 838131, 838122, 838117])), headers: headers)).thenAnswer((_) async => http.Response(teamStatisticBody, 200));
    when(client.get(Uri.parse(setUrlTeams(131)), headers: headers)).thenAnswer((_) async => http.Response(last10RoundsOfTeam, 200));
    when(repositoryMock.getRounds()).thenAnswer((_) async => List<Round>.from([]));
    final repository = Repository(teamDataSource: GetStatisticTeamsApi(client: client), db: db);
    List<TeamStatistic> list = await repository.getStatisticTeam(131, 131, 0);//O for tem que ser mudado para menor que 3 para o teste funcionar
    expect(list.first.goalsHome, equals(1));                                  //corrigir esse erro
    await db.close();
  });
    
  test('Verificar se a resposta do banco de dados esta vindo correta', ()async{
    var db = await openDatabase(inMemoryDatabasePath, version: 2,
        onCreate: (db, version) async {
      await db
          .execute('CREATE TABLE round (id INTEGER PRIMARY KEY, response TEXT, day INTEGER, month INTEGER)');
    });
    await db.insert('round', {'response': nextRounds, 'day': dateTime.day, 'month': dateTime.month});
    // Insert some data
    
    when(client.get(Uri.parse(roundsUrl), headers: headers)).thenAnswer((_) async => http.Response(nextRounds, 200));
    final repository = Repository(db: db, roundDataSource: GetRoundApi(client: client));
    List<Round> list = await repository.getRounds();
    List dbList = await db.query('round');
    expect(dbList.first['response'], nextRounds);
    expect(list.first.id, 837991);
    await db.close();
  });

  test('Atualizar banco de dados', ()async{
    var db = await openDatabase(inMemoryDatabasePath, version: 2,
        onCreate: (db, version) async {
      await db
          .execute('CREATE TABLE round (id INTEGER PRIMARY KEY, response TEXT, day INTEGER, month INTEGER)');
    });
    await db.insert('round', {'response': nextRounds, 'day': dateTime.day, 'month': dateTime.month});
    // Insert some data
    when(client.get(Uri.parse(roundsUrl), headers: headers)).thenAnswer((_) async => http.Response(nextRounds, 200));
    when(repositoryMock.getRounds()).thenAnswer((_) async => List<Round>.from([]));
    final repository = Repository(db: db, roundDataSource: GetRoundApi(client: client));
    List<Round> list = await repository.updateData(0, 'Corinthians');// o random tem que ser mudado para o num 1 para o teste funcionar
    List dbList = await db.query('round');                           // corrigir esse erro
    await db.close();
  });
    
}