import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/repository/repository.dart';

import 'cubit.dart';

class BlogListCubit extends Cubit<BlogListState> {
  BlogListCubit() : super(BlogListLoading());
  Timer? timer;

  Future<void> onLoad({
    CategoryModel? category,
    SortModel? sort,
    String? keyword,
  }) async {
    int timeout = 0;
    if (keyword != null && keyword.isNotEmpty) {
      timeout = 500;
    }
    timer?.cancel();
    timer = Timer(Duration(milliseconds: timeout), () async {
      final result = await ListRepository.loadBlogList(
        category: category,
        sort: sort,
        keyword: keyword,
      );
      if (result != null) {
        emit(BlogListSuccess(
          list: result[0],
          categories: result[1],
          sticky: result[2],
        ));
      }
    });
  }
}
