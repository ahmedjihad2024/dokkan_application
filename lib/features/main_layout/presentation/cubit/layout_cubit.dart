import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  late final PageController _pageController;

  PageController get pageController => _pageController;

  LayoutCubit() : super(const LayoutState()) {
    _pageController = PageController();
  }

  void setNavIndex(int index) {
    if (state.currentNavIndex != index) {
      emit(state.copyWith(currentNavIndex: index));
    }
    if (_pageController.hasClients && (_pageController.page?.round() != index)) {
      _pageController.jumpToPage(index);
    }
  }

  @override
  Future<void> close() {
    _pageController.dispose();
    return super.close();
  }
}
