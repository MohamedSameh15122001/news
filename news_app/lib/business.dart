import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/component.dart';

import 'main_cubit.dart';
import 'main_states.dart';

class Business extends StatelessWidget {
  const Business({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      bloc: MainCubit.get(context)..getCategory('business'),
      listener: (context, state) {},
      builder: (context, state) {
        MainCubit ref = MainCubit.get(context);
        return articleBuilder(ref.business, context);
      },
    );
  }
}
