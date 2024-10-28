import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_myself/NewsApp/cubit/cubit.dart';
import 'package:news_app_myself/NewsApp/cubit/states.dart';
import 'package:news_app_myself/NewsApp/shared/compontents/components.dart';
import 'package:news_app_myself/NewsApp/shared/network/remote/dio_helper.dart';
import 'package:news_app_myself/NewsApp/shared/network/remote/shared_pref_helper.dart';

import 'NewsApp/layout/news_layout.dart';
import 'NewsApp/shared/network/remote/dio_helper.dart';
import 'NewsApp/shared/network/remote/shared_pref_helper.dart';
import 'bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await SharedPrefHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..getBusinessData(value: "Business"),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme(),
            darkTheme: darkTheme(),
            themeMode: NewsCubit.get(context).appMode,
            home: const NewsLayout(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
