import 'package:listar_flutter_pro/api/api.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/models/model.dart';

class ReviewRepository {
  ///Fetch api getReview
  static Future<List?> loadReview(id) async {
    final response = await Api.requestReview({"post_id": id});
    if (response.success) {
      final listComment = List.from(response.data ?? []).map((item) {
        return CommentModel.fromJson(item);
      }).toList();
      final rate = RateModel.fromJson(response.origin['attr']['rating']);
      return [listComment, rate];
    }
    AppBloc.messageBloc.add(MessageEvent(message: response.message));
    return null;
  }

  ///Fetch save review
  static Future<bool> saveReview({
    required int id,
    required String content,
    required double? rate,
  }) async {
    final params = {
      "post": id,
      "content": content,
      "rating": rate,
    };
    final response = await Api.requestSaveReview(params);
    AppBloc.messageBloc.add(MessageEvent(message: response.message));
    if (response.success) {
      return true;
    }
    return false;
  }

  ///Fetch author review
  static Future<List?> loadAuthorReview({
    required int page,
    required int perPage,
    required String keyword,
    required int userID,
  }) async {
    Map<String, dynamic> params = {
      "page": page,
      "per_page": perPage,
      "s": keyword,
      "user_id": userID,
    };
    final response = await Api.requestAuthorReview(params);
    if (response.success) {
      final listComment = List.from(response.data ?? []).map((item) {
        return CommentModel.fromJson(item);
      }).toList();

      final pagination = PaginationModel.fromJson(
        response.origin['pagination'],
      );
      return [listComment, pagination];
    }
    AppBloc.messageBloc.add(MessageEvent(message: response.message));
    return null;
  }
}
