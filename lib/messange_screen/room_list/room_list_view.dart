import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fmdakgg/messange_screen/room/room_view.dart';
import 'package:fmdakgg/messange_screen/room_list/room_list_model.dart';
import 'package:fmdakgg/messange_screen/room_list/room_list_view_model.dart';
import 'package:intl/intl.dart';

final roomListViewModelProvider =
    StateNotifierProvider<RoomListViewModel, List<RoomListModel>>((ref) {
  return RoomListViewModel();
});

class RoomListView extends ConsumerStatefulWidget {
  const RoomListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RoomListViewState();
}

class _RoomListViewState extends ConsumerState<RoomListView> {
  @override
  Widget build(BuildContext context) {
    final roomList = ref.watch(roomListViewModelProvider);

    return Expanded(
      child: ListView.builder(
        itemCount: roomList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RoomView(
                        roomName: roomList[index].roomName,
                        numberOfPeople:
                            roomList[index].numberOfPeople as int)));
                ref.read(roomListViewModelProvider.notifier).getRoomList();
              },
              child: SizedBox(
                  child: Row(
                children: [
                  Container(width: 40.w, height: 40.h, color: Colors.purple),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  roomList[index].roomName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp),
                                ),
                                Text(
                                  ' ${roomList[index].numberOfPeople}명',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.sp),
                                ),
                              ],
                            ),
                            Text(
                              DateFormat("M월 d일 HH:mm")
                                  .format(roomList[index].lastTime.toLocal()),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14.sp),
                            ),
                          ],
                        ),
                        Text(
                          roomList[index].lastMsg,
                          style: TextStyle(fontSize: 14.sp),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ],
              )),
            ),
          );
        },
      ),
    );
  }
}
