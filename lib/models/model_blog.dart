import 'package:listar_flutter_pro/models/model.dart';

enum BlogViewType { grid, list, block }

final Map<String, BlogViewType> mapBlogView = {
  'list': BlogViewType.list,
  'grid': BlogViewType.grid,
  'block': BlogViewType.block,
};

class BlogModel {
  final int id;
  final String title;
  final ImageModel image;
  final List<CategoryModel> category;
  final DateTime createDate;
  final String status;
  final String description;
  final String numComments;
  final UserModel author;
  final String link;

  BlogModel({
    required this.id,
    required this.title,
    required this.image,
    required this.category,
    required this.createDate,
    required this.status,
    required this.description,
    required this.numComments,
    required this.author,
    required this.link,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    List<CategoryModel> category = [];
    if (json['categories'] != null) {
      category = List.from(json['categories'] ?? []).map((item) {
        return CategoryModel.fromJson(item);
      }).toList();
    }

    return BlogModel(
      id: int.tryParse('${json['ID']}') ?? 0,
      title: json['post_title'] ?? '',
      image: ImageModel.fromJson(json['image'] ?? {'full': {}, 'thumb': {}}),
      category: category,
      createDate: DateTime.tryParse(json['post_date']) ?? DateTime.now(),
      status: json['post_status'] ?? '',
      description: json['post_content'] ?? json['post_excerpt'] ?? '',
      numComments: json['comment_count'] ?? '',
      author: UserModel.fromJson(json['author']),
      link: json['guid'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ID": id,
      "post_title": title,
      "image": {
        "id": 0,
        "full": {},
        "thumb": {},
      },
    };
  }
}
