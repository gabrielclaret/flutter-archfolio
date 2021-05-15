class Content {
  final int id;
  final int postId;
  final bool isUrl;
  final String content;
  final int dispositionOrder;

  Content({
    this.id,
    this.postId,
    this.isUrl,
    this.content,
    this.dispositionOrder,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
        id: json['id'],
        postId: json['post_id'],
        isUrl: json['is_url'],
        content: json['content'],
        dispositionOrder: json['disposition_order']);
  }
}
