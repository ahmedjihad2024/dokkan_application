import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/network/failure_message.dart';
import '../../domain/usecase/get_categories_usecase.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final RefreshController refreshController = RefreshController();

  CategoriesCubit({required this.getCategoriesUseCase})
      : super(const CategoriesLoading());

  @override
  Future<void> close() {
    refreshController.dispose();
    return super.close();
  }

  Future<void> getCategories({bool isRefresh = false}) async {
    if (isClosed) return;

    if (isRefresh) {
      emit(const CategoriesLoading());
    }

    final result = await getCategoriesUseCase();

    if (isClosed) return;

    result.fold(
      (failure) {
        if (isClosed) return;
        if (isRefresh) {
          refreshController.refreshFailed();
        }
        emit(CategoriesError(message: failure.message));
      },
      (categories) {
        if (isClosed) return;
        if (isRefresh) {
          refreshController.refreshCompleted(resetFooterState: true);
        }
        if (categories.isEmpty) {
          emit(const CategoriesEmpty());
        } else {
          emit(CategoriesActive(categories: categories));
        }
      },
    );
  }
}
