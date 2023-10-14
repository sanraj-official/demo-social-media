import 'package:demo_social_media/Utils/common_elements.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Utils/custom_decoration.dart';
import 'Bloc/home_screen_cubit.dart';
import 'States/home_screen_states.dart';
import 'post_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState() {
    final homeCubit = context.read<HomeScreenCubit>();
    homeCubit.fetchHomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CommonElements.customAppBar(
          title: 'Demo Media',
          actions: [
            CommonElements().popUpMenu([],context)
          ]
        ),
        body: _createBody(context),
      ),
    );
  }

  Widget _createBody(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, HomeScreenState>(
        builder: (ctx, state) {
          if (state is HomeScreenInitialState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomeScreenLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomeScreenLoadedState) {
            return body(state);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }, listener: (context, state) {
      if (state is HomeScreenInitialState) {}
      if (state is HomeScreenLoadingState) {}
      if (state is HomeScreenLoadedState) {}
    });
  }

  Widget body(HomeScreenLoadedState loadedState){
    return Container(
      decoration: CustomDecoration.homeBackground(),
      padding: const EdgeInsets.all(8.0),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: ListView.builder(
        itemCount: loadedState.postCardList.length,
        itemBuilder :  (BuildContext context, int index) {
          return PostCard(
              postCardModel: loadedState.postCardList[index],
            index: index,
          );
        }
      ),
    );
  }
}
