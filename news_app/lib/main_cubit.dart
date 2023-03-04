import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/business.dart';
import 'package:news_app/main_states.dart';
import 'package:news_app/science.dart';
import 'package:news_app/sports.dart';
import 'package:news_app/top_headlines.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  static MainCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.all_inbox,
      ),
      label: '   Top Headlines',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports_soccer_rounded,
      ),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
  ];

  List<Widget> screens = [
    const TopHeadlines(),
    const Sports(),
    const Science(),
    const Business(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    // if (index == 1) getSports();
    // if (index == 2) getScience();
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  List<dynamic> science = [];
  List<dynamic> sports = [];

  void getCategory(categoryName) async {
    emit(LoadingGetCategoryState());

    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=eg&category=$categoryName&apiKey=4bc7ca621e7c43409730ec07701c4b2e'));
    if (response.statusCode == 200) {
      if (categoryName == 'business') {
        business = jsonDecode(response.body)['articles'];
      } else if (categoryName == 'science') {
        science = jsonDecode(response.body)['articles'];
      } else {
        sports = jsonDecode(response.body)['articles'];
      }

      emit(SuccessGetCategoryState());
    } else {
      emit(ErrorGetCategoryState());
      throw Exception('Failed to load data');
    }
  }

  List<dynamic> topHeadlines = [];
  void getTopHeadlines() async {
    emit(LoadingGetTopHeadlinesState());
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=eg&apiKey=4bc7ca621e7c43409730ec07701c4b2e'));
    if (response.statusCode == 200) {
      topHeadlines = jsonDecode(response.body)['articles'];

      emit(SuccessGetTopHeadlinesState());
    } else {
      emit(ErrorGetTopHeadlinesState());
      throw Exception('Failed to load data');
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) async {
    emit(LoadingGetSearchState());

    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=$value&apiKey=4bc7ca621e7c43409730ec07701c4b2e'));
    if (response.statusCode == 200) {
      search = jsonDecode(response.body)['articles'];
      emit(SuccessGetSearchState());
    } else {
      emit(ErrorGetSearchState());
      throw Exception('Failed to load data');
    }
  }
}
