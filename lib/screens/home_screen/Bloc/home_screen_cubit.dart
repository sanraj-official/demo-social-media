
import 'package:demo_social_media/models/post_card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../States/home_screen_states.dart';

class HomeScreenCubit extends Cubit<HomeScreenState>{
  HomeScreenCubit() : super(const HomeScreenInitialState()) ;
  String imageLink = 'https://source.unsplash.com/800x450/?number';
  final String imageHtmlContent = "<img src='https://source.unsplash.com/800x450/?invitation_card,wedding'>";
  final String textHtmlContent = "<h1>Hello, Flutter!</h1><p>This is an image: </p>";
  List<PostCardModel> postCardList =[];

  void fetchHomeScreen(){
    emit(const HomeScreenLoadingState());
    for(int i=0;i<40;i++)
      {
        postCardList.add(
            PostCardModel(
                htmlContent: "$textHtmlContent This is post number : ${i+1}",
                imageLink: "$imageLink /$i",
                selfPost: true,
                userId: "qq@qq.qq",
                postId:"",
            ),
        );
      }

    emit(HomeScreenLoadedState(
      postCardList: postCardList,
    ));
  }

}