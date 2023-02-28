import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/component.dart';
import 'package:news_app/main_cubit.dart';
import 'package:news_app/main_states.dart';

class Search extends StatelessWidget {
  var searchController = TextEditingController();

  Search({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        MainCubit ref = MainCubit.get(context);

        return Scaffold(
          backgroundColor: Colors.cyan[100],
          // appBar: AppBar(),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      ref.getSearch(value);
                    },
                    decoration: const InputDecoration(
                      label: Text('search'),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                state is LoadingGetSearchState
                    ? const Center(
                        child: RefreshProgressIndicator(
                        color: Colors.cyan,
                      ))
                    : Expanded(
                        child: articleBuilder(
                          ref.search,
                          context,
                          isSearch: true,
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
