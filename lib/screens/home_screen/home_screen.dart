import 'package:demo_social_media/Utils/common_elements.dart';
import 'package:flutter/material.dart';
import '../../Utils/custom_decoration.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String imageLink = 'https://source.unsplash.com/800x450/?number';
  final String imageHtmlContent = "<img src='https://source.unsplash.com/800x450/?invitation_card,wedding'>";
  final String textHtmlContent = "<h1>Hello, Flutter!</h1><p>This is an image: </p>";

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
        body: body(),
      ),
    );
  }

  Widget body(){
    return Container(
      decoration: CustomDecoration.homeBackground(),
      padding: const EdgeInsets.all(8.0),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: ListView.builder(
        itemCount: 40,
        itemBuilder :  (BuildContext context, int index) {
          return CommonElements().postCard(htmlElement: "$textHtmlContent  <b>This is post number : $index</b>",imageLink: "$imageLink,$index");
        }
      ),
    );
  }
}
