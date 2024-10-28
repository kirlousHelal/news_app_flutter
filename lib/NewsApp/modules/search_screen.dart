import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_myself/NewsApp/cubit/states.dart';

import '../cubit/cubit.dart';
import '../shared/compontents/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<dynamic> list = NewsCubit.get(context).search;
        list = list.where((element) => element['urlToImage'] != null).toList();
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(
                    color: NewsCubit.get(context).appMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                  controller: NewsCubit.get(context).searchController,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    NewsCubit.get(context).getSearchData(value: value);
                  },
                  decoration: const InputDecoration(
                      label: Text("Search"),
                      prefixIcon: Icon(Icons.search),
                      hintStyle: TextStyle(color: Colors.white)),
                ),
                Expanded(
                  child: articleBuilder(
                      list: list,
                      function: () {
                        return NewsCubit.get(context).getSearchData(
                            value:
                                NewsCubit.get(context).searchController.text);
                      }),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
