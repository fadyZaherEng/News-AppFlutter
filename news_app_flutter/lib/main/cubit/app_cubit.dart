import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app_flutter/main/cubit/states.dart';
import 'package:news_app_flutter/shared/network/remote/shared_helper.dart';

class AppCubit extends Cubit<AppStates>
{
  bool isLight=true;
  Color? modeColor=Colors.grey;
  Color? modeBackgroundColor=Colors.blueAccent;
  AppCubit() : super(AppInitialStates());
  static AppCubit get(BuildContext context)=>BlocProvider.of(context);
  //dark light theme
  void changeMode(){
    isLight=!isLight;
    if(isLight){
      SharedHelper.putBooleanMode(key: 'isLight', mode:true).then((value){
        modeColor=Colors.grey;
        modeBackgroundColor=Colors.blueAccent;
        emit(NewsAppChangeModeStates());
      }).catchError((onError)=>print(onError));
    }
    else
      {
      SharedHelper.putBooleanMode(key: 'isLight', mode: false).then((value){
        modeColor=Colors.white;
        modeBackgroundColor=Colors.indigoAccent;
        emit(NewsAppChangeModeStates());
      }).catchError((onError)=>print(onError));

    }
  }
}