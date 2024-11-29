class UserModel {
  final int id;
  final String name;
  final String firstName;
  final String lastName;
  final String image;
  final String url;
  final int level;
  final String description;
  final String tag;
  final double rate;
  final int comment;
  final int total;
  final String? token;
  final String email;

  UserModel({
    required this.id,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.url,
    required this.level,
    required this.description,
    required this.tag,
    required this.rate,
    required this.comment,
    required this.total,
    this.token,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: int.tryParse('${json['id']}') ?? 0,
      name: json['name'] ?? json['display_name'] ?? 'Unknown',
      firstName: json['first_name'] ?? 'Unknown',
      lastName: json['last_name'] ?? 'Unknown',
      image: json['image'] ?? json['user_photo'] ?? '',
      url: json['url'] ?? json['user_url'] ?? 'Unknown',
      level: json['user_level'] ?? 0,
      description: json['description'] ?? '',
      tag: json['tag'] ?? 'Unknown',
      rate: double.tryParse('${json['rating_avg']}') ?? 0.0,
      comment: int.tryParse('${json['total_comment']}') ?? 0,
      total: json['total'] ?? 0,
      token: json['token'],
      email: json['email'] ?? json['user_email'] ?? 'Unknown',
    );
  }

  UserModel copyWith({
    String? name,
    String? firstName,
    String? lastName,
    String? email,
    String? url,
    String? description,
    String? image,
    int? total,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      image: image ?? this.image,
      url: url ?? this.url,
      level: level,
      description: description ?? this.description,
      tag: tag,
      rate: rate,
      comment: comment,
      total: total ?? this.total,
      token: token,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'display_name': name,
      'user_photo': image,
      'user_url': url,
      'user_level': level,
      'description': description,
      'tag': tag,
      'rating_avg': rate,
      'total_comment': rate,
      'total': total,
      'token': token,
      'user_email': email
    };
  }
}
