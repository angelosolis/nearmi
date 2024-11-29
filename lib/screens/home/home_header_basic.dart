import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';

class HomeHeaderBasic extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final List<String>? banners;
  final VoidCallback onSearch;
  final VoidCallback onScan;

  HomeHeaderBasic({
    required this.expandedHeight,
    required this.onSearch,
    required this.onScan,
    this.banners,
  });

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    return Container(
      color: Theme.of(context).cardColor,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AppImageSwiper(
            images: banners?.map((e) {
              return ImageModel(id: 0, full: e, thumb: e);
            }).toList(),
            alignment: const Alignment(0.0, 0.6),
          ),
          Container(
            height: 28,
            color: Theme.of(context).colorScheme.background,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: AppSearchBar(
              onSearch: onSearch,
              onScan: onScan,
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 115;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
