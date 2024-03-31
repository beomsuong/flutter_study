import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fmdakgg/player_search/match_result/game_Info_model.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class MatchResultsWidget extends ConsumerStatefulWidget {
  final GameInfoModel gameInfo;
  const MatchResultsWidget({super.key, required this.gameInfo});

  @override
  ConsumerState<MatchResultsWidget> createState() => _MatchResultsWidgetState();
}

class _MatchResultsWidgetState extends ConsumerState<MatchResultsWidget> {
  late UserGames userData;
  List<Color> gameRankColors = [
    const Color(0xFF11B288), //1등
    const Color(0xFF11B288), //1등
    const Color(0xFF207AC7), //2등
    const Color(0xFF207AC7), //3등
    const Color(0xFF999999), //광탈
    const Color(0xFF999999), //광탈
    const Color(0xFF999999), //광탈
    const Color(0xFF999999), //광탈
    const Color(0xFF999999), //광탈
    const Color(0xFF475482) //탈출
  ];
  bool detailed = false;
  int maxDamageToPlayer = 0; //딜량 막대기를 위한 게임 최고 딜량
  int userNumTeam = 0; //유저가 속한 팀 색깔 강조

  @override
  void initState() {
    widget.gameInfo.userGames!.sort((a, b) {
      int rankCompare = a.gameRank!.compareTo(b.gameRank!); //등수로 정렬
      if (rankCompare == 0) {
        //같은 팀은 딜량순으로 정렬
        return b.damageToPlayer!.compareTo(a.damageToPlayer!);
      }
      return rankCompare;
    });
    userData = widget.gameInfo.userGames![0];

    for (int i = 0; i < widget.gameInfo.userGames!.length; i++) {
      maxDamageToPlayer = (maxDamageToPlayer <
              (widget.gameInfo.userGames![i].damageToPlayer as int)
          ? widget.gameInfo.userGames![i].damageToPlayer
          : maxDamageToPlayer)!;
      if (widget.gameInfo.userGames![i].userNum == widget.gameInfo.userNum) {
        //검색한 유저 정보 특정
        userData = widget.gameInfo.userGames![i];
        userNumTeam = widget.gameInfo.userGames![i].gameRank as int;
      }
    }

    super.initState();
  }

  Widget detailUserWidget(UserGames detailUserData) {
    return Row(children: [
      SizedBox(
        width: 200.w,
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Container(
                    color: Colors.grey,
                    width: 40,
                    height: 40,
                    child: Image.network(
                        'http://10.0.2.2:3000/charactersImage/${detailUserData.characterNum}'),
                  ),
                ),
                Positioned(
                  top: 25,
                  left: 25,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Container(
                      color: Colors.white,
                      width: 15,
                      height: 15,
                      child: Center(
                        child: Text(
                          detailUserData.characterLevel.toString(),
                          style: TextStyle(
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      detailUserData.teamKill.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Text('/'),
                    Text(
                      detailUserData.playerKill.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Text('/'),
                    Text(
                      detailUserData.playerAssistant.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Text(
                      'TK',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      '/',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      'K',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      '/',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      'A',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
      SizedBox(
        width: 80.w,
        child: Column(
          children: [
            Stack(children: [
              Container(
                height: 10.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), // 둥근 모서리 반경 설정
                    border: Border.all(color: Colors.black, width: 1)),
              ),
              Container(
                width:
                    80 / (maxDamageToPlayer / detailUserData.damageToPlayer!).w,
                height: 10.h,
                decoration: BoxDecoration(
                    color: Colors.amber[800],
                    borderRadius: BorderRadius.circular(20), // 둥근 모서리 반경 설정
                    border: Border.all(color: Colors.black, width: 1)),
              )
            ]),
            Text(
              NumberFormat('###,###,###,###')
                  .format(detailUserData.damageToPlayer!)
                  .replaceAll(' ', ''),
            )
          ],
        ),
      ),
      SizedBox(
        width: 75.9.w,
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                height: 20.h,
                width: 25.w,
                color: Colors.grey,
                child: Image.network(
                    fit: BoxFit.fill,
                    'http://10.0.2.2:3000/weaponsImage/${detailUserData.equipment!.s0}'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                height: 20.h,
                width: 25.w,
                color: Colors.grey,
                child: Image.network(
                    fit: BoxFit.fill,
                    'http://10.0.2.2:3000/chestImage/${detailUserData.equipment!.s1}'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                height: 20.h,
                width: 25.w,
                color: Colors.grey,
                child: Image.network(
                    fit: BoxFit.fill,
                    'http://10.0.2.2:3000/headImage/${detailUserData.equipment!.s2}'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                height: 20.h,
                width: 25.w,
                color: Colors.grey,
                child: Image.network(
                    fit: BoxFit.fill,
                    'http://10.0.2.2:3000/armImage/${detailUserData.equipment!.s3}'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                height: 20.h,
                width: 25.w,
                color: Colors.grey,
                child: Image.network(
                    fit: BoxFit.fill,
                    'http://10.0.2.2:3000/legImage/${detailUserData.equipment!.s4}'),
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    int i = 0;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 120.h,
            width: 411.w,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  height: 120.h,
                  width: 10.w,
                  color: userData.escapeState == 3
                      ? gameRankColors.last
                      : gameRankColors[userData.gameRank as int],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 30,
                            width: 380.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          userData.escapeState == 3
                                              ? '탈출'
                                              : '#${userData.gameRank}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: gameRankColors[
                                                  userData.gameRank as int]),
                                        ),
                                        Text(
                                          ' 루미아섬 ',
                                          style: TextStyle(fontSize: 12.sp),
                                        ),
                                        Text(
                                          '${(Duration(seconds: userData.playTime as int)).inMinutes.remainder(60).toString().padLeft(2, '0')}:${(Duration(seconds: userData.playTime as int)).inSeconds.remainder(60).toString().padLeft(2, '0')} ',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10.sp),
                                        ),
                                        Text(
                                          timeago.format(
                                            DateTime.now().subtract(
                                              DateTime.now().difference(
                                                  DateTime.parse(userData
                                                      .startDtm as String)),
                                            ),
                                            locale: 'ko',
                                          ),
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10.sp),
                                        )
                                      ],
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          detailed = !detailed;
                                          setState(() {});
                                        },
                                        child: Icon(!detailed
                                            ? Icons.keyboard_arrow_down_sharp
                                            : Icons.keyboard_arrow_up_sharp))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 380.w,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                          child: Container(
                                            color: Colors.grey,
                                            width: 40.w,
                                            height: 40.h,
                                            child: Image.network(
                                                'http://10.0.2.2:3000/charactersImage/${userData.characterNum}'),
                                          ),
                                        ),
                                        Positioned(
                                          top: 25,
                                          left: 25,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100.0),
                                            child: Container(
                                              color: Colors.white,
                                              width: 15,
                                              height: 15,
                                              child: Center(
                                                child: Text(
                                                  userData.characterLevel
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 10.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          color: Colors.purple,
                                          width: 15,
                                          height: 15,
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Container(
                                          color: Colors.pink,
                                          width: 15,
                                          height: 15,
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                          child: Container(
                                            color: Colors.amber,
                                            width: 15,
                                            height: 15,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                          child: Container(
                                            color: Colors.amber,
                                            width: 15,
                                            height: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              userData.teamKill.toString(),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const Text('/'),
                                            Text(
                                              userData.playerKill.toString(),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const Text('/'),
                                            Text(
                                              userData.playerAssistant
                                                  .toString(),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Row(
                                          children: [
                                            Text(
                                              'TK',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            Text(
                                              '/',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            Text(
                                              'K',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            Text(
                                              '/',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            Text(
                                              'A',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        height: 20.h,
                                        width: 25.w,
                                        color: Colors.grey,
                                        child: Image.network(
                                            fit: BoxFit.fill,
                                            'http://10.0.2.2:3000/weaponsImage/${userData.equipment!.s0}'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        height: 20.h,
                                        width: 25.w,
                                        color: Colors.grey,
                                        child: Image.network(
                                            fit: BoxFit.fill,
                                            'http://10.0.2.2:3000/chestImage/${userData.equipment!.s1}'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        height: 20.h,
                                        width: 25.w,
                                        color: Colors.grey,
                                        child: Image.network(
                                            fit: BoxFit.fill,
                                            'http://10.0.2.2:3000/headImage/${userData.equipment!.s2}'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        height: 20.h,
                                        width: 25.w,
                                        color: Colors.grey,
                                        child: Image.network(
                                            fit: BoxFit.fill,
                                            'http://10.0.2.2:3000/armImage/${userData.equipment!.s3}'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        height: 20.h,
                                        width: 25.w,
                                        color: Colors.grey,
                                        child: Image.network(
                                            fit: BoxFit.fill,
                                            'http://10.0.2.2:3000/legImage/${userData.equipment!.s4}'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(height: 20.h),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      NumberFormat('###,###,###,###')
                                          .format(userData.damageToPlayer)
                                          .replaceAll(' ', ''),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const Text('딜량'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      userData.routeIdOfStart.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    const Text('루트ID')
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (detailed)
            Column(
              children: [
                Container(
                  color: Colors.grey[300],
                  child: Row(
                    children: [
                      SizedBox(
                        height: 30.h,
                        width: 40.w,
                        child: const Center(
                          child: Text(
                            '#',
                          ),
                        ),
                      ),
                      SizedBox(
                          height: 30.h,
                          width: 200.w,
                          child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('플레이어'))),
                      SizedBox(
                          height: 30.h,
                          width: 80.w,
                          child: const Align(
                              alignment: Alignment.center, child: Text('딜량'))),
                      const Expanded(
                        child: Align(
                            alignment: Alignment.center, child: Text('아이템')),
                      ),
                    ],
                  ),
                ),
                for (int q = 0;
                    q < widget.gameInfo.userGames!.length / 3;
                    q++, i += 3)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: q + 1 == userNumTeam ? Colors.amber[100] : null,
                      border: const Border(
                        bottom: BorderSide(color: Colors.black, width: 1),
                      ),
                    ),
                    child: Row(children: [
                      SizedBox(
                          width: 40.w,
                          child: Center(child: Text('#${(q + 1)}'))),
                      Column(
                        children: [
                          detailUserWidget(widget.gameInfo.userGames![i]),
                          detailUserWidget(widget.gameInfo.userGames![i + 1]),
                          detailUserWidget(widget.gameInfo.userGames![i + 2]),
                        ],
                      )
                    ]),
                  ),
              ],
            )
        ],
      ),
    );
  }
}
