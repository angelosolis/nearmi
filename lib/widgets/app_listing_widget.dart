import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';

class AppListingWidget extends StatelessWidget {
  final ListingWidgetModel widget;
  const AppListingWidget({Key? key, required this.widget}) : super(key: key);

  Widget _buildWidgetDirection(BuildContext context) {
    if (widget.direction == Axis.horizontal) {
      final Map<ProductViewType, double> widthHorizontal = {
        ProductViewType.small: 260,
        ProductViewType.grid: 200,
        ProductViewType.list: 300,
        ProductViewType.block: 300,
        ProductViewType.card: 300,
      };
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: widget.items.map((item) {
              return Container(
                padding: const EdgeInsets.only(left: 12),
                width: widthHorizontal[widget.layout]!,
                child: AppProductItem(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.productDetail,
                      arguments: item,
                    );
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

    Widget content = ListView.separated(
      scrollDirection: widget.direction,
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = widget.items[index];
        return AppProductItem(
          onPressed: () {
            Navigator.pushNamed(
              context,
              Routes.productDetail,
              arguments: item,
            );
          },
          item: item,
          type: widget.layout,
        );
      },
      itemCount: widget.items.length,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 12);
      },
    );

    if (widget.layout == ProductViewType.grid) {
      final screenWidth = MediaQuery.of(context).size.width;
      const spacing = 12 + 32;
      final widthGrid = screenWidth - spacing;
      content = Wrap(
        runSpacing: 12,
        spacing: 12,
        children: widget.items.map((item) {
          return SizedBox(
            width: widthGrid / 2,
            child: AppProductItem(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.productDetail,
                  arguments: item,
                );
              },
              item: item,
              type: widget.layout,
            ),
          );
        }).toList(),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: content,
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
