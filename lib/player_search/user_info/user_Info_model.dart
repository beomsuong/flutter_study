class UserInfoModel {
  late int id;
  late DateTime time;
  late List<UserStats> userStats;

  UserInfoModel(
      {required this.id, required this.time, required this.userStats});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    time = DateTime.parse(json['time']);
    userStats =
        (json['userStats'] as List).map((v) => UserStats.fromJson(v)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['time'] = time.toIso8601String();
    data['userStats'] = userStats.map((v) => v.toJson()).toList();
    return data;
  }
}

class UserStats {
  late int mmr;
  late String nickname;
  late int rank;
  late int rankSize;
  late int totalGames;
  late int totalWins;
  late int totalTeamKills;
  late int totalDeaths;
  late int escapeCount;
  late double rankPercent;
  late double averageRank;
  late double averageKills;
  late double averageAssistants;
  late double averageHunts;
  late double top1;
  late double top2;
  late double top3;
  late double top5;
  late double top7;
  late List<CharacterStats> characterStats;

  UserStats({
    required this.mmr,
    required this.nickname,
    required this.rank,
    required this.rankSize,
    required this.totalGames,
    required this.totalWins,
    required this.totalTeamKills,
    required this.totalDeaths,
    required this.escapeCount,
    required this.rankPercent,
    required this.averageRank,
    required this.averageKills,
    required this.averageAssistants,
    required this.averageHunts,
    required this.top1,
    required this.top2,
    required this.top3,
    required this.top5,
    required this.top7,
    required this.characterStats,
  });

  UserStats.fromJson(Map<String, dynamic> json) {
    mmr = json['mmr'];
    nickname = json['nickname'];
    rank = json['rank'];
    rankSize = json['rankSize'];
    totalGames = json['totalGames'];
    totalWins = json['totalWins'];
    totalTeamKills = json['totalTeamKills'];
    totalDeaths = json['totalDeaths'];
    escapeCount = json['escapeCount'];
    rankPercent = json['rankPercent'].toDouble();
    averageRank = json['averageRank'].toDouble();
    averageKills = json['averageKills'].toDouble();
    averageAssistants = json['averageAssistants'].toDouble();
    averageHunts = json['averageHunts'].toDouble();
    top1 = json['top1'].toDouble();
    top2 = json['top2'].toDouble();
    top3 = json['top3'].toDouble();
    top5 = json['top5'].toDouble();
    top7 = json['top7'].toDouble();
    characterStats = (json['characterStats'] as List)
        .map((v) => CharacterStats.fromJson(v))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mmr'] = mmr;
    data['nickname'] = nickname;
    data['rank'] = rank;
    data['rankSize'] = rankSize;
    data['totalGames'] = totalGames;
    data['totalWins'] = totalWins;
    data['totalTeamKills'] = totalTeamKills;
    data['totalDeaths'] = totalDeaths;
    data['escapeCount'] = escapeCount;
    data['rankPercent'] = rankPercent;
    data['averageRank'] = averageRank;
    data['averageKills'] = averageKills;
    data['averageAssistants'] = averageAssistants;
    data['averageHunts'] = averageHunts;
    data['top1'] = top1;
    data['top2'] = top2;
    data['top3'] = top3;
    data['top5'] = top5;
    data['top7'] = top7;
    data['characterStats'] = characterStats.map((v) => v.toJson()).toList();
    return data;
  }
}

class CharacterStats {
  late int characterCode;
  late int totalGames;
  late int usages;
  late int maxKillings;
  late int top3;
  late int wins;
  late double top3Rate;
  late double averageRank;

  CharacterStats({
    required this.characterCode,
    required this.totalGames,
    required this.usages,
    required this.maxKillings,
    required this.top3,
    required this.wins,
    required this.top3Rate,
    required this.averageRank,
  });

  CharacterStats.fromJson(Map<String, dynamic> json) {
    characterCode = json['characterCode'];
    totalGames = json['totalGames'];
    usages = json['usages'];
    maxKillings = json['maxKillings'];
    top3 = json['top3'];
    wins = json['wins'];
    top3Rate = json['top3Rate'].toDouble();
    averageRank = json['averageRank'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['characterCode'] = characterCode;
    data['totalGames'] = totalGames;
    data['usages'] = usages;
    data['maxKillings'] = maxKillings;
    data['top3'] = top3;
    data['wins'] = wins;
    data['top3Rate'] = top3Rate;
    data['averageRank'] = averageRank;
    return data;
  }
}
