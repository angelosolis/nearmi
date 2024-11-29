import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_placeholder.dart';

class AppSliderWidget extends StatelessWidget {
  final SliderWidgetModel widget;
  const AppSliderWidget({Key? key, required this.widget}) : super(key: key);

  ///Make action
  void _makeAction(String url) async {
    try {
      launchUrl(Uri.parse(url));
    } catch (e) {
      UtilLogger.log("BANNER CLICK FAIL", e.toString());
    }
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
      header = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          title,
          description,
          const SizedBox(height: 8),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header,
          Container(
            height: 120,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Swiper(
              itemBuilder: (context, index) {
                final item = widget.items[index];
                return InkWell(
                  onTap: () {
                    _makeAction(item.link);
                  },
                  child: CachedNetworkImage(
                    imageUrl: item.image.full,
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
                  ),
                );
              },
              autoplayDelay: 3000,
              autoplayDisableOnInteraction: false,
              autoplay: true,
              itemCount: widget.items.length,
              pagination: SwiperPagination(
                alignment: const Alignment(0.0, 1.1),
                builder: DotSwiperPaginationBuilder(
                  activeColor: Theme.of(context).colorScheme.primary,
                  color: Colors.white,
                  size: 6,
                  activeSize: 8,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
