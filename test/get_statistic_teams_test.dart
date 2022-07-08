// ignore_for_file: unnecessary_string_escapes

import 'package:club_atlhetica/layers/entities/round.dart';
import 'package:club_atlhetica/layers/entities/team.dart';
import 'package:club_atlhetica/layers/infra/repository/team_statistic_repository.dart';
import 'package:club_atlhetica/layers/service/repository/get_round_api.dart';
import 'package:club_atlhetica/layers/service/repository/get_statistic_teams_api.dart';
import 'package:club_atlhetica/layers/service/repository/url.dart';
import 'package:club_atlhetica/layers/use_cases/get_round.dart';
import 'package:club_atlhetica/layers/use_cases/get_statistic_teams.dart';
import 'package:club_atlhetica/pages/home_page/home_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'get_statistic_teams_test.mocks.dart' as team;
import 'get_round_test.mocks.dart';


@GenerateMocks([http.Client])

  final clientTeam = team.MockClient();
  final clientRound = MockClient();
  GetStatisticTeamsApi repositoryTeam = GetStatisticTeamsApi(client: clientTeam);
  GetRoundApi repositoryRound = GetRoundApi(client: clientRound);
  const teamGoals = '{"get":"fixtures","parameters":{"team":"125","season":"2022","league":"71","last":"10"},"errors":[],"results":10,"paging":{"current":1,"total":1},"response":[{"fixture":{"id":838131,"referee":"Caio Max Augusto Vieira, Brazil","timezone":"UTC","date":"2022-07-03T21:00:00+00:00","timestamp":1656882000,"periods":{"first":1656882000,"second":1656885600},"venue":{"id":206,"name":"Est\u00e1dio Raimundo Sampaio","city":"Belo Horizonte, Minas Gerais"},"status":{"long":"Match Finished","short":"FT","elapsed":90}},"league":{"id":71,"name":"Serie A","country":"Brazil","logo":"https:\/\/media.api-sports.io\/football\/leagues\/71.png","flag":"https:\/\/media.api-sports.io\/flags\/br.svg","season":2022,"round":"Regular Season - 15"},"teams":{"home":{"id":125,"name":"America Mineiro","logo":"https:\/\/media.api-sports.io\/football\/teams\/125.png","winner":true},"away":{"id":151,"name":"Goias","logo":"https:\/\/media.api-sports.io\/football\/teams\/151.png","winner":false}},"goals":{"home":1,"away":0},"score":{"halftime":{"home":0,"away":0},"fulltime":{"home":1,"away":0},"extratime":{"home":null,"away":null},"penalty":{"home":null,"away":null}}},{"fixture":{"id":838122,"referee":"Ramon Abatti Abel, Brazil","timezone":"UTC","date":"2022-06-25T22:00:00+00:00","timestamp":1656194400,"periods":{"first":1656194400,"second":1656198000},"venue":{"id":null,"name":"Est\u00e1dio do Maracan\u00e3","city":"Rio de Janeiro"},"status":{"long":"Match Finished","short":"FT","elapsed":90}},"league":{"id":71,"name":"Serie A","country":"Brazil","logo":"https:\/\/media.api-sports.io\/football\/leagues\/71.png","flag":"https:\/\/media.api-sports.io\/flags\/br.svg","season":2022,"round":"Regular Season - 14"},"teams":{"home":{"id":127,"name":"Flamengo","logo":"https:\/\/media.api-sports.io\/football\/teams\/127.png","winner":true},"away":{"id":125,"name":"America Mineiro","logo":"https:\/\/media.api-sports.io\/football\/teams\/125.png","winner":false}},"goals":{"home":3,"away":0},"score":{"halftime":{"home":1,"away":0},"fulltime":{"home":3,"away":0},"extratime":{"home":null,"away":null},"penalty":{"home":null,"away":null}}},{"fixture":{"id":838117,"referee":"Leandro Pedro Vuaden, Brazil","timezone":"UTC","date":"2022-06-19T21:00:00+00:00","timestamp":1655672400,"periods":{"first":1655672400,"second":1655676000},"venue":{"id":225,"name":"Est\u00e1dio Governador Pl\u00e1cido Aderaldo Castelo","city":"Fortaleza, Cear\u00e1"},"status":{"long":"Match Finished","short":"FT","elapsed":90}},"league":{"id":71,"name":"Serie A","country":"Brazil","logo":"https:\/\/media.api-sports.io\/football\/leagues\/71.png","flag":"https:\/\/media.api-sports.io\/flags\/br.svg","season":2022,"round":"Regular Season - 13"},"teams":{"home":{"id":154,"name":"Fortaleza EC","logo":"https:\/\/media.api-sports.io\/football\/teams\/154.png","winner":true},"away":{"id":125,"name":"America Mineiro","logo":"https:\/\/media.api-sports.io\/football\/teams\/125.png","winner":false}},"goals":{"home":1,"away":0},"score":{"halftime":{"home":1,"away":0},"fulltime":{"home":1,"away":0},"extratime":{"home":null,"away":null},"penalty":{"home":null,"away":null}}},{"fixture":{"id":838101,"referee":"Anderson Daronco","timezone":"UTC","date":"2022-06-16T00:30:00+00:00","timestamp":1655339400,"periods":{"first":1655339400,"second":1655343000},"venue":{"id":206,"name":"Est\u00e1dio Raimundo Sampaio","city":"Belo Horizonte, Minas Gerais"},"status":{"long":"Match Finished","short":"FT","elapsed":90}},"league":{"id":71,"name":"Serie A","country":"Brazil","logo":"https:\/\/media.api-sports.io\/football\/leagues\/71.png","flag":"https:\/\/media.api-sports.io\/flags\/br.svg","season":2022,"round":"Regular Season - 12"},"teams":{"home":{"id":125,"name":"America Mineiro","logo":"https:\/\/media.api-sports.io\/football\/teams\/125.png","winner":null},"away":{"id":124,"name":"Fluminense","logo":"https:\/\/media.api-sports.io\/football\/teams\/124.png","winner":null}},"goals":{"home":0,"away":0},"score":{"halftime":{"home":0,"away":0},"fulltime":{"home":0,"away":0},"extratime":{"home":null,"away":null},"penalty":{"home":null,"away":null}}}]}';
  const roundBody = '{"get":"fixtures","parameters":{"season":"2022","from":"2022-06-02","to":"2022-06-08","league":"71"},"errors":[],"results":15,"paging":{"current":1,"total":1},"response":[{"fixture":{"id":838071,"referee":"Raphael Claus","timezone":"UTC","date":"2022-06-04T10:40:00+00:00","timestamp":1654371000,"periods":{"first":null,"second":null},"venue":{"id":206,"name":"Est\u00e1dio Raimundo Sampaio","city":"Belo Horizonte, Minas Gerais"},"status":{"long":"Not Started","short":"NS","elapsed":null}},"league":{"id":71,"name":"Serie A","country":"Brazil","logo":"https:\/\/media.api-sports.io\/football\/leagues\/71.png","flag":"https:\/\/media.api-sports.io\/flags\/br.svg","season":2022,"round":"Regular Season - 9"},"teams":{"home":{"id":125,"name":"America Mineiro","logo":"https:\/\/media.api-sports.io\/football\/teams\/125.png","winner":null},"away":{"id":1193,"name":"Cuiaba","logo":"https:\/\/media.api-sports.io\/football\/teams\/1193.png","winner":null}},"goals":{"home":null,"away":null},"score":{"halftime":{"home":null,"away":null},"fulltime":{"home":null,"away":null},"extratime":{"home":null,"away":null},"penalty":{"home":null,"away":null}}}]}';
  const teamStatisticBody = '{"get":"fixtures\/statistics","parameters":{"fixture":"838131","team":"125"},"errors":[],"results":1,"paging":{"current":1,"total":1},"response":[{"team":{"id":125,"name":"America Mineiro","logo":"https:\/\/media.api-sports.io\/football\/teams\/125.png"},"statistics":[{"type":"Shots on Goal","value":5},{"type":"Shots off Goal","value":7},{"type":"Total Shots","value":21},{"type":"Blocked Shots","value":9},{"type":"Shots insidebox","value":12},{"type":"Shots outsidebox","value":9},{"type":"Fouls","value":14},{"type":"Corner Kicks","value":11},{"type":"Offsides","value":2},{"type":"Ball Possession","value":"52%"},{"type":"Yellow Cards","value":2},{"type":"Red Cards","value":null},{"type":"Goalkeeper Saves","value":3},{"type":"Total passes","value":413},{"type":"Passes accurate","value":321},{"type":"Passes %","value":"78%"}]}]}';


void main() async {
  when(clientRound.get(Uri.parse(urlAllNextRound), headers: headers)).thenAnswer((_) async => http.Response(roundBody, 200));
   GetRound getRound = GetRound(repository: repositoryRound);
   List<Round> round = await getRound.execute(0);
   when(clientTeam.get(Uri.parse(setUrlTeams(round[0].idHome)), headers: headers)).thenAnswer((_) async => http.Response(teamGoals, 200));
   when(clientTeam.get(Uri.parse(setUrlTeamsStatistic(round[0].idHome, round[0].id)), headers: headers)).thenAnswer((_) async => http.Response(teamStatisticBody, 200));
   ITeamStatisticRepository teamStatisticRepository = TeamStatisticRepository(repositoryTeam);
   GetStatisticTeams getStatisticTeams = GetStatisticTeams(teamStatisticRepository);
   List<Team> teamStatistic = await getStatisticTeams.execute(round[0].idHome, round[0].id);

  test('Get id team', ()async{
   expect(teamStatistic[0].id, 125);
   expect(teamStatistic[0].id, 125);
   expect(teamStatistic[0].statistics![1]['value'], 7);
  });

  test('test homController', ()async{
    HomeController homeController = HomeController();
   List<Team> home = await homeController.statisticsTeam(151, 838128);
   expect(home[3].id, 151);
  });
}