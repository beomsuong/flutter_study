import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fmdakgg/messange_screen/room/message_widget.dart';
import 'package:fmdakgg/messange_screen/room/room_list_view_model.dart';
import 'package:fmdakgg/messange_screen/room/room_model.dart';
import 'package:fmdakgg/messange_screen/room_list/room_list_view.dart';

ScrollController scrollController = ScrollController();

class RoomView extends ConsumerStatefulWidget {
  final String roomName;
  final int numberOfPeople;
  const RoomView(
      {Key? key, required this.roomName, required this.numberOfPeople})
      : super(key: key);

  @override
  _RoomViewState createState() => _RoomViewState();
}

class _RoomViewState extends ConsumerState<RoomView> {
  final TextEditingController _controller = TextEditingController();

  final roomViewModelProvider = StateNotifierProvider.family<
      MessageListViewModel,
      List<MessageModel>,
      String>((ref, roomName) => MessageListViewModel(roomName));

  bool showMoveBottom = false;

  @override
  void initState() {
    scrollController.addListener(_scrollListener);

    super.initState();
  }

  void _scrollListener() {
    if (mounted) {
      setState(() {
        showMoveBottom =
            scrollController.offset < scrollController.position.maxScrollExtent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(roomViewModelProvider(widget.roomName));
    final viewModel =
        ref.watch(roomViewModelProvider(widget.roomName).notifier);
    viewModel.numberOfPeople = widget.numberOfPeople;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.roomName,
                  style: TextStyle(fontSize: 18.sp),
                ),
                Text(
                  '${viewModel.numberOfPeople}명',
                  style: TextStyle(fontSize: 12.sp),
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    String inputNickname = '';

                    return AlertDialog(
                      title: const Text('닉네임 수정'),
                      content: TextField(
                        onChanged: (value) {
                          inputNickname = value;
                        },
                        decoration: const InputDecoration(hintText: "새 닉네임 입력"),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('취소'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('수정'),
                          onPressed: () {
                            viewModel.changeNickname(inputNickname);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Icon(Icons.settings),
            )
          ],
        ),
      ),
      body: Container(
        color: Colors.blue[100],
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: [
                    ListView.builder(
                      controller: scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return MessageWidget(
                          messageData: messages[index],
                          userId: ref
                              .read(roomViewModelProvider(widget.roomName)
                                  .notifier)
                              .socket
                              .id
                              .toString(),
                        );
                      },
                    ),
                    if (showMoveBottom)
                      Positioned(
                        bottom: 0,
                        left: (MediaQuery.of(context).size.width / 2) - 40,
                        child: GestureDetector(
                          onTap: () => scrollController.jumpTo(
                              scrollController.position.maxScrollExtent),
                          child: Container(
                            width: 30.w,
                            height: 30.h,
                            decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                )),
                            child: const Icon(Icons.arrow_downward),
                          ),
                        ),
                      )
                  ],
                ),
              ),
              TextField(
                  controller: _controller,
                  onSubmitted: (value) {
                    if (_controller.text.isNotEmpty) {
                      ref
                          .read(roomViewModelProvider(widget.roomName).notifier)
                          .sendMessage(_controller.text);
                      _controller.clear();
                      Future.delayed(const Duration(milliseconds: 100), () {
                        if (scrollController.hasClients) {
                          scrollController.animateTo(
                            scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOut,
                          );
                        }
                      });
                    }
                  },
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        if (_controller.text.isNotEmpty) {
                          ref
                              .read(roomViewModelProvider(widget.roomName)
                                  .notifier)
                              .sendMessage(_controller.text);
                          _controller.clear();
                          Future.delayed(const Duration(milliseconds: 100), () {
                            if (scrollController.hasClients) {
                              scrollController.animateTo(
                                scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeOut,
                              );
                            }
                          });
                        }
                      },
                      child: const Icon(Icons.send),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
