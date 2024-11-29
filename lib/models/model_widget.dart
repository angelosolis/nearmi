import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';

enum WidgetType {
  listing,
  category,
  banner,
  slider,
  admob,
  blog,
}

enum WidgetDirection {
  horizontal,
  list,
  grid,
}

abstract class WidgetModel {
  String get title;
  String get description;
  WidgetType get type;

  const WidgetModel();

  Widget build(BuildContext context);
}

class ListingWidgetModel extends WidgetModel {
  @override
  final String title;
  @override
  final String description;
  @override
  final WidgetType type = WidgetType.listing;

  final Axis direction;
  final ProductViewType layout;
  final List<ProductModel> items;

  ListingWidgetModel({
    required this.title,
    required this.description,
    required this.layout,
    required this.direction,
    required this.items,
  });

  factory ListingWidgetModel.fromJson(Map<String, dynamic> json) {
    Axis direction = Axis.vertical;
    String title = json['title'] ?? '';
    String description = json['description'] ?? '';
    if (json['direction'] == 'horizontal') {
      direction = Axis.horizontal;
    }
    if (json['hide_title'] == true) {
      title = '';
    }
    if (json['hide_desc'] == true) {
      description = '';
    }
    return ListingWidgetModel(
      title: title,
      description: description,
      layout: mapListView[json['layout']] ?? ProductViewType.list,
      direction: direction,
      items: List.from(json['data']).map((e) {
        return ProductModel.fromJson(e);
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppListingWidget(widget: this);
  }
}

class CategoryWidgetModel extends WidgetModel {
  @override
  final String title;
  @override
  final String description;
  @override
  final WidgetType type = WidgetType.category;

  final WidgetDirection direction;
  final CategoryViewType layout;
  final List<CategoryModel> items;

  CategoryWidgetModel({
    required this.title,
    required this.description,
    required this.direction,
    required this.layout,
    required this.items,
  });

  factory CategoryWidgetModel.fromJson(Map<String, dynamic> json) {
    WidgetDirection direction = WidgetDirection.list;
    String title = json['title'] ?? '';
    String description = json['description'] ?? '';
    if (json['hide_title'] == true) title = '';
    if (json['hide_desc'] == true) description = '';
    if (json['direction'] == 'horizontal') {
      direction = WidgetDirection.horizontal;
    }
    if (json['direction'] == 'grid') direction = WidgetDirection.grid;

    Map<String, CategoryViewType> mapLayout = {
      'icon-circle': CategoryViewType.iconCircle,
      'icon-round': CategoryViewType.iconRound,
      'icon-square': CategoryViewType.iconSquare,
      'icon-landscape': CategoryViewType.iconLandscape,
      'icon-portrait': CategoryViewType.iconPortrait,
      'image-circle': CategoryViewType.imageCircle,
      'image-round': CategoryViewType.imageRound,
      'image-square': CategoryViewType.imageSquare,
      'image-landscape': CategoryViewType.imageLandscape,
      'image-portrait': CategoryViewType.imagePortrait,
    };
    if (direction == WidgetDirection.list) {
      mapLayout = {
        'icon-circle': CategoryViewType.iconCircleList,
        'icon-round': CategoryViewType.iconRoundList,
        'icon-square': CategoryViewType.iconShapeList,
        'icon-landscape': CategoryViewType.iconShapeList,
        'icon-portrait': CategoryViewType.iconShapeList,
        'image-circle': CategoryViewType.imageCircleList,
        'image-round': CategoryViewType.imageRoundList,
        'image-square': CategoryViewType.imageShapeList,
        'image-landscape': CategoryViewType.imageShapeList,
        'image-portrait': CategoryViewType.imageShapeList,
      };
    }

    return CategoryWidgetModel(
      title: title,
      description: description,
      direction: direction,
      layout: mapLayout[json['layout']] ?? CategoryViewType.iconSquare,
      items: List.from(json['data']).map((e) {
        return CategoryModel.fromJson(e);
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppCategoryWidget(widget: this);
  }
}

class BannerWidgetModel extends WidgetModel {
  @override
  final String title;
  @override
  final String description;
  @override
  final WidgetType type = WidgetType.listing;

  final BannerModel item;

  BannerWidgetModel({
    required this.title,
    required this.description,
    required this.item,
  });

  factory BannerWidgetModel.fromJson(Map<String, dynamic> json) {
    String title = json['title'] ?? '';
    String description = json['description'] ?? '';
    if (json['hide_title'] == true) {
      title = '';
    }
    if (json['hide_desc'] == true) {
      description = '';
    }
    return BannerWidgetModel(
      title: title,
      description: description,
      item: BannerModel.fromJson(json['data']),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBannerWidget(widget: this);
  }
}

class SliderWidgetModel extends WidgetModel {
  @override
  final String title;
  @override
  final String description;
  @override
  final WidgetType type = WidgetType.listing;

  final List<BannerModel> items;

  SliderWidgetModel({
    required this.title,
    required this.description,
    required this.items,
  });

  factory SliderWidgetModel.fromJson(Map<String, dynamic> json) {
    String title = json['title'] ?? '';
    String description = json['description'] ?? '';
    if (json['hide_title'] == true) {
      title = '';
    }
    if (json['hide_desc'] == true) {
      description = '';
    }
    return SliderWidgetModel(
      title: title,
      description: description,
      items: List.from(json['data']).map((e) {
        return BannerModel.fromJson(e);
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppSliderWidget(widget: this);
  }
}

class AdmobWidgetModel extends WidgetModel {
  @override
  final String title;
  @override
  final String description;
  @override
  final WidgetType type = WidgetType.listing;

  final String bannerID;
  final AdSize size;

  AdmobWidgetModel({
    required this.title,
    required this.description,
    required this.bannerID,
    required this.size,
  });

  factory AdmobWidgetModel.fromJson(Map<String, dynamic> json) {
    String title = json['title'] ?? '';
    String description = json['description'] ?? '';
    Map<String, dynamic> data = json['data'];
    if (json['hide_title'] == true) {
      title = '';
    }
    if (json['hide_desc'] == true) {
      description = '';
    }
    return AdmobWidgetModel(
      title: title,
      description: description,
      bannerID: Platform.isIOS ? data["ios"] : data["android"],
      size: AdSize(
        width: data['size']['width'],
        height: data['size']['height'],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppAdmobWidget(admob: this);
  }
}

class BlogWidgetModel extends WidgetModel {
  @override
  final String title;
  @override
  final String description;
  @override
  final WidgetType type = WidgetType.listing;

  final Axis direction;
  final BlogViewType layout;
  final List<BlogModel> items;

  BlogWidgetModel({
    required this.title,
    required this.description,
    required this.direction,
    required this.layout,
    required this.items,
  });

  factory BlogWidgetModel.fromJson(Map<String, dynamic> json) {
    Axis direction = Axis.vertical;
    String title = json['title'] ?? '';
    String description = json['description'] ?? '';
    if (json['direction'] == 'horizontal') {
      direction = Axis.horizontal;
    }
    if (json['hide_title'] == true) {
      title = '';
    }
    if (json['hide_desc'] == true) {
      description = '';
    }
    return BlogWidgetModel(
      title: title,
      description: description,
      layout: mapBlogView[json['layout']] ?? BlogViewType.list,
      direction: direction,
      items: List.from(json['data']).map((e) {
        return BlogModel.fromJson(e);
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBlogWidget(widget: this);
  }
}

class DefaultWidgetModel extends WidgetModel {
  @override
  final String title;
  @override
  final String description;
  @override
  final WidgetType type = WidgetType.listing;

  DefaultWidgetModel({
    required this.title,
    required this.description,
  });

  factory DefaultWidgetModel.fromJson(Map<String, dynamic> json) {
    String title = json['title'] ?? '';
    String description = json['description'] ?? '';
    if (json['hide_title'] == true) {
      title = '';
    }
    if (json['hide_desc'] == true) {
      description = '';
    }
    return DefaultWidgetModel(
      title: title,
      description: description,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.pink,
    );
  }
}
