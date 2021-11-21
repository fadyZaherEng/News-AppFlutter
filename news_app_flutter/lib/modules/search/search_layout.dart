import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/layout/news_app_home/cubit/cubit.dart';
import 'package:news_app_flutter/layout/news_app_home/cubit/states.dart';
import 'package:news_app_flutter/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
var control=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsAppStates>(
      listener: (context,state){},
      builder:(context,state){
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: control,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                  ),
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                       color: Colors.blueAccent,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                    ),
                    labelStyle:const TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold
                    ) ,
                    prefixIcon: const Icon(Icons.search,color: Colors.blue,),
                    labelText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (String val){
                    NewsCubit.get(context).getSearch(val);
                  },
                ),
              ),
              ConditionalBuilder(
                condition:state is!NewsAppLoadingInitialStates,
                builder:(context)=> Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context,index)=>buildListViewItemNews(
                          news: NewsCubit.get(context).search[index],context: context),
                      separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                      itemCount: NewsCubit.get(context).search.length),
                ),
                  fallback: (context)=>const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                    ),
                  )
              ),
            ],
          ),
        );
      },
    );
  }
}
