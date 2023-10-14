
import 'package:demo_social_media/models/post_card_model.dart';


abstract class HomeScreenState{
  const HomeScreenState() ;
}

class HomeScreenInitialState extends HomeScreenState{
  const HomeScreenInitialState();
}

class HomeScreenLoadingState extends HomeScreenState{
  const HomeScreenLoadingState();
}

class HomeScreenLoadedState extends HomeScreenState{
  // final UserDetailsModel? userDetailsModel ;
  final List<PostCardModel> postCardList;
  const HomeScreenLoadedState(
     {required this.postCardList}
      ) ;
}