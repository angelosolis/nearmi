import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';

class AppCategoryItem extends StatelessWidget {
  const AppCategoryItem({
    Key? key,
    this.type = CategoryViewType.full,
    this.item,
    this.onPressed,
  }) : super(key: key);

  final CategoryViewType type;
  final CategoryModel? item;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      ///Icon Circle
      case CategoryViewType.iconCircle:
        if (item == null) {
          return AppPlaceholder(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 12,
                  width: 60,
                  color: Colors.white,
                ),
              ],
            ),
          );
        }

        return InkWell(
          onTap: onPressed,
          child: SizedBox(
            width: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: item!.color?.withAlpha(70),
                  ),
                  child: Icon(
                    item!.icon,
                    color: item?.color ?? Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item!.title,
                  style: Theme.of(context).textTheme.labelSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        );

      ///Icon Round
      case CategoryViewType.iconRound:
        if (item == null) {
          return AppPlaceholder(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 60,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 12,
                  width: 60,
                  color: Colors.white,
                ),
              ],
            ),
          );
        }

        return InkWell(
          onTap: onPressed,
          child: SizedBox(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 60,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: item!.color?.withAlpha(70),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    item!.icon,
                    color: item?.color ?? Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item!.title,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        );

      ///Icon Square
      case CategoryViewType.iconSquare:
        if (item == null) {
          return AppPlaceholder(
            child: Container(
              width: 160,
              height: 160,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).dividerColor.withAlpha(10),
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: const Offset(
                      0,
                      4,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return InkWell(
          onTap: onPressed,
          child: Container(
            width: 160,
            height: 160,
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).dividerColor.withAlpha(10),
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: const Offset(
                    0,
                    4,
                  ),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: item!.color?.withAlpha(70),
                  ),
                  child: Icon(
                    item!.icon,
                    color: item?.color ?? Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item!.title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  '${item!.count} ${Translate.of(context).translate('location')}',
                  style: Theme.of(context).textTheme.labelMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              ],
            ),
          ),
        );

      ///Icon LandScape
      case CategoryViewType.iconLandscape:
        if (item == null) {
          return AppPlaceholder(
            child: Container(
              width: 220,
              height: 130,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).dividerColor.withAlpha(10),
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: const Offset(
                      0,
                      4,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return InkWell(
          onTap: onPressed,
          child: Container(
            width: 220,
            height: 130,
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).dividerColor.withAlpha(10),
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: const Offset(
                    0,
                    4,
                  ),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: item!.color?.withAlpha(70),
                  ),
                  child: Icon(
                    item!.icon,
                    color: item?.color ?? Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item!.title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  '${item!.count} ${Translate.of(context).translate('location')}',
                  style: Theme.of(context).textTheme.labelSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              ],
            ),
          ),
        );

      ///Icon Portrait
      case CategoryViewType.iconPortrait:
        if (item == null) {
          return AppPlaceholder(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 300.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    width: constraints.maxWidth,
                    height: constraints.maxWidth * 1.2,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).dividerColor.withAlpha(10),
                          spreadRadius: 4,
                          blurRadius: 4,
                          offset: const Offset(
                            0,
                            4,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        }

        return InkWell(
          onTap: onPressed,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 300.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  width: constraints.maxWidth,
                  height: constraints.maxWidth * 1.2,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).dividerColor.withAlpha(10),
                        spreadRadius: 4,
                        blurRadius: 4,
                        offset: const Offset(
                          0,
                          4,
                        ),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: item!.color?.withAlpha(70),
                        ),
                        child: Icon(
                          item!.icon,
                          color: item?.color ?? Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item!.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        '${item!.count} ${Translate.of(context).translate('location')}',
                        style: Theme.of(context).textTheme.labelSmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        );

      ///Icon Circle List
      case CategoryViewType.iconCircleList:
        if (item == null) {
          return AppPlaceholder(
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).dividerColor.withAlpha(10),
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: const Offset(
                      0,
                      4,
                    ),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 36,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 12,
                          width: 100,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 12,
                          width: 150,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }

        return InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).dividerColor.withAlpha(10),
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: const Offset(
                    0,
                    4,
                  ),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: item!.color?.withAlpha(70),
                  ),
                  child: Icon(
                    item!.icon,
                    color: item?.color ?? Colors.white,
                    size: 18,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item!.title,
                        style: Theme.of(context).textTheme.titleSmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        '${item!.count} ${Translate.of(context).translate('location')}',
                        style: Theme.of(context).textTheme.labelSmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );

      ///Icon Round List
      case CategoryViewType.iconRoundList:
        if (item == null) {
          return AppPlaceholder(
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).dividerColor.withAlpha(10),
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: const Offset(
                      0,
                      4,
                    ),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 12,
                          width: 100,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 12,
                          width: 150,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }

        return InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).dividerColor.withAlpha(10),
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: const Offset(
                    0,
                    4,
                  ),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 60,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: item!.color?.withAlpha(70),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    item!.icon,
                    color: item?.color ?? Colors.white,
                    size: 32,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item!.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        '${item!.count} ${Translate.of(context).translate('location')}',
                        style: Theme.of(context).textTheme.labelMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );

      ///Icon Shape List
      case CategoryViewType.iconShapeList:
        if (item == null) {
          return AppPlaceholder(
            child: Container(
              height: 130,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).dividerColor.withAlpha(10),
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: const Offset(
                      0,
                      4,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return InkWell(
          onTap: onPressed,
          child: Container(
            height: 130,
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).dividerColor.withAlpha(10),
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: const Offset(
                    0,
                    4,
                  ),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: item!.color?.withAlpha(70),
                  ),
                  child: Icon(
                    item!.icon,
                    color: item?.color ?? Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item!.title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  '${item!.count} ${Translate.of(context).translate('location')}',
                  style: Theme.of(context).textTheme.labelSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              ],
            ),
          ),
        );

      ///Image Circle
      case CategoryViewType.imageCircle:
        if (item == null) {
          return AppPlaceholder(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 56,
                  height: 56,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 12,
                  width: 60,
                  color: Colors.white,
                ),
              ],
            ),
          );
        }

        return InkWell(
          onTap: onPressed,
          child: SizedBox(
            width: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: item!.image?.full ?? '',
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  placeholder: (context, url) {
                    return AppPlaceholder(
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.error),
                    );
                  },
                ),
                const SizedBox(height: 4),
                Text(
                  item!.title,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        );

      ///Image Round
      case CategoryViewType.imageRound:
        if (item == null) {
          return AppPlaceholder(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 60,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 12,
                  width: 60,
                  color: Colors.white,
                ),
              ],
            ),
          );
        }

        return InkWell(
          onTap: onPressed,
          child: SizedBox(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: item!.image?.full ?? '',
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  placeholder: (context, url) {
                    return AppPlaceholder(
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.error),
                    );
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  item!.title,
                  style: Theme.of(context).textTheme.labelLarge,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        );

      ///Image Square
      case CategoryViewType.imageSquare:
        if (item == null) {
          return AppPlaceholder(
            child: Container(
              margin: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: 160,
                    height: 160,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: 80,
                    height: 12,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 120,
                    height: 12,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
        }

        return InkWell(
          onTap: onPressed,
          child: Container(
            margin: const EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: item!.image?.full ?? '',
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  placeholder: (context, url) {
                    return AppPlaceholder(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        width: 160,
                        height: 160,
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: 160,
                      height: 160,
                      child: const Icon(Icons.error),
                    );
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  item!.title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  '${item!.count} ${Translate.of(context).translate('location')}',
                  style: Theme.of(context).textTheme.labelMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              ],
            ),
          ),
        );

      ///Image Landscape
      case CategoryViewType.imageLandscape:
        if (item == null) {
          return AppPlaceholder(
            child: Container(
              margin: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: 220,
                    height: 130,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: 80,
                    height: 12,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 120,
                    height: 12,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
        }

        return InkWell(
          onTap: onPressed,
          child: Container(
            margin: const EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: item!.image?.full ?? '',
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: 220,
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  placeholder: (context, url) {
                    return AppPlaceholder(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        width: 220,
                        height: 130,
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: 220,
                      height: 130,
                      child: const Icon(Icons.error),
                    );
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  item!.title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  '${item!.count} ${Translate.of(context).translate('location')}',
                  style: Theme.of(context).textTheme.labelMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              ],
            ),
          ),
        );

      ///Image Portrait
      case CategoryViewType.imagePortrait:
        if (item == null) {
          return AppPlaceholder(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 300.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    width: constraints.maxWidth,
                    height: constraints.maxWidth * 1.2,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).dividerColor.withAlpha(10),
                          spreadRadius: 4,
                          blurRadius: 4,
                          offset: const Offset(
                            0,
                            4,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        }

        return InkWell(
          onTap: onPressed,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 300.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  margin: const EdgeInsets.all(4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl: item!.image?.full ?? '',
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            width: constraints.maxWidth,
                            height: constraints.maxWidth * 1.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                        placeholder: (context, url) {
                          return AppPlaceholder(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              width: constraints.maxWidth,
                              height: constraints.maxWidth * 1.2,
                            ),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            width: constraints.maxWidth,
                            height: constraints.maxWidth * 1.2,
                            child: const Icon(Icons.error),
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item!.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        '${item!.count} ${Translate.of(context).translate('location')}',
                        style: Theme.of(context).textTheme.labelSmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        );

      ///Image Circle List
      case CategoryViewType.imageCircleList:
        if (item == null) {
          return AppPlaceholder(
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).dividerColor.withAlpha(10),
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: const Offset(
                      0,
                      4,
                    ),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 36,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 12,
                          width: 100,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 12,
                          width: 150,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }

        return InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).dividerColor.withAlpha(10),
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: const Offset(
                    0,
                    4,
                  ),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: item!.image?.full ?? '',
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  placeholder: (context, url) {
                    return AppPlaceholder(
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.error),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item!.title,
                        style: Theme.of(context).textTheme.titleSmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        '${item!.count} ${Translate.of(context).translate('location')}',
                        style: Theme.of(context).textTheme.labelSmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );

      ///Image Round List
      case CategoryViewType.imageRoundList:
        if (item == null) {
          return AppPlaceholder(
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).dividerColor.withAlpha(10),
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: const Offset(
                      0,
                      4,
                    ),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 12,
                          width: 100,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 12,
                          width: 150,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }

        return InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).dividerColor.withAlpha(10),
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: const Offset(
                    0,
                    4,
                  ),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: item!.image?.full ?? '',
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  placeholder: (context, url) {
                    return AppPlaceholder(
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.error),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item!.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        '${item!.count} ${Translate.of(context).translate('location')}',
                        style: Theme.of(context).textTheme.labelMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );

      ///Image Shape List
      case CategoryViewType.imageShapeList:
        if (item == null) {
          return AppPlaceholder(
            child: Container(
              height: 160,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).dividerColor.withAlpha(10),
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: const Offset(
                      0,
                      4,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return InkWell(
          onTap: onPressed,
          child: Container(
            margin: const EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: item!.image?.full ?? '',
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  placeholder: (context, url) {
                    return AppPlaceholder(
                      child: Container(
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                      height: 160,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.error),
                    );
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  item!.title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  '${item!.count} ${Translate.of(context).translate('location')}',
                  style: Theme.of(context).textTheme.labelSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              ],
            ),
          ),
        );

      ///Case Full
      case CategoryViewType.full:
        if (item == null) {
          return AppPlaceholder(
            child: Container(
              height: 120,
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }

        return GestureDetector(
          onTap: onPressed,
          child: SizedBox(
            height: 120,
            child: CachedNetworkImage(
              imageUrl: item!.image?.full ?? '',
              imageBuilder: (context, imageProvider) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 36,
                              height: 36,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: item!.color,
                              ),
                              child: Icon(
                                item!.icon,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    item!.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${item!.count} ${Translate.of(context).translate('location')}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
              placeholder: (context, url) {
                return AppPlaceholder(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
              errorWidget: (context, url, error) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.error),
                );
              },
            ),
          ),
        );

      ///Case View Card large
      case CategoryViewType.card:
        if (item == null) {
          return SizedBox(
            width: 140,
            height: 160,
            child: AppPlaceholder(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          );
        }

        return SizedBox(
          height: 160,
          width: 140,
          child: GestureDetector(
            onTap: onPressed,
            child: Card(
              elevation: 2,
              margin: const EdgeInsets.all(0),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: CachedNetworkImage(
                imageUrl: item!.image?.full ?? '',
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            item!.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                placeholder: (context, url) {
                  return AppPlaceholder(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.error),
                  );
                },
              ),
            ),
          ),
        );
      default:
        return Container();
    }
  }
}
