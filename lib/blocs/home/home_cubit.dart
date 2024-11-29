import 'package:bloc/bloc.dart';
import 'package:listar_flutter_pro/api/api.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/models/model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeLoading());

  Future<void> onLoad({
    reload = false,
    widget = false,
    CategoryModel? location,
  }) async {
    if (reload) {
      emit(HomeLoading());
    }

    ///Fetch API Home
    late ResultApiModel response;
    HomeHeaderModel? headerType;
    if (widget) {
      response = await Api.requestHomeWidget({"option": location?.id});
    } else {
      response = await Api.requestHome({"option": location?.id});
    }
    if (response.success) {
      if (response.data['header'] != null) {
        headerType = HomeHeaderModel.fromJson(response.data['header']);
      }
      final banner = List<String>.from(response.data['sliders'] ?? []);

      final category = List.from(response.data['categories'] ?? []).map((item) {
        return CategoryModel.fromJson(item);
      }).toList();

      final location = List.from(response.data['locations'] ?? []).map((item) {
        return CategoryModel.fromJson(item);
      }).toList();

      final recent = List.from(response.data['recent_posts'] ?? []).map((item) {
        return ProductModel.fromJson(item);
      }).toList();

      final options = List.from(response.data['options'] ?? []).map((item) {
        return CategoryModel.fromJson(item);
      }).toList();

      final widgets = List.from(response.data['widgets'] ?? []).map((item) {
        final String type = item['type'];
        switch (type) {
          case 'listing':
            return ListingWidgetModel.fromJson(item);
          case 'category':
            return CategoryWidgetModel.fromJson(item);
          case 'location':
            return CategoryWidgetModel.fromJson(item);
          case 'banner':
            return BannerWidgetModel.fromJson(item);
          case 'slider':
            return SliderWidgetModel.fromJson(item);
          case 'admob':
            return AdmobWidgetModel.fromJson(item);
          case 'post':
            return BlogWidgetModel.fromJson(item);
          default:
            return DefaultWidgetModel.fromJson(item);
        }
      }).toList();

      ///Notify
      emit(HomeSuccess(
        headerType: headerType,
        banner: banner,
        category: category,
        location: location,
        recent: recent,
        options: options,
        widgets: widgets,
      ));
    } else {
      AppBloc.messageBloc.add(MessageEvent(message: response.message));
    }
  }
}
