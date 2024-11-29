import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';

class BlogDetail extends StatefulWidget {
  final BlogModel blog;
  const BlogDetail({Key? key, required this.blog}) : super(key: key);

  @override
  State<BlogDetail> createState() {
    return _BlogDetailState();
  }
}

class _BlogDetailState extends State<BlogDetail> {
  final _blogDetailCubit = BlogDetailCubit();

  @override
  void initState() {
    _blogDetailCubit.onLoad(widget.blog.id);
    super.initState();
  }

  @override
  void dispose() {
    _blogDetailCubit.close();
    super.dispose();
  }

  ///On navigate feedback
  void _onFeedback() async {
    if (AppBloc.userCubit.state == null) {
      final result = await Navigator.pushNamed(
        context,
        Routes.signIn,
        arguments: Routes.blogDetail,
      );
      if (result != Routes.blogDetail) return;
    }
    if (!mounted) return;
    Navigator.pushNamed(
      context,
      Routes.writeReview,
      arguments: widget.blog,
    );
  }

  ///On navigate review
  void _onReview() async {
    Navigator.pushNamed(
      context,
      Routes.review,
      arguments: widget.blog,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('blog'),
        ),
        actions: [
          IconButton(
            enableFeedback: true,
            onPressed: () {
              _onFeedback();
            },
            icon: const Icon(Icons.add_comment_outlined),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => _blogDetailCubit,
        child: BlocBuilder<BlogDetailCubit, BlogDetailState>(
          builder: (context, state) {
            Widget content = AppPlaceholder(
              child: Column(
                children: [
                  Container(height: 12, color: Colors.white),
                  const SizedBox(height: 12),
                  Container(height: 12, color: Colors.white),
                  const SizedBox(height: 12),
                  Container(height: 12, color: Colors.white),
                  const SizedBox(height: 12),
                  Container(height: 12, color: Colors.white),
                  const SizedBox(height: 12),
                  Container(height: 12, color: Colors.white),
                  const SizedBox(height: 12),
                  Container(height: 12, color: Colors.white),
                  const SizedBox(height: 12),
                  Container(height: 12, color: Colors.white),
                  const SizedBox(height: 12),
                  Container(height: 12, color: Colors.white),
                  const SizedBox(height: 12),
                ],
              ),
            );
            if (state is BlogDetailSuccess) {
              content = HtmlWidget(state.blog.description);
            }
            return RefreshIndicator(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                children: [
                  Column(
                    children: [
                      Text(
                        widget.blog.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: widget.blog.author.image,
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
                                          borderRadius:
                                              BorderRadius.circular(16),
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
                                Text(
                                  widget.blog.author.name,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  DateFormat.yMMMMd().format(
                                    widget.blog.createDate,
                                  ),
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: _onReview,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.comment_outlined,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  widget.blog.numComments,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 12),
                      CachedNetworkImage(
                        imageUrl: widget.blog.image.thumb,
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
                              height: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white),
                            ),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return Container(
                            height: 200,
                            color: Colors.white,
                            child: const Icon(Icons.error),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      content,
                      const SizedBox(height: 12),
                    ],
                  )
                ],
              ),
              onRefresh: () async {
                _blogDetailCubit.onLoad(widget.blog.id);
              },
            );
          },
        ),
      ),
    );
  }
}
