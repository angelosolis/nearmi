import 'package:listar_flutter_pro/models/model.dart';

abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final HomeHeaderModel? headerType;
  final List<String> banner;
  final List<CategoryModel> category;
  final List<CategoryModel> location;
  final List<ProductModel> recent;
  final List<CategoryModel> options;
  final List<WidgetModel> widgets;

  HomeSuccess({
    required this.headerType,
    required this.banner,
    required this.category,
    required this.location,
    required this.recent,
    required this.options,
    required this.widgets,
  });
}
