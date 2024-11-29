import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/models/model.dart';

import 'app_placeholder.dart';

class AppImageSwiper extends StatelessWidget {
  const AppImageSwiper({
    Key? key,
    required this.images,
    this.alignment,
  }) : super(key: key);

  final Alignment? alignment;
  final List<ImageModel>? images;

  @override
  Widget build(BuildContext context) {
    if (images != null) {
      return Swiper(
        itemBuilder: (context, index) {
          return CachedNetworkImage(
            imageUrl: images![index].full,
            placeholder: (context, url) {
              return AppPlaceholder(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              );
            },
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            errorWidget: (context, url, error) {
              return Container(
                color: Colors.white,
                child: const Icon(Icons.image_not_supported_outlined),
              );
            },
          );
        },
        autoplayDelay: 3000,
        autoplayDisableOnInteraction: false,
        autoplay: true,
        itemCount: images!.length,
        pagination: SwiperPagination(
          alignment: alignment ?? const Alignment(0.0, 1.0),
          builder: DotSwiperPaginationBuilder(
            activeColor: Theme.of(context).colorScheme.primary,
            color: Colors.white,
            size: 6,
            activeSize: 8,
          ),
        ),
      );
    }
    return AppPlaceholder(
      child: Container(
        color: Colors.white,
      ),
    );
  }
}
