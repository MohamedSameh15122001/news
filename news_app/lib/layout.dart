import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/main_cubit.dart';
import 'package:news_app/main_states.dart';
import 'package:news_app/search.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.cyan,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return BlocConsumer<MainCubit, MainState>(
      bloc: MainCubit.get(context),
      listener: (context, state) {},
      builder: (context, state) {
        MainCubit ref = MainCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.cyan[100],
          appBar: AppBar(
            backgroundColor: Colors.cyan,
            elevation: 0,
            title: const Text(
              'News App',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Search();
                    },
                  ));
                },
              ),
              // IconButton(
              //   icon: const Icon(
              //     Icons.brightness_4_outlined,
              //   ),
              //   onPressed: () {
              //     // AppCubit.get(context).changeAppMode();
              //   },
              // ),
            ],
          ),
          body: ref.screens[ref.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.white,
            currentIndex: ref.currentIndex,
            onTap: (index) {
              ref.changeBottomNavBar(index);
            },
            items: ref.bottomItems,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.cyan,
            unselectedItemColor: Colors.black38,
          ),
        );
      },
    );
  }
}
