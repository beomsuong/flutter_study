import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fmdakgg/player_search/match_result/game_Info_model.dart';
import 'package:fmdakgg/player_search/match_result/match_results_view_model.dart';
import 'package:fmdakgg/player_search/match_result/match_results_widget.dart';
import 'package:fmdakgg/player_search/user_info/user_Info_view.dart';
import 'package:fmdakgg/player_search/user_info/user_Info_view_model.dart';
import 'package:fmdakgg/player_search/user_info/user_Info_model.dart';

final matchResultsViewModelProvider = StateNotifierProvider.family<
    MatchResultsViewModel, AsyncValue<List<GameInfoModel>>, String>(
  (ref, nickname) {
    return MatchResultsViewModel(nickname);
  },
);

final userInfoModelProvider = StateNotifierProvider.family<UserInfoViewModel,
    AsyncValue<UserInfoModel>, String>(
  (ref, nickname) => UserInfoViewModel(nickname),
);

class PlayerSearch extends ConsumerStatefulWidget {
  final String nickname;
  const PlayerSearch({required this.nickname, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlayerSearchState();
}

class _PlayerSearchState extends ConsumerState<PlayerSearch> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("전적화면 다시그림");
    final gameInfoAsyncValue =
        ref.watch(matchResultsViewModelProvider(widget.nickname));
    final userInfoAsyncValue =
        ref.watch(userInfoModelProvider(widget.nickname));
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  ref
                      .read(userInfoModelProvider(widget.nickname).notifier)
                      .fetchUserData();
                  ref
                      .read(matchResultsViewModelProvider(widget.nickname)
                          .notifier)
                      .fetchGameData();
                },
              ),
              userInfoAsyncValue.when(
                data: (userInfo) {
                  return UserInfoView(userInfo: userInfo);
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(), // 로딩 중 표시할 위젯
                ),
                error: (error, stack) => Center(
                  child: Text('유저 데이터 오류: $error'), // 오류 발생 시 표시할 위젯
                ),
              ),
              gameInfoAsyncValue.when(
                data: (gameInfoList) {
                  final widgets = gameInfoList
                      .where((gameInfo) =>
                          (gameInfo).userGames!.length > 8) // 8보다 크면 루미아섬
                      .map((gameInfo) {
                    return MatchResultsWidget(gameInfo: gameInfo);
                  }).toList();

                  final displayedWidgets =
                      widgets.length > 10 ? widgets.sublist(0, 10) : widgets;
                  return Column(
                    children: displayedWidgets,
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stack) => Text('Error: $error'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
