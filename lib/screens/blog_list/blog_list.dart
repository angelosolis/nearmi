import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';

class BlogList extends StatefulWidget {
  const BlogList({Key? key}) : super(key: key);

  @override
  createState() {
    return _BlogListState();
  }
}

class _BlogListState extends State<BlogList> {
  final _blogListCubit = BlogListCubit();
  final _inputController = TextEditingController();

  CategoryModel? _category;
  SortModel? _sort;

  @override
  void initState() {
    super.initState();
    _blogListCubit.onLoad(
      category: _category,
      sort: _sort,
      keyword: _inputController.text,
    );
  }

  @override
  void dispose() {
    _blogListCubit.close();
    _inputController.dispose();
    super.dispose();
  }

  ///On Change Sort
  void _onChangeSort() async {
    final result = await showModalBottomSheet<SortModel?>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AppBottomPicker(
          picker: PickerModel(
            selected: [_sort],
            data: Application.setting.sort,
          ),
        );
      },
    );
    if (result != null) {
      _sort = result;
      _blogListCubit.onLoad(
        category: _category,
        sort: _sort,
        keyword: _inputController.text,
      );
    }
  }

  ///On Change Sort
  void _onChangeCategory(List<CategoryModel> options) async {
    final result = await showModalBottomSheet<CategoryModel?>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: IntrinsicHeight(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 16,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 8,
                          children: Application.setting.category.map((item) {
                            final selected = item.id == _category?.id;
                            return FilterChip(
                              selected: selected,
                              label: Text(item.title),
                              onSelected: (check) {
                                Navigator.pop(context, item);
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    if (result != null) {
      _category = result;
      _blogListCubit.onLoad(
        category: _category,
        sort: _sort,
        keyword: _inputController.text,
      );
    }
  }

  ///On Detail
  void _onDetail(BlogModel item) {
    Navigator.pushNamed(
      context,
      Routes.blogDetail,
      arguments: item,
    );
  }

  Widget _buildSticky(BlogModel? item) {
    if (item != null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: InkWell(
          onTap: () {
            _onDetail(item);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: item.image.thumb,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    height: 200,
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      height: 200,
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.error),
                  );
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 8),
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: item.author.image,
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
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
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return Container(
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(Icons.error),
                              );
                            },
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.author.name,
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                DateFormat.yMMMMd().format(
                                  item.createDate,
                                ),
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          )
                        ],
                      ),
                      Text(
                        item.category
                            .map((item) {
                              return item.title;
                            })
                            .toList()
                            .join(", "),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _blogListCubit,
      child: BlocBuilder<BlogListCubit, BlogListState>(
        builder: (context, state) {
          Widget dotCategory = Container();
          Widget dotSort = Container();
          Widget content = ListView.separated(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
            itemBuilder: (context, index) {
              return const AppBlogItem(
                type: BlogViewType.list,
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 12);
            },
            itemCount: 15,
          );

          if (_category != null) {
            dotCategory = Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.error,
              ),
            );
          }
          if (_sort != null) {
            dotSort = Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.error,
              ),
            );
          }
          if (state is BlogListSuccess) {
            if (state.list.isEmpty) {
              content = Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(Icons.sentiment_satisfied),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        Translate.of(context).translate(
                          'can_not_found_data',
                        ),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              content = ListView(
                children: [
                  const SizedBox(height: 12),
                  _buildSticky(state.sticky),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      Translate.of(context).translate('latest_new'),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    itemBuilder: (context, index) {
                      final item = state.list[index];
                      return AppBlogItem(
                        item: item,
                        type: BlogViewType.list,
                        onPressed: () {
                          _onDetail(item);
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 12);
                    },
                    itemCount: state.list.length,
                  )
                ],
              );
            }
          }

          return Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8, top: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Theme.of(context).cardColor,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Theme.of(context).dividerColor.withAlpha(20),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(
                                0,
                                2,
                              ),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _inputController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: Translate.of(context).translate('search'),
                            border: InputBorder.none,
                          ),
                          onChanged: (text) {
                            _blogListCubit.onLoad(
                              category: _category,
                              sort: _sort,
                              keyword: text,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Row(
                      children: [
                        Stack(
                          children: [
                            IconButton(
                              enableFeedback: true,
                              onPressed: () {
                                if (state is BlogListSuccess) {
                                  _onChangeCategory(state.categories);
                                }
                              },
                              icon: const Icon(Icons.category_outlined),
                            ),
                            Positioned(
                              right: 8,
                              top: 8,
                              child: dotCategory,
                            )
                          ],
                        ),
                        Stack(
                          children: [
                            IconButton(
                              enableFeedback: true,
                              onPressed: _onChangeSort,
                              icon: const Icon(Icons.swap_vert),
                            ),
                            Positioned(
                              right: 8,
                              top: 8,
                              child: dotSort,
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            body: RefreshIndicator(
              child: content,
              onRefresh: () async {
                await _blogListCubit.onLoad(
                  category: _category,
                  sort: _sort,
                  keyword: _inputController.text,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
