import 'package:listar_flutter_pro/models/model.dart';

abstract class BlogListState {}

class BlogListLoading extends BlogListState {}

class BlogListSuccess extends BlogListState {
  final BlogModel? sticky;
  final List<BlogModel> list;
  final List<CategoryModel> categories;

  BlogListSuccess({
    required this.sticky,
    required this.list,
    required this.categories,
  });
}
