import 'dart:convert';

import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/infra/adapter/round_adapter.dart';
import 'package:club_atlhetica/layers/infra/repository/repository.dart';
import 'package:club_atlhetica/layers/service/database/db.dart';
import 'package:club_atlhetica/layers/service/repository/round_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../../utils/utils.dart';
import 'repository_test.mocks.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([http.Client])
@GenerateMocks([DB])

void main()async{
  TestWidgetsFlutterBinding.ensureInitialized();
  
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
    await db.insert('round', {'response': nextRounds});
    // Check content
    expect(await db.query('round'), [
      {'id': 1, 'response': nextRounds}
    ]);

    final repository = Repository(db: db, roundDataSource: GetRoundApi(client: MockClient()));
    List<Round> list = await repository.getRounds();
    expect(list.first.id, 837991);
    await db.close();
  });

}
