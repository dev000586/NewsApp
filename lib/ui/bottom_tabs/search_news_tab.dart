import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/helper/constants/string_constants.dart';

import '../../bloc/event_status.dart';
import '../../bloc/news_bloc/news_bloc.dart';
import '../../helper/constants/color_constants.dart';
import '../../helper/utils/utils.dart';
import '../../models/response/news_model/Article.dart';
import '../common_widgets/loader.dart';
import '../common_widgets/news_tile.dart';

class SearchNewsTab extends StatefulWidget {
  const SearchNewsTab({Key? key}) : super(key: key);

  @override
  State<SearchNewsTab> createState() => _SearchNewsTabState();
}

class _SearchNewsTabState extends State<SearchNewsTab> {
  void triggerNewsEvent(NewsEvent event) {
    context.read<NewsBloc>().add(event);
  }

  @override
  void initState() {
    super.initState();
  }

  void _listener(BuildContext context, NewsState state) {
    StateStatus eventStatus = state.searchNewsStatus;
    if(eventStatus is StateLoaded){
      // showSnackBar(context, eventStatus.successMessage, Colors.green);
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
          StateStatus eventStatus = state.searchNewsStatus;
          List<Article> allArticles = [];
          if(state.searchNewsData != null){
            allArticles = state.searchNewsData!.articles ?? [];
          }
          return Stack(
            children: [
              Column(
                children: [
                  Container(
                    width:  width,
                    height: 50,
                    color: ColorConst.green.withOpacity(0.9),
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorConst.white,
                                borderRadius: const BorderRadius.all(Radius.circular(10))
                            ),
                            width: width - 20,
                            height: 38,
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: width-60,
                                  height: 40,
                                  child: TextFormField(
                                    autofocus: true,
                                    decoration: InputDecoration(
                                      hintText: StringConst.search,
                                      hintStyle: TextStyle(
                                        color: ColorConst.black.withOpacity(0.34),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (text){
                                      if(text == ""){
                                        triggerNewsEvent(NewsInitialEvent());
                                      }else{
                                        Future.delayed(const Duration(milliseconds: 500),(){
                                          triggerNewsEvent(SearchNewsEvent(searchText: text));
                                        });
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  allArticles.isNotEmpty ?
                  Expanded(
                    child: ListView.builder(
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
                    ),
                  )
                      :Container(
                    margin: const EdgeInsets.only(top: 30),
                    alignment: Alignment.center,
                    child: Text(StringConst.noRecord),
                  ),
                ],
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
