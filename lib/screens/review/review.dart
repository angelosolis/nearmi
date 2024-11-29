import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';

class Review extends StatefulWidget {
  final dynamic item;

  const Review({Key? key, required this.item}) : super(key: key);

  @override
  State<Review> createState() {
    return _ReviewState();
  }
}

class _ReviewState extends State<Review> {
  @override
  void initState() {
    super.initState();
    AppBloc.reviewCubit.onLoad(widget.item.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///On refresh
  Future<void> _onRefresh() async {
    await AppBloc.reviewCubit.onLoad(widget.item.id);
  }

  ///On navigate write review
  void _onWriteReview() async {
    if (AppBloc.userCubit.state == null) {
      final result = await Navigator.pushNamed(
        context,
        Routes.signIn,
        arguments: Routes.writeReview,
      );
      if (result != Routes.writeReview) {
        return;
      }
    }
    if (!mounted) return;
    Navigator.pushNamed(
      context,
      Routes.writeReview,
      arguments: widget.item,
    );
  }

  ///On Preview Profile
  void _onProfile(UserModel user) {
    Navigator.pushNamed(context, Routes.profile, arguments: user);
  }

  ///Build Rate
  Widget _buildRate(RateModel? rate) {
    if (widget.item is ProductModel) {
      return Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(left: 4, right: 4, top: 12, bottom: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).dividerColor.withOpacity(
                    .05,
                  ),
              spreadRadius: 4,
              blurRadius: 4,
              offset: const Offset(
                0,
                2,
              ), // changes position of shadow
            ),
          ],
        ),
        child: AppRating(rate: rate),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('review'),
        ),
        actions: [
          AppButton(
            Translate.of(context).translate('write'),
            onPressed: _onWriteReview,
            type: ButtonType.text,
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<ReviewCubit, ReviewState>(
          builder: (context, state) {
            RateModel? rate;

            ///Loading
            Widget content = Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView.separated(
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return const AppCommentItem();
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 12);
                  },
                ),
              ),
            );

            ///Success
            if (state is ReviewSuccess) {
              rate = state.rate;

              ///Empty
              if (state.list.isEmpty) {
                content = Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.sentiment_satisfied),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          Translate.of(context).translate('review_not_found'),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                content = Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView.separated(
                      itemCount: state.list.length,
                      itemBuilder: (context, index) {
                        final item = state.list[index];
                        return AppCommentItem(
                          item: item,
                          onPressUser: () {
                            _onProfile(item.user);
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 8);
                      },
                    ),
                  ),
                );
              }
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  _buildRate(rate),
                  Expanded(child: content),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
