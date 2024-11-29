import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/screens/home/home_category_item.dart';
import 'package:listar_flutter_pro/screens/home/home_header_basic.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final _homeCubit = HomeCubit();
  StreamSubscription? _submitSubscription;
  StreamSubscription? _reviewSubscription;

  @override
  void initState() {
    super.initState();
    _homeCubit.onLoad(reload: true);
    _submitSubscription = AppBloc.submitCubit.stream.listen((state) {
      if (state is Submitted) {
        _homeCubit.onLoad();
      }
    });
    _reviewSubscription = AppBloc.reviewCubit.stream.listen((state) {
      if (state is ReviewSuccess && state.id != null) {
        _homeCubit.onLoad();
      }
    });
  }

  @override
  void dispose() {
    _homeCubit.close();
    _submitSubscription?.cancel();
    _reviewSubscription?.cancel();
    super.dispose();
  }

  ///Refresh
  Future<void> _onRefresh() async {
    await _homeCubit.onLoad();
  }

  ///On search
  void _onSearch() {
    Navigator.pushNamed(context, Routes.searchHistory);
  }

  ///On scan
  void _onScan() async {
    final result = await Navigator.pushNamed(context, Routes.scanQR);
    if (result != null) {
      final deeplink = DeepLinkModel.fromString(result as String);
      if (deeplink.target.isNotEmpty) {
        if (!mounted) return;
        Navigator.pushNamed(
          context,
          Routes.deepLink,
          arguments: deeplink,
        );
      }
    }
  }

  ///On select category
  void _onCategory(CategoryModel? item) {
    if (item == null) {
      Navigator.pushNamed(context, Routes.category);
      return;
    }
    if (item.hasChild) {
      Navigator.pushNamed(context, Routes.category, arguments: item);
    } else {
      Navigator.pushNamed(context, Routes.listProduct, arguments: item);
    }
  }

  ///On navigate product detail
  void _onProductDetail(ProductModel item) {
    Navigator.pushNamed(context, Routes.productDetail, arguments: item);
  }

  ///On handle submit listing
  void _onSubmit() async {
    if (AppBloc.userCubit.state == null) {
      final result = await Navigator.pushNamed(
        context,
        Routes.signIn,
        arguments: Routes.submit,
      );
      if (result == null) return;
    }
    if (!mounted) return;
    Navigator.pushNamed(context, Routes.submit);
  }

  ///Build category UI
  Widget _buildCategory(List<CategoryModel>? category) {
    ///Loading
    Widget content = Wrap(
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: List.generate(8, (index) => index).map(
        (item) {
          return const HomeCategoryItem();
        },
      ).toList(),
    );

    if (category != null) {
      final more = CategoryModel.fromJson({
        "term_id": -1,
        "name": Translate.of(context).translate("more"),
        "icon": "fas fa-ellipsis",
        "color": "#ff8a65",
      });

      content = Wrap(
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: [
          ...category.take(7).toList().map(
            (item) {
              return HomeCategoryItem(
                item: item,
                onPressed: _onCategory,
              );
            },
          ),
          HomeCategoryItem(
            item: more,
            onPressed: _onCategory,
          )
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.all(8),
      child: content,
    );
  }

  ///Build popular UI
  Widget _buildLocation(List<CategoryModel>? location) {
    ///Loading
    Widget content = ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: AppCategoryItem(
            type: CategoryViewType.card,
          ),
        );
      },
      itemCount: List.generate(8, (index) => index).length,
    );

    if (location != null) {
      content = ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        itemBuilder: (context, index) {
          final item = location[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: AppCategoryItem(
              item: item,
              type: CategoryViewType.card,
              onPressed: () {
                _onCategory(item);
              },
            ),
          );
        },
        itemCount: location.length,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Translate.of(context).translate(
                  'popular_location',
                ),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                Translate.of(context).translate(
                  'let_find_interesting',
                ),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        Container(
          height: 180,
          padding: const EdgeInsets.only(top: 4),
          child: content,
        ),
      ],
    );
  }

  ///Build list recent
  Widget _buildRecent(List<ProductModel>? recent) {
    ///Loading
    Widget content = ListView.builder(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: AppProductItem(type: ProductViewType.small),
        );
      },
      itemCount: 8,
    );

    if (recent != null) {
      content = ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = recent[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AppProductItem(
              onPressed: () {
                _onProductDetail(item);
              },
              item: item,
              type: ProductViewType.small,
            ),
          );
        },
        itemCount: recent.length,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                Translate.of(context).translate('recent_location'),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                Translate.of(context).translate(
                  'what_happen',
                ),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 8),
          content,
        ],
      ),
    );
  }

  ///Build submit button
  Widget? _buildSubmit() {
    if (Application.setting.enableSubmit) {
      return FloatingActionButton(
        mini: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: _onSubmit,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _homeCubit,
      child: Scaffold(
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            List<String>? banner;
            List<CategoryModel>? category;
            List<CategoryModel>? location;
            List<ProductModel>? recent;

            if (state is HomeSuccess) {
              banner = state.banner;
              category = state.category;
              location = state.location;
              recent = state.recent;
            }

            return CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: <Widget>[
                SliverPersistentHeader(
                  delegate: HomeHeaderBasic(
                    expandedHeight: MediaQuery.of(context).size.height * 0.3,
                    banners: banner,
                    onSearch: _onSearch,
                    onScan: _onScan,
                  ),
                  pinned: true,
                ),
                CupertinoSliverRefreshControl(
                  onRefresh: _onRefresh,
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    SafeArea(
                      top: false,
                      bottom: false,
                      child: Column(
                        children: <Widget>[
                          _buildCategory(category),
                          _buildLocation(location),
                          const SizedBox(height: 8),
                          _buildRecent(recent),
                          const SizedBox(height: 28),
                        ],
                      ),
                    )
                  ]),
                )
              ],
            );
          },
        ),
        floatingActionButton: _buildSubmit(),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      ),
    );
  }
}
