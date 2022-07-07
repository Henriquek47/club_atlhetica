
import 'dart:convert';

import 'package:club_atlhetica/layers/entities/team.dart';
import 'package:club_atlhetica/layers/infra/adapter/team_adapter.dart';
import 'package:club_atlhetica/layers/infra/datadource/team_datasource.dart';
import 'package:club_atlhetica/layers/infra/repository/team_statistic_repository.dart';

class GetStatisticTeams{
  ITeamStatisticRpository repository;

  GetStatisticTeams(this.repository);

  execute(int? idTeam, int? idFixtures)async{
  return await repository.getStatisticTeam(idTeam, idFixtures);
  }
}