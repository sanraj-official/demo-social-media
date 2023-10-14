import 'package:demo_social_media/models/post_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../Utils/constants.dart';

class PostCard extends StatefulWidget {

  final int collapseLimit ;
  final int? index;
  final PostCardModel postCardModel;

  const PostCard({super.key,required this.postCardModel, this.collapseLimit=25,this.index });

  @override
  PostCardState createState() => PostCardState();
}

class PostCardState extends State<PostCard> {
  bool expandHtml = false;
  bool? likeStatus ;
  int? likeCount;
  String? htmlElement;

  @override
  void initState() {
    htmlElement = "${widget.postCardModel.htmlContent.replaceAll(htmlRegex, '').substring(0,widget.collapseLimit)}....";
    likeCount = widget.postCardModel.likes;
    likeStatus = widget.postCardModel.liked;
  //  htmlElement = "${htmlElement.substring(0,20)}...." ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("post card number ${widget.index} build");
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: widget.postCardModel.imageLink.isNotEmpty,
              child: FadeInImage(
                imageErrorBuilder: (context, error, stackTrace) {
                  // Handle network image loading error here
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Image.asset('lib/assets/404_banner.png'),
                  );
                },
                placeholderFit: BoxFit.fitHeight,
                fit: BoxFit.fill,
                fadeInDuration:const Duration(seconds: 1),
                image: NetworkImage(widget.postCardModel.imageLink),
                placeholder:const AssetImage('lib/assets/loading2.gif'),
              ),
            ),
            GestureDetector(
              onTap: () {
                // expands and collapse html element
                setState(() {
                  expandHtml = !expandHtml;
                });
                if(expandHtml){
                  htmlElement = widget.postCardModel.htmlContent;
                }
                else{
                  htmlElement = "${widget.postCardModel.htmlContent.replaceAll(htmlRegex, '').substring(0,widget.collapseLimit)}....";
                }
              },
              child: Visibility(
                visible: widget.postCardModel.htmlContent.isNotEmpty, // Toggle visibility based on the flag.
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HtmlWidget(
                    htmlElement??"",
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(likeCount.toString()),
                IconButton(
                    onPressed: (){
                      setState(() {
                        likeStatus = !likeStatus!;
                        if(likeStatus!){
                          likeCount =  likeCount! + 1;
                        }
                        else{
                          likeCount =  likeCount! - 1;
                        }
                      });
                    },
                    icon: Icon(likeStatus!?Icons.thumb_up:Icons.thumb_up_alt_outlined)
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
