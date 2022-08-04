import 'dart:convert';

import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/infra/adapter/round_adapter.dart';
import 'package:club_atlhetica/layers/infra/repository/repository.dart';
import 'package:club_atlhetica/layers/service/database/db.dart';
import 'package:club_atlhetica/layers/service/repository/round_api.dart';
import 'package:club_atlhetica/layers/service/repository/url.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../../utils/utils.dart';
import 'repository_test.mocks.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([http.Client])

void main()async{
  TestWidgetsFlutterBinding.ensureInitialized();

  final client = MockClient();
  
   setUpAll(() {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;
  });
    
  test('Get all status of Round', ()async{
    var db = await openDatabase(inMemoryDatabasePath, version: 2,
        onCreate: (db, version) async {
      await db
          .execute('CREATE TABLE round (id INTEGER PRIMARY KEY, response TEXT)');
    });
    // Insert some data
    
    when(client.get(Uri.parse(roundsUrl), headers: headers)).thenAnswer((_) async => http.Response(nextRounds, 200));
    final repository = Repository(db: db, roundDataSource: GetRoundApi(client: client));
    List<Round> list = await repository.getRounds();
    expect(await db.query('round'), [
      {'id': 1, 'response': nextRounds}
    ]);
    expect(list.first.id, 837991);
    await db.close();
  });

}
