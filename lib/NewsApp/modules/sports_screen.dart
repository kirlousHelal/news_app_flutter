import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_myself/NewsApp/cubit/cubit.dart';
import 'package:news_app_myself/NewsApp/cubit/states.dart';
import 'package:news_app_myself/NewsApp/shared/compontents/components.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<dynamic> list = NewsCubit.get(context).sports;
        list = list.where((element) => element['urlToImage'] != null).toList();
        print(list.length);
        return articleBuilder(
          list: list,
          function: () {
            return NewsCubit.get(context).getSportsData(value: "Sports");
          },
        );
      },
    );
  }
}
