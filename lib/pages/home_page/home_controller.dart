import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/infra/repository/repository.dart';
import 'package:club_atlhetica/layers/use_cases/get_round.dart';
import 'package:club_atlhetica/layers/use_cases/team_winner.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final http.Client client;
  final IRepository repository;

  HomeController({required this.client, required this.repository});

  Future<List> statisticsTeam()async{
    TeamWinner winner = TeamWinner(repository);
    return await winner.execute();
  }

  Future<List<Round>> getRound() async {
    GetRound getRoundVar = GetRound(repository: repository);
    List<Round> round = await getRoundVar.nextRounds();
    return round;
  }
}