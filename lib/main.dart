import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/injection_container.dart' as di;
import 'package:news/ui/home_page.dart';

import 'bloc/bloc_ovserver.dart';
import 'bloc/bloc_provider.dart';

globalInitializer() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
}
void main() async {
  await globalInitializer();

  BlocOverrides.runZoned(() =>
      runApp(const MyApp()),
      blocObserver: CustomBlocOvserver()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomBlocProvider(
      child: MaterialApp(
          title: 'News App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
        home: const HomePage(),
      ),
    );
  }
}
