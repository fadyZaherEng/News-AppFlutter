import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/layout/news_app_home/cubit/states.dart';
import 'package:news_app_flutter/modules/business/business_layout.dart';
import 'package:news_app_flutter/modules/science/science_layout.dart';
import 'package:news_app_flutter/modules/setting/setting_layout.dart';
import 'package:news_app_flutter/modules/sports/sports_layout.dart';
import 'package:news_app_flutter/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsAppStates> {
  List<dynamic> business = [];
  List<dynamic> science = [];
  List<dynamic> sports = [];
  List<dynamic> search = [];

  NewsCubit() : super(NewsAppInitialStates());

  static NewsCubit get(BuildContext context) => BlocProvider.of(context);

  int idx = 0;
  List<Widget> listScreens = [
    BusinessScreen(),
    ScienceScreen(),
    SportsScreen(),
  ];
  List<BottomNavigationBarItem> navList = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: 'Business'),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
  ];

  void BottomNavChange(int index) {
    idx = index;
    emit(NewsAppBottomNavChangeStates());
  }

  void getBusiness() {
    emit(NewsAppLoadingInitialStates());
    dioHelper.getData(completePath: 'top-headLines', queryParameters: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
    }).then((value) {
      business = value.data['articles'];
      print(business[0]);

      emit(NewsAppGetDataSuccessStates());
    }).catchError((error) {
      emit(NewsAppGetDataErrorStates(error.toString()));
    });
  }

  void getScience() {
    emit(NewsAppLoadingInitialStates());
    dioHelper.getData(completePath: 'top-headLines', queryParameters: {
      'country': 'eg',
      'category': 'science',
      'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
    }).then((value) {
      science = value.data['articles'];
      print(science[0]);

      emit(NewsAppGetDataSuccessStates());
    }).catchError((error) {
      emit(NewsAppGetDataErrorStates(error.toString()));
    });
  }

  void getSports() {
    emit(NewsAppLoadingInitialStates());
    dioHelper.getData(completePath: 'top-headLines', queryParameters: {
      'country': 'eg',
      'category': 'sports',
      'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
    }).then((value) {
      sports = value.data['articles'];
      print(sports[0]);

      emit(NewsAppGetDataSuccessStates());
    }).catchError((error) {
      emit(NewsAppGetDataErrorStates(error.toString()));
    });
  }

  void getSearch(String val) {
    search=[];
    emit(NewsAppLoadingInitialStates());
    dioHelper.getData(completePath: 'everything', queryParameters: {
      'q': val,
      'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
    }).then((value) {
      search = value.data['articles'];
      emit(NewsAppGetDataSuccessStates());
    }).catchError((error) {
      emit(NewsAppGetDataErrorStates(error.toString()));
    });
  }
}
