import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/bloc/news_bloc/news_bloc.dart';
import 'package:news/helper/constants/color_constants.dart';
import 'package:news/helper/constants/images_constants.dart';
import 'package:news/helper/constants/string_constants.dart';
import 'package:news/models/response/news_model/Article.dart';
import 'package:news/ui/common_widgets/loader.dart';
import 'package:news/ui/common_widgets/news_tile.dart';

import '../../bloc/event_status.dart';
import '../../helper/utils/utils.dart';

class BreakingNewsTab extends StatefulWidget {
  const BreakingNewsTab({Key? key}) : super(key: key);

  @override
  State<BreakingNewsTab> createState() => _BreakingNewsTabState();
}

class _BreakingNewsTabState extends State<BreakingNewsTab> {

  void triggerNewsEvent(NewsEvent event) {
    context.read<NewsBloc>().add(event);
  }

  @override
  void initState() {
    triggerNewsEvent(BreakingNewsEvent());
    super.initState();
  }

  void _listener(BuildContext context, NewsState state) {
    StateStatus eventStatus = state.breakingNewsStatus;
    if(eventStatus is StateLoaded){
      showSnackBar(context, eventStatus.successMessage, Colors.green);
    }
    if(eventStatus is StateFailed){
      showSnackBar(context, eventStatus.errorMessage, Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<NewsBloc, NewsState>(
      listener: _listener,
      builder: (context, state){
        StateStatus eventStatus = state.breakingNewsStatus;
        List<Article> allArticles = [];
        if(state.breakingNewsData != null){
          allArticles = state.breakingNewsData!.articles ?? [];
        }
        return Stack(
          children: [
            allArticles.isNotEmpty ?
            ListView.builder(
              itemCount: allArticles.length,
                itemBuilder: (context, index){
                  Article article = allArticles[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        const SizedBox(height: 10,),
                        NewsTile(
                          image: article.urlToImage ?? "",
                          sourceName: article.source!.name ?? "Unknown",
                          published: article.publishedAt ?? "Unavailable",
                          title: article.title ?? "Title",
                          description: article.description ?? "",
                          width: width
                        ),
                        const SizedBox(height: 5,),
                        allArticles.length-1 != index ? Divider(color: ColorConst.grey, height: 1, thickness: 1,)
                        :const SizedBox(),
                      ],
                    ),
                  );
                }
            )
            :Container(
              alignment: Alignment.center,
              child: Text(StringConst.noRecord),
            ),
            eventStatus is StateLoading ?
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Loader(),
            ): const SizedBox()
          ],
        );
      });
  }


}
