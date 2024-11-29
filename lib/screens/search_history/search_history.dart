import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';

class SearchHistory extends StatefulWidget {
  const SearchHistory({Key? key}) : super(key: key);

  @override
  State<SearchHistory> createState() {
    return _SearchHistoryState();
  }
}

class _SearchHistoryState extends State<SearchHistory> {
  final _searchCubit = SearchCubit();
  final _inputController = TextEditingController();
  final _focusNode = FocusNode();
  bool _searching = false;
  List<ProductModel> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  @override
  void dispose() {
    _searchCubit.close();
    _inputController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  ///Load history
  void _loadHistory() async {
    List<String>? historyString = Preferences.getStringList(
      Preferences.search,
    );
    if (historyString != null) {
      setState(() {
        _history = historyString.map((e) {
          return ProductModel.fromJson(
            jsonDecode(e),
          );
        }).toList();
      });
    }
  }

  ///onShow search
  void _onSearch() async {
    setState(() {
      _searching = !_searching;
    });

    if (_searching) {
      _focusNode.requestFocus();
    } else {
      _inputController.text = '';
      _searchCubit.onSearch(_inputController.text);
    }
  }

  void _onClear({ProductModel? item}) async {
    if (item == null) {
      await Preferences.setStringList(Preferences.search, []);
    } else {
      List<String>? historyString = Preferences.getStringList(
        Preferences.search,
      );
      if (historyString != null) {
        historyString.remove(jsonEncode(item.toJson()));
        await Preferences.setStringList(
          Preferences.search,
          historyString,
        );
      }
    }
    _loadHistory();
  }

  void _onAddHistory(ProductModel item) async {
    final exist = _history.where((element) => element.id == item.id);
    if (exist.isEmpty) {
      List<String>? historyString = Preferences.getStringList(
        Preferences.search,
      );
      historyString?.add(jsonEncode(item.toJson()));
      await Preferences.setStringList(
        Preferences.search,
        historyString ?? [jsonEncode(item.toJson())],
      );
    }
    _loadHistory();
  }

  ///On navigate product detail
  void _onProductDetail(ProductModel item) async {
    Navigator.pushNamed(context, Routes.productDetail, arguments: item);
    _onAddHistory(item);
  }

  ///Build appbar
  PreferredSizeWidget _buildAppBar() {
    if (_searching) {
      return AppBar(
        leading: IconButton(
          enableFeedback: true,
          icon: const Icon(Icons.close),
          onPressed: _onSearch,
        ),
        title: TextField(
          controller: _inputController,
          focusNode: _focusNode,
          decoration: const InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
          onChanged: _searchCubit.onSearch,
        ),
      );
    }
    return AppBar(
      centerTitle: true,
      title: Text(Translate.of(context).translate('search_title')),
      actions: <Widget>[
        IconButton(
          enableFeedback: true,
          icon: const Icon(Icons.search),
          onPressed: _onSearch,
        )
      ],
    );
  }

  ///Build content search
  Widget buildContent() {
    if (_searching) {
      return BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SearchSuccess) {
            if (state.list.isEmpty) {
              return Center(
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
            }

            return ListView.builder(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 12,
              ),
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                final item = state.list[index];
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
            );
          }
          return Container();
        },
      );
    }
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  Translate.of(context).translate('search_history'),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    _onClear();
                  },
                  child: Text(
                    Translate.of(context).translate('clear'),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                ),
              ],
            ),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 8,
              children: _history.map((item) {
                return InputChip(
                  onPressed: () {
                    _onProductDetail(item);
                  },
                  label: Text(item.title),
                  onDeleted: () {
                    _onClear(item: item);
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _searchCubit,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SafeArea(
          child: buildContent(),
        ),
      ),
    );
  }
}
