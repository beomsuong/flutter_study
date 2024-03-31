import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmdakgg/home_screen/home_screen_model.dart';

class HomeScreenViewModel extends StateNotifier<HomeScreenModel> {
  HomeScreenViewModel() : super(HomeScreenModel());

  void filterCharacters(String query) {
    if (query.isEmpty) {
      state = HomeScreenModel();
    } else {
      final filteredList = HomeScreenModel().characterList.where((character) {
        final searchLower = query.toLowerCase();
        final characterLower = character.toLowerCase();
        return characterLower.contains(searchLower);
      }).toList();
      print('필터링된 목록: $filteredList');
      state = state.copyWith(characterList: filteredList);
    }
  }
}
