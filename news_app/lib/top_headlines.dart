import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/component.dart';

import 'main_cubit.dart';
import 'main_states.dart';

class TopHeadlines extends StatelessWidget {
  const TopHeadlines({super.key});

  @override
  Widget build(BuildContext context) {
    internetConection(context);
    return BlocConsumer<MainCubit, MainState>(
      bloc: MainCubit.get(context)..getTopHeadlines(),
      listener: (context, state) {},
      builder: (context, state) {
        MainCubit ref = MainCubit.get(context);
        return articleBuilder(ref.topHeadlines, context);
      },
    );
  }
}
