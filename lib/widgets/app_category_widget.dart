import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';

class AppCategoryWidget extends StatelessWidget {
  final CategoryWidgetModel widget;
  const AppCategoryWidget({Key? key, required this.widget}) : super(key: key);

  ///On select category
  void _onCategory(
    BuildContext context,
    CategoryModel item,
  ) {
    if (item.id == -1) {
      Navigator.pushNamed(context, Routes.category);
      return;
    }
    if (item.hasChild) {
      Navigator.pushNamed(context, Routes.category, arguments: item);
    } else {
      Navigator.pushNamed(context, Routes.listProduct, arguments: item);
    }
  }

  Widget _buildWidgetDirection(BuildContext context) {
    if (widget.direction == WidgetDirection.grid) {
      final Map<CategoryViewType, double> numberColumns = {
        CategoryViewType.iconCircle: 4,
        CategoryViewType.iconRound: 3,
        CategoryViewType.iconSquare: 2,
        CategoryViewType.iconLandscape: 2,
        CategoryViewType.iconPortrait: 2,
        CategoryViewType.imageCircle: 4,
        CategoryViewType.imageRound: 3,
        CategoryViewType.imageSquare: 2,
        CategoryViewType.imageLandscape: 2,
        CategoryViewType.imagePortrait: 2,
      };
      final screenWidth = MediaQuery.of(context).size.width;
      final spacing = (numberColumns[widget.layout]! - 1) * 8 + 24;
      final widthGrid = screenWidth - spacing;
      final more = [];

      if (widget.layout == CategoryViewType.iconCircle) {
        final moreItem = CategoryModel.fromJson({
          "term_id": -1,
          "name": Translate.of(context).translate("more"),
          "icon": "fas fa-ellipsis",
          "color": "#ff8a65",
        });
        more.add(SizedBox(
          width: widthGrid / numberColumns[widget.layout]!,
          child: AppCategoryItem(
            onPressed: () {
              _onCategory(context, moreItem);
            },
            item: moreItem,
            type: widget.layout,
          ),
        ));
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Wrap(
          runSpacing: 8,
          spacing: 8,
          children: [
            ...widget.items.toList().map(
              (item) {
                return SizedBox(
                  width: widthGrid / numberColumns[widget.layout]!,
                  child: AppCategoryItem(
                    onPressed: () {
                      _onCategory(context, item);
                    },
                    item: item,
                    type: widget.layout,
                  ),
                );
              },
            ),
            ...more
          ],
        ),
      );
    }

    if (widget.direction == WidgetDirection.horizontal) {
      double? width;
      if (widget.layout == CategoryViewType.iconPortrait ||
          widget.layout == CategoryViewType.imagePortrait) {
        width = 130;
      }
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: widget.items.map((item) {
              return Container(
                width: width,
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: AppCategoryItem(
                  onPressed: () {
                    _onCategory(context, item);
                  },
                  item: item,
                  type: widget.layout,
                ),
              );
            }).toList(),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = widget.items[index];
          return AppCategoryItem(
            onPressed: () {
              _onCategory(context, item);
            },
            item: item,
            type: widget.layout,
          );
        },
        itemCount: widget.items.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 8);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget title = Container();
    Widget description = Container();
    Widget header = Container();
    if (widget.title.isNotEmpty) {
      title = Text(
        widget.title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.bold),
      );
    }
    if (widget.description.isNotEmpty) {
      description = Text(
        widget.description,
        style: Theme.of(context).textTheme.bodySmall,
      );
    }
    if (widget.title.isNotEmpty || widget.description.isNotEmpty) {
      header = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            title,
            description,
            const SizedBox(height: 8),
          ],
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        header,
        _buildWidgetDirection(context),
      ],
    );
  }
}
