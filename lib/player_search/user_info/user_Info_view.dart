import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fmdakgg/player_search/user_info/user_Info_model.dart';
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
                width: 70.w,
                height: 70.h,
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
          padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                Text('${widget.userInfo.userStats[0].mmr} RP'),
                const Text('데미갓 - 256RP'),
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
              )
            ],
          ),
        ),
      ],
    );
  }
}
