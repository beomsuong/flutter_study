import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fmdakgg/define.dart';
import 'package:fmdakgg/player_search/match_result/game_Info_model.dart';
import 'package:fmdakgg/player_search/match_result/match_results_view_model.dart';
import 'package:fmdakgg/player_search/player_search.dart';
import 'package:fmdakgg/player_search/user_info/user_Info_model.dart';
import 'package:fmdakgg/player_search/user_info/user_Info_view_model.dart';

import 'package:timeago/timeago.dart' as timeago;

class UserInfoView extends ConsumerStatefulWidget {
  final UserInfoModel userInfo;

  const UserInfoView({super.key, required this.userInfo});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserInfoViewState();
}

class _UserInfoViewState extends ConsumerState<UserInfoView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.grey[800],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100.w,
                height: 100.h,
                child: Image.network(
                    fit: BoxFit.fill,
                    'http://10.0.2.2:3000/charactersImage/${widget.userInfo.userStats[0].characterStats[0].characterCode}'),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userInfo.userStats[0].nickname,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: GestureDetector(
                      onTap: () {
                        ref
                            .read(userInfoModelProvider(widget
                                    .userInfo.userStats[0].nickname
                                    .toLowerCase())
                                .notifier)
                            .fetchUserData();
                        ref
                            .watch(matchResultsViewModelProvider(widget
                                    .userInfo.userStats[0].nickname
                                    .toLowerCase())
                                .notifier)
                            .fetchGameData();
                      },
                      child: Container(
                        width: 80.w,
                        height: 35.h,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Color(0xFF11B288),
                        ),
                        child: const Center(
                          child: Text(
                            '전적 갱신',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                      '최근 업데이트: ${timeago.format(
                        DateTime.now().subtract(
                          DateTime.now().difference(widget.userInfo.time),
                        ),
                        locale: 'ko',
                      )}',
                      style: const TextStyle(
                        color: Colors.white,
                      )),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0, top: 3),
          child: Container(
            height: 0.8.h,
            width: 500.0,
            color: Colors.grey,
          ),
        ),
        const Text('랭크'),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Container(
            height: 0.8.h,
            width: 500.0,
            color: Colors.grey,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Container(
                color: Colors.grey,
                width: 70.w,
                height: 70.h,
                child: Image.network(
                    fit: BoxFit.fill, 'http://10.0.2.2:3000/rankTierIMGImage/'),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.userInfo.userStats[0].mmr} RP',
                  style: TextStyle(
                      color: const Color(0xFFCA9372),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700),
                ),
                const Text(
                  '데미갓 - 256RP',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                    '${widget.userInfo.userStats[0].rank}위 (상위 ${(widget.userInfo.userStats[0].rank / widget.userInfo.userStats[0].rankSize * 100).toStringAsFixed(2)})%')
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Container(
            height: 0.8.h,
            width: 500.0,
            color: Colors.grey,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('평균 TK'),
                      Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: const Color(0xFFE6E6E6),
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: Colors.black, width: 1)),
                            width: 110.0.w,
                            height: 10.0.h,
                          ),
                          Positioned(
                            top: 0.0,
                            bottom: 0.0,
                            left: 0.0,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFF666A7A),
                                  borderRadius: BorderRadius.circular(20), //
                                  border: Border.all(
                                      color: Colors.black, width: 1)),
                              width: 10.0.w,
                            ),
                          ),
                        ],
                      ),
                      Text((widget.userInfo.userStats[0].totalTeamKills /
                              widget.userInfo.userStats[0].totalGames)
                          .toStringAsFixed(2)),
                      const Text('평균 킬'),
                      Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: const Color(0xFFE6E6E6),
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: Colors.black, width: 1)),
                            width: 110.0.w,
                            height: 10.0.h,
                          ),
                          Positioned(
                            top: 0.0,
                            bottom: 0.0,
                            left: 0.0,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFF666A7A),
                                  borderRadius: BorderRadius.circular(20), //
                                  border: Border.all(
                                      color: Colors.black, width: 1)),
                              width: 10.0.w,
                            ),
                          ),
                        ],
                      ),
                      Text(
                          widget.userInfo.userStats[0].averageKills.toString()),
                      const Text('평균 어시'),
                      Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: const Color(0xFFE6E6E6),
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: Colors.black, width: 1)),
                            width: 110.0.w,
                            height: 10.0.h,
                          ),
                          Positioned(
                            top: 0.0,
                            bottom: 0.0,
                            left: 0.0,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFF666A7A),
                                  borderRadius: BorderRadius.circular(20), //
                                  border: Border.all(
                                      color: Colors.black, width: 1)),
                              width: 10.0.w,
                            ),
                          ),
                        ],
                      ),
                      Text(widget.userInfo.userStats[0].averageAssistants
                          .toString()),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('승률'),
                    Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFFE6E6E6),
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          width: 110.0.w,
                          height: 10.0.h,
                        ),
                        Positioned(
                          top: 0.0,
                          bottom: 0.0,
                          left: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF11B288),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: (110 *
                                    widget.userInfo.userStats[0].totalWins /
                                    widget.userInfo.userStats[0].totalGames)
                                .w,
                          ),
                        ),
                      ],
                    ),
                    Text(
                        '${(widget.userInfo.userStats[0].totalWins / widget.userInfo.userStats[0].totalGames * 100).toStringAsFixed(1)}%'),
                    const Text('TOP 2'),
                    Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFFE6E6E6),
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          width: 110.0.w,
                          height: 10.0.h,
                        ),
                        Positioned(
                          top: 0.0,
                          bottom: 0.0,
                          left: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF207AC7),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: (110 * widget.userInfo.userStats[0].top2).w,
                          ),
                        ),
                      ],
                    ),
                    Text('${widget.userInfo.userStats[0].top2 * 100}%'),
                    const Text('TOP 3'),
                    Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFFE6E6E6),
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          width: 110.0.w,
                          height: 10.0.h,
                        ),
                        Positioned(
                          top: 0.0,
                          bottom: 0.0,
                          left: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF207AC7),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: (110 * widget.userInfo.userStats[0].top3).w,
                          ),
                        ),
                      ],
                    ),
                    Text('${widget.userInfo.userStats[0].top3 * 100}%'),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('게임 수 '),
                    Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFFE6E6E6),
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          width: 110.0.w,
                          height: 10.0.h,
                        ),
                        Positioned(
                          top: 0.0,
                          bottom: 0.0,
                          left: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color(0xFF666A7A),
                                borderRadius: BorderRadius.circular(20), //
                                border:
                                    Border.all(color: Colors.black, width: 1)),
                            width: 10.0.w,
                          ),
                        ),
                      ],
                    ),
                    Text(widget.userInfo.userStats[0].totalGames.toString()),
                    const Text('평균딜량 '),
                    Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFFE6E6E6),
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          width: 110.0.w,
                          height: 10.0.h,
                        ),
                        Positioned(
                          top: 0.0,
                          bottom: 0.0,
                          left: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color(0xFF666A7A),
                                borderRadius: BorderRadius.circular(20), //
                                border:
                                    Border.all(color: Colors.black, width: 1)),
                            width: 10.0.w,
                          ),
                        ),
                      ],
                    ),
                    const Text('초비상'),
                    const Text('평균 순위'),
                    Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFFE6E6E6),
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          width: 110.0.w,
                          height: 10.0.h,
                        ),
                        Positioned(
                          top: 0.0,
                          bottom: 0.0,
                          left: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color(0xFF666A7A),
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: Colors.black, width: 1)),
                            width: 10.0.w,
                          ),
                        ),
                      ],
                    ),
                    Text(
                        '#${widget.userInfo.userStats[0].averageRank.toString()}')
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
            width: double.infinity,
            color: const Color(0xFF4C4F5D),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                '실험체 통계',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            )),
        Container(
          width: double.infinity,
          color: const Color(0xFF363944),
          child: Row(
            children: [
              SizedBox(
                width: 160.w,
                child: const Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Text(
                    '실험체',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(
                width: 50.w,
                child: const Text(
                  '승률',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                width: 60.w,
                child: const Center(
                  child: Text(
                    '최고킬',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(
                width: 60.w,
                child: const Center(
                  child: Text(
                    'top3',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(
                width: 60.w,
                child: const Center(
                  child: Text(
                    '평균순위',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
        for (var i in widget.userInfo.userStats[0].characterStats)
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey),
              ),
            ),
            width: double.infinity,
            child: Row(
              children: [
                SizedBox(
                  width: 160.w,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: Container(
                              color: Colors.grey,
                              width: 40.w,
                              height: 40.h,
                              child: Image.network(
                                  'http://10.0.2.2:3000/charactersImage/${i.characterCode}'),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(defineCharacterList[i.characterCode - 1]),
                              Text('${i.totalGames.toString()} 게임')
                            ],
                          )
                        ],
                      )),
                ),
                SizedBox(
                    width: 50.w,
                    child: Text(
                        '${(i.wins / i.totalGames * 100).toStringAsFixed(1)}%')),
                SizedBox(
                  width: 60.w,
                  child: Center(
                    child: Text(
                      i.maxKillings.toString(),
                    ),
                  ),
                ),
                SizedBox(
                    width: 60.w,
                    child: Center(
                      child: Text(
                          '${(i.top3 / i.totalGames * 100).toStringAsFixed(1)}%'),
                    )),
                SizedBox(
                  width: 60.w,
                  child: Center(
                    child: Text(
                      i.averageRank.toString(),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
