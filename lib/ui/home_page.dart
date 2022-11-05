import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news/bloc/news_bloc/news_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/helper/constants/color_constants.dart';
import 'package:news/helper/constants/images_constants.dart';
import 'package:news/helper/constants/string_constants.dart';
import 'package:news/ui/bottom_tabs/breaking_news_tab.dart';
import 'package:news/ui/bottom_tabs/search_news_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  triggerNewsEvent(NewsEvent event) {
    context.read<NewsBloc>().add(event);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: _selectedIndex == 0 ? Text(StringConst.breakingNews) : Text(StringConst.searchNews),
      ),
      body: _bottomTabList.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(ImageConst.news, color: _selectedIndex == 0 ? ColorConst.green : ColorConst.grey, height: 20),
            label: StringConst.breakingNews,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(ImageConst.searchNews, color: _selectedIndex == 1 ? ColorConst.green : ColorConst.grey, height: 20),
            label: StringConst.searchNews,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorConst.green,
        onTap: (index){
          setState((){
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  static const List<Widget> _bottomTabList = <Widget>[
    BreakingNewsTab(),
    SearchNewsTab()
  ];
}
