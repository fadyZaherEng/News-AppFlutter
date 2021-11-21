import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/layout/news_app_home/cubit/cubit.dart';
import 'package:news_app_flutter/layout/news_app_home/cubit/states.dart';
import 'package:news_app_flutter/shared/components/components.dart';

class ScienceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsAppStates>(
      listener: (context, state) {
        if (state is NewsAppGetDataErrorStates) {
          print('Errorrrrrrrr: ${state.error}');
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: state is! NewsAppLoadingInitialStates,
            builder: (context) {
              return ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildListViewItemNews(
                      news: NewsCubit.get(context).science[index],
                      context: context),
                  separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                  itemCount: NewsCubit.get(context).science.length);
            },
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                  ),
                ));
      },
    );
  }
}
