import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fmdakgg/home_screen/home_screen_model.dart';
import 'package:fmdakgg/home_screen/home_screen_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final homeScreenViewModelProvider =
    StateNotifierProvider<HomeScreenViewModel, HomeScreenModel>(
        (ref) => HomeScreenViewModel());
final TextEditingController searchController = TextEditingController();

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeScreenModel = ref.watch(homeScreenViewModelProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: const Color.fromARGB(234, 13, 13, 13),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            'FmDak.gg',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          child: TextField(
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white),
                            textAlign: TextAlign.left,
                            decoration: const InputDecoration(
                              hintText: '플레이어 닉네임을 입력해주세요.',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.white54,
                              ),
                            ),
                            onSubmitted: (value) async {
                              context.push('/player/$value');
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '실험체',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        height: 50,
                        color: const Color.fromARGB(234, 13, 13, 13),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  '실험체 목록',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: SizedBox(
                                    width: 130,
                                    child: TextField(
                                      controller: searchController,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: '실험체 검색 (수아, ㅅㅇ)',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none, // 테두리 없애기
                                      ),
                                      onChanged: (value) {
                                        ref
                                            .read(homeScreenViewModelProvider
                                                .notifier)
                                            .filterCharacters(value);
                                      },
                                      onSubmitted: (value) {
                                        ref
                                            .read(homeScreenViewModelProvider
                                                .notifier)
                                            .filterCharacters(value);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 300,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 394.6.w,
                        child: Wrap(
                          children: homeScreenModel.characterList
                              .asMap()
                              .entries
                              .map((entry) {
                            int idx = entry.key;
                            String character = entry.value;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      print("클릭 $character");
                                      ref
                                          .read(homeScreenViewModelProvider
                                              .notifier)
                                          .filterCharacters(character);
                                      searchController.text = character;
                                    },
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      color: Colors.black,
                                      // child: Image.network(
                                      //   'http://10.0.2.2:3000/charactersImage/${idx + 1}',
                                      //   fit: BoxFit.fill,
                                      // ),
                                    ),
                                  ),
                                  Text(character) // 캐릭터 이름 출력
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 50,
              ),
              Container(
                color: Colors.grey[100],
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      color: Colors.black12,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            const Text(
                              '무기명',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              homeScreenModel.characterList.length == 1
                                  ? homeScreenModel.characterList[0]
                                  : '캐릭터명',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        color: Colors.amber,
                        child: const Center(
                          child: Text(
                            '랭크',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        color: Colors.grey,
                        child: const Center(
                          child: Text(
                            '코발트',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 50,
                  color: Colors.amber,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            color: Colors.black,
                            height: 20,
                            width: 20,
                          )),
                      const Center(
                        child: Text(
                          '무기 비율',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(12.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       DropdownMenu<String>(
              //         width: 180,
              //         initialSelection: period.first,
              //         onSelected: (String? value) {},
              //         dropdownMenuEntries:
              //             period.map<DropdownMenuEntry<String>>((String value) {
              //           return DropdownMenuEntry<String>(
              //               value: value, label: value);
              //         }).toList(),
              //       ),
              //       DropdownMenu<String>(
              //         width: 180,
              //         initialSelection: section.first,
              //         onSelected: (String? value) {},
              //         dropdownMenuEntries: section
              //             .map<DropdownMenuEntry<String>>((String value) {
              //           return DropdownMenuEntry<String>(
              //               value: value, label: value);
              //         }).toList(),
              //       ),
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 12,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 160,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                    ),
                                    child: const Center(
                                      child: Text('승률'),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.pink,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(border: Border()),
                            height: 160,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                    ),
                                    child: const Center(
                                      child: Text('TOP 3'),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 160,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                    ),
                                    child: const Center(
                                      child: Text('RP 획득'),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 160,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                    ),
                                    child: const Center(
                                      child: Text('승률'),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.pink,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(border: Border()),
                            height: 160,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                    ),
                                    child: const Center(
                                      child: Text('TOP 3'),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 160,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                    ),
                                    child: const Center(
                                      child: Text('RP 획득'),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.blueGrey,
                                    ),
                                  ),
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
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Text(
                      '캐릭터명',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      ' 스킬',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.cyan,
                height: 300,
                child: const Center(
                  child: Text('스킬 동영상 '),
                ),
              ),
              Container(
                color: Colors.purple,
                height: 500,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            border: Border.all(
                              width: 3,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 1,
                          right: 1,
                          child: Container(
                            alignment: Alignment.center,
                            width: 18,
                            height: 18,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                            child: const FittedBox(
                              child: Text(
                                'Q',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          color: Colors.amber,
                        ),
                        Positioned(
                          bottom: 1,
                          right: 1,
                          child: Container(
                            alignment: Alignment.center,
                            width: 18,
                            height: 18,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                            child: const FittedBox(
                              child: Text(
                                'W',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          color: Colors.amber,
                        ),
                        Positioned(
                          bottom: 1,
                          right: 1,
                          child: Container(
                            alignment: Alignment.center,
                            width: 18,
                            height: 18,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                            child: const FittedBox(
                              child: Text(
                                'E',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          color: Colors.amber,
                        ),
                        Positioned(
                          bottom: 1,
                          right: 1,
                          child: Container(
                            alignment: Alignment.center,
                            width: 18,
                            height: 18,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                            child: const FittedBox(
                              child: Text(
                                'R',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          color: Colors.amber,
                        ),
                        Positioned(
                          bottom: 1,
                          right: 1,
                          child: Container(
                            alignment: Alignment.center,
                            width: 18,
                            height: 18,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                            child: const FittedBox(
                              child: Text(
                                'T',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
