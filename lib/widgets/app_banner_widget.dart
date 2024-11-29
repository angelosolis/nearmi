import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_placeholder.dart';

class AppBannerWidget extends StatelessWidget {
  final BannerWidgetModel widget;
  const AppBannerWidget({Key? key, required this.widget}) : super(key: key);

  ///Make action
  void _makeAction() async {
    try {
      launchUrl(Uri.parse(widget.item.link));
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
          CachedNetworkImage(
            imageUrl: widget.item.image.full,
            placeholder: (context, url) {
              return AppPlaceholder(
                child: Container(
                  height: 120,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              );
            },
            imageBuilder: (context, imageProvider) {
              return InkWell(
                onTap: _makeAction,
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
            errorWidget: (context, url, error) {
              return Container(
                height: 120,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: const Icon(Icons.image_not_supported_outlined),
              );
            },
          )
        ],
      ),
    );
  }
}
