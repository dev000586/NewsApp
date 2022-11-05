import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/injection_container.dart' as di;

import 'news_bloc/news_bloc.dart';

class CustomBlocProvider extends StatelessWidget {
  final Widget child;
  const CustomBlocProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers:[
          BlocProvider<NewsBloc>(create: (context)=> di.serviceLocator()),
        ],
        child: child
    );
  }
}
