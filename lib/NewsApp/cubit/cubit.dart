import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_myself/NewsApp/cubit/states.dart';
import 'package:news_app_myself/NewsApp/modules/business_screen.dart';
import 'package:news_app_myself/NewsApp/modules/science_screen.dart';
import 'package:news_app_myself/NewsApp/shared/network/remote/dio_helper.dart';
import 'package:news_app_myself/NewsApp/shared/network/remote/shared_pref_helper.dart';

import '../modules/sports_screen.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  TextEditingController searchController = TextEditingController();
  ThemeMode appMode = SharedPrefHelper.getBool(key: "isDark") ?? false
      ? ThemeMode.dark
      : ThemeMode.light;

  int currentIndex = 0;
  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business_center), label: "Business"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.sports_basketball), label: "Sports"),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: "Science"),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    if (index == 1 && sports.isEmpty) getSportsData(value: "Sports");
    if (index == 2 && science.isEmpty) getScienceData(value: "Science");
    emit(ChangeBottomNavBarState());
  }

  void changeAppMode() {
    if (appMode == ThemeMode.light) {
      appMode = ThemeMode.dark;
      SharedPrefHelper.setBool(key: "isDark", value: true);
    } else {
      appMode = ThemeMode.light;
      SharedPrefHelper.setBool(key: "isDark", value: false);
    }
    emit(ChangeAppModeState());
  }

  List<dynamic> business = [];

  Future<void> getBusinessData({required String value}) async {
    emit(GetBusinessDataLoadingSate());
    DioHelper.getData(url: "v2/top-headlines", map: {
      "country": "us",
      "category": value,
      "apiKey": "7bcc1559a5b74d6cbb996877d0e80df0",
    }).then(
      (value) {
        business = value.data['articles'];
        emit(GetBusinessDataSuccessSate());
      },
    ).catchError((error) {
      print(error.toString());
      emit(GetBusinessDataErrorSate());
    });
  }

  List<dynamic> sports = [];

  Future<void> getSportsData({required String value}) async {
    emit(GetSportsDataLoadingSate());
    DioHelper.getData(url: "v2/top-headlines", map: {
      "country": "us",
      "category": value,
      "apiKey": "7bcc1559a5b74d6cbb996877d0e80df0",
    }).then(
      (value) {
        sports = value.data['articles'];
        emit(GetSportsDataSuccessSate());
      },
    ).catchError((error) {
      print(error.toString());
      emit(GetSportsDataErrorSate());
    });
  }

  List<dynamic> science = [];

  Future<void> getScienceData({required String value}) async {
    emit(GetScienceDataLoadingSate());
    DioHelper.getData(url: "v2/top-headlines", map: {
      "country": "us",
      "category": value,
      "apiKey": "7bcc1559a5b74d6cbb996877d0e80df0",
    }).then(
      (value) {
        science = value.data['articles'];
        emit(GetScienceDataSuccessSate());
      },
    ).catchError((error) {
      print(error.toString());
      emit(GetScienceDataErrorSate());
    });
  }

  List<dynamic> search = [];

  Future<void> getSearchData({required String value}) async {
    emit(GetSearchDataLoadingSate());
    DioHelper.getData(url: "v2/everything", map: {
      "q": value,
      "apiKey": "7bcc1559a5b74d6cbb996877d0e80df0",
    }).then(
      (value) {
        search = value.data['articles'];
        emit(GetSearchDataSuccessSate());
      },
    ).catchError((error) {
      print(error.toString());
      emit(GetSearchDataErrorSate());
    });
  }
}
