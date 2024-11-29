import 'package:bloc/bloc.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/repository/repository.dart';

class BlogDetailCubit extends Cubit<BlogDetailState> {
  BlogDetailCubit() : super(BlogDetailLoading());
  BlogModel? blog;

  void onLoad(int id) async {
    final result = await ListRepository.loadBlog(id);
    if (result != null) {
      emit(BlogDetailSuccess(result));
    }
  }
}
