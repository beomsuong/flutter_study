import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmdakgg/player_search/match_result/game_Info_model.dart';

class MatchResultsViewModel
    extends StateNotifier<AsyncValue<List<GameInfoModel>>> {
  final Dio dio = Dio();
  final String nickname;
  MatchResultsViewModel(this.nickname) : super(const AsyncValue.loading()) {
    fetchGameData();
  }

  Future<void> fetchGameData() async {
    state = const AsyncValue.loading();
    print('게임 데이터');
    try {
      final response = await dio.get('http://10.0.2.2:3000/player/$nickname');

      if (response.statusCode == 200) {
        print('게임 데이터 성공');

        final gameInfoList = List<GameInfoModel>.from(
            (response.data['gameData'] as List).map((item) =>
                GameInfoModel.fromJson(item,
                    userNum: response.data['userNum'])));
        state = AsyncValue.data(gameInfoList);
      } else {
        state = AsyncValue.error(
            Exception(
                "Failed to load game data with status code: ${response.statusCode}"),
            StackTrace.current);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
