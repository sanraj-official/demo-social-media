class PostCardModel {
  final String imageLink;
  final String htmlContent;
  final int likes;
  final bool liked;
  final bool selfPost;
  final String userId;
  final String postId;

  PostCardModel({
    this.imageLink="",
    this.htmlContent="",
    this.likes=0,
    this.liked=false,
    required this.selfPost,
    required this.userId,
    required this.postId,
  });

  factory PostCardModel.fromJson(Map<String, dynamic> json) {
    return PostCardModel(
      imageLink: json['imageLink'],
      htmlContent: json['htmlContent'],
      likes: json['likes'],
      liked: json['liked'],
      selfPost: json['selfPost'],
      userId: json['userId'],
      postId: json['postId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageLink': imageLink,
      'htmlContent': htmlContent,
      'likes': likes,
      'liked': liked,
      'selfPost': selfPost,
      'userId': userId,
      'postId': postId,
    };
  }

  PostCardModel copyWith({
    String? imageLink,
    String? htmlContent,
    int? likes,
    bool? liked,
    bool? selfPost,
    String? userId,
    String? postId,
  }) {
    return PostCardModel(
      imageLink: imageLink ?? this.imageLink,
      htmlContent: htmlContent ?? this.htmlContent,
      likes: likes ?? this.likes,
      liked: liked ?? this.liked,
      selfPost: selfPost ?? this.selfPost,
      userId: userId ?? this.userId,
      postId: postId ?? this.postId,
    );
  }

  factory PostCardModel.fromMap(Map<String, dynamic> map) {
    return PostCardModel(
      imageLink: map['imageLink'],
      htmlContent: map['htmlContent'],
      likes: map['likes'],
      liked: map['liked'],
      selfPost: map['selfPost'],
      userId: map['userId'],
      postId: map['postId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageLink': imageLink,
      'htmlContent': htmlContent,
      'likes': likes,
      'liked': liked,
      'selfPost': selfPost,
      'userId': userId,
      'postId': postId,
    };
  }

  @override
  String toString() {
    return 'PostCardModel(imageLink: $imageLink, htmlContent: $htmlContent, likes: $likes, liked: $liked, selfPost: $selfPost, userId: $userId, postId: $postId)';
  }
}
