import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/layout/news_app_home/cubit/cubit.dart';
import 'package:news_app_flutter/layout/news_app_home/cubit/states.dart';
import 'package:news_app_flutter/main/cubit/app_cubit.dart';
import 'package:news_app_flutter/modules/search/search_layout.dart';
import 'package:news_app_flutter/shared/network/remote/dio_helper.dart';

class homeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'News App',
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (Context) => SearchScreen()));
                },
                icon: const Icon(
                  Icons.search,
                  size: 30,
                ),
              ),
              IconButton(
                  onPressed: () {
                    AppCubit.get(context).changeMode();
                  },
                  icon: CircleAvatar(
                      radius: 15,
                      backgroundColor:
                          AppCubit.get(context).modeBackgroundColor,
                      child: Icon(
                        Icons.brightness_2_sharp,
                        color: AppCubit.get(context).modeColor,
                        size: 15,
                      ))),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              NewsCubit.get(context).BottomNavChange(index);
            },
            currentIndex: NewsCubit.get(context).idx,
            items: NewsCubit.get(context).navList,
          ),
          body: NewsCubit.get(context).listScreens[NewsCubit.get(context).idx],
        );
      },
    );
  }
}
