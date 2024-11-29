import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/screens/home/home_header_basic.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';

import 'home_header_minimal.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() {
    return _HomeWidgetState();
  }
}

class _HomeWidgetState extends State<HomeWidget> {
  final _homeCubit = HomeCubit();
  StreamSubscription? _submitSubscription;
  StreamSubscription? _reviewSubscription;

  CategoryModel? _location;

  @override
  void initState() {
    super.initState();
    _homeCubit.onLoad(reload: true, widget: true, location: _location);
    _submitSubscription = AppBloc.submitCubit.stream.listen((state) {
      if (state is Submitted) {
        _homeCubit.onLoad(location: _location);
      }
    });
    _reviewSubscription = AppBloc.reviewCubit.stream.listen((state) {
      if (state is ReviewSuccess && state.id != null) {
        _homeCubit.onLoad(location: _location, widget: true);
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
    await _homeCubit.onLoad(location: _location, widget: true);
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

  ///On handle submit listing
  void onAddListing() async {
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

  ///On Change Category
  void _onChangeCategory(List<CategoryModel> options) async {
    final result = await showModalBottomSheet<CategoryModel?>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AppBottomPicker(
          picker: PickerModel(
            selected: [_location],
            data: options,
          ),
        );
      },
    );
    if (result != null) {
      setState(() {
        _location = result;
      });
      _homeCubit.onLoad(location: _location, widget: true, reload: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _homeCubit,
      child: Scaffold(
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            List<CategoryModel> options = [];
            Widget header = SliverPersistentHeader(
              delegate: HomeHeaderMinimal(
                onSelectCategory: () {
                  _onChangeCategory(options);
                },
                onSearch: _onSearch,
                onScan: _onScan,
                onAddListing: onAddListing,
                category: _location,
                maxHeight: 118 + MediaQuery.of(context).padding.top,
                minHeight: 64 + MediaQuery.of(context).padding.top,
              ),
              pinned: true,
              floating: true,
            );
            Widget content = ListView.separated(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return const AppProductItem(type: ProductViewType.small);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 12);
              },
              itemCount: 8,
            );

            if (state is HomeSuccess) {
              if (state.headerType?.type == HeaderType.basic) {
                header = SliverPersistentHeader(
                  delegate: HomeHeaderBasic(
                    expandedHeight: MediaQuery.of(context).size.height * 0.3,
                    banners: state.headerType?.data,
                    onSearch: _onSearch,
                    onScan: _onScan,
                  ),
                  pinned: true,
                );
              }
              options = state.options;
              content = ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 12),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return state.widgets[index].build(context);
                },
                itemCount: state.widgets.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 12);
                },
              );
            }

            return BlocBuilder<UserCubit, UserModel?>(
              builder: (context, user) {
                return CustomScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  slivers: <Widget>[
                    header,
                    CupertinoSliverRefreshControl(
                      onRefresh: _onRefresh,
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([content]),
                    )
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
