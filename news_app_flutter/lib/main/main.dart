import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app_flutter/layout/news_app_home/cubit/cubit.dart';
import 'package:news_app_flutter/layout/news_app_home/home_layout.dart';
import 'package:news_app_flutter/main/cubit/app_cubit.dart';
import 'package:news_app_flutter/main/cubit/states.dart';
import 'package:news_app_flutter/shared/network/remote/dio_helper.dart';
import 'package:news_app_flutter/shared/network/remote/shared_helper.dart';
import 'package:sizer/sizer.dart';

import '../models/bloc_observer.dart';

void main() async{


  WidgetsFlutterBinding.ensureInitialized();//dy 3shan tnfz kol el fok el men el 2awel if main b2a asunc
  await SharedHelper.init();
  dioHelper.init();
  Bloc.observer = SimpleBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // bool? mode;
  //
  // MyApp(this.mode);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder:(context,orientation,deviceType)
    => MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (context) => NewsCubit()
      ..getBusiness()
      ..getScience()
      ..getSports(),),
        BlocProvider(
       create: (context) => AppCubit()),
      ],
       child: BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {
            },
            builder: (context, state) {
              if(SharedHelper.getBooleanMode(key: 'isLight')!=null){
                AppCubit.get(context).isLight=SharedHelper.getBooleanMode(key: 'isLight')!;
                if(AppCubit.get(context).isLight==false){
                  AppCubit.get(context).modeColor=Colors.white;
                  AppCubit.get(context).modeBackgroundColor=Colors.indigoAccent;
                }
              }
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                    scaffoldBackgroundColor: Colors.white,
                    appBarTheme: const AppBarTheme(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      titleTextStyle: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark,
                      ),
                      iconTheme: IconThemeData(
                        color: Colors.blueAccent,
                      ),
                      actionsIconTheme: IconThemeData(
                        color: Colors.blueAccent,
                      ),
                    ),
                    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                        elevation: 20.0,
                        type: BottomNavigationBarType.fixed,
                        selectedItemColor: Colors.blueAccent),
                    floatingActionButtonTheme: const FloatingActionButtonThemeData(),
                    textTheme: const TextTheme(
                      bodyText1: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    )),
                darkTheme: ThemeData(
                  scaffoldBackgroundColor: HexColor('000028'),
                  appBarTheme:  AppBarTheme(
                    backgroundColor: HexColor('00028'),
                    elevation: 0,
                    titleTextStyle: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('000028'),
                      statusBarIconBrightness: Brightness.light,
                    ),
                    iconTheme: const IconThemeData(
                      color: Colors.blueAccent,
                    ),
                    actionsIconTheme: const IconThemeData(
                      color: Colors.blueAccent,
                    ),
                  ),
                  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
                    elevation: 20.0,
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.blueAccent,
                    backgroundColor:HexColor('000028'),
                    unselectedItemColor: Colors.white,
                  ),
                  floatingActionButtonTheme: const FloatingActionButtonThemeData(),
                  textTheme: const TextTheme(
                    bodyText1: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                themeMode: AppCubit.get(context).isLight
                    ? ThemeMode.light
                    : ThemeMode.dark,
                home: Directionality(
                    textDirection: TextDirection.ltr, child: homeScreen()),
              );
            },
          )),
    );
  }
}
