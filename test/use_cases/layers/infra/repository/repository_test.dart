import 'package:clock/clock.dart';
import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/entities/team.dart';
import 'package:club_atlhetica/layers/infra/datadource/team_datasource.dart';
import 'package:club_atlhetica/layers/infra/repository/repository.dart';
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
  
   setUpAll(()async{
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;
  });
  when(client.get(Uri.parse(setUrlLeagues(71)), headers: headers)).thenAnswer((_) async => http.Response(nextRounds, 200));
  when(client.get(Uri.parse(setUrlLeagues(2)), headers: headers)).thenAnswer((_) async => http.Response(nextRounds2, 200));
  when(client.get(Uri.parse(setUrlLeagues(73)), headers: headers)).thenAnswer((_) async => http.Response(nextRounds3, 200));
  
  test('init banco de daods', () async {
    var db = await openDatabase(inMemoryDatabasePath, version: 3,
        onCreate: (db, version) async {
      await db
          .execute('CREATE TABLE round (id INTEGER PRIMARY KEY AUTOINCREMENT, response TEXT, day INTEGER, month INTEGER)');
    });
    final repository = Repository(db: db, roundDataSource: GetRoundApi(client: client));
    await repository.initRepository();
    await db.close();
  });

  test('Verificar se o retorno está acontecendo', () async {
    await withClock(Clock.fixed(DateTime(2022, 5, 2)), ()async{
    var db = await openDatabase(inMemoryDatabasePath, version: 3,
        onCreate: (db, version) async {
      await db
          .execute('CREATE TABLE round (id INTEGER PRIMARY KEY, response TEXT, day INTEGER, month INTEGER)');
    });
    when(client.get(Uri.parse(setUrlTeamsStatistic([838131,838122,838131,838122])), headers: headers)).thenAnswer((_) async => http.Response(teamStatisticBody, 200));
    when(client.get(Uri.parse(setUrlTeams(131)), headers: headers)).thenAnswer((_) async => http.Response(last10RoundsOfTeam, 200));
    when(repositoryMock.getRounds()).thenAnswer((_) async => List<Round>.from([]));
    final repository = Repository(teamDataSource: GetStatisticTeamsApi(client: client), db: db);
    List<TeamStatistic> list = await repository.getStatisticTeam(131, 131);//O for tem que ser mudado para menor que 3 para o teste funcionar
    expect(list.first.goalsHome, equals(1));                                  //corrigir esse erro
    await db.close();
    });
  });
  
    
  test('Verificar se a resposta do banco de dados esta vindo correta', ()async{
    var db = await openDatabase(inMemoryDatabasePath, version: 2,
        onCreate: (db, version) async {
      await db
          .execute('CREATE TABLE round (id INTEGER PRIMARY KEY, response TEXT, day INTEGER, month INTEGER)');
    });
    // Insert some data
    
    final repository = Repository(db: db, roundDataSource: GetRoundApi(client: client));
    List<Round> list = await repository.getRounds();
    expect(list.first.id, 837991);
    await db.close();
  });

  test('Atualizar banco de dados', ()async{
    var db = await openDatabase(inMemoryDatabasePath, version: 5,
        onCreate: (db, version) async {
      await db
          .execute('CREATE TABLE round (id INTEGER PRIMARY KEY, response TEXT, day INTEGER, month INTEGER)');
    });
    // Insert some data
    
    for (var i = 0; i < 2; i++) {
    when(repositoryMock.getRounds()).thenAnswer((_) async => List<Round>.generate(10, (index) => Round(1, '2022-09-03T21:00:00+00:00','','', '', '',1,1,null, false, 'Analisando',1,1),));
    final repository = Repository(db: db, roundDataSource: GetRoundApi(client: client));
    List<Round> list = await repository.updateData(0, 'Corinthians', 0, 1);
    expect(list[0].notification, true);
    }                      
    await db.close();
  });
    
}