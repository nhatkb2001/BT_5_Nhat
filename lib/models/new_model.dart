class NewModel {
  late int storyId;
  late String title;
  late String summary;
  late String modifiedAt;
  late String image;

  NewModel(
      {required this.storyId,
      required this.title,
      required this.summary,
      required this.modifiedAt,
      required this.image});

  NewModel.fromJson(Map<String, dynamic> json) {
    storyId = json['storyId'];
    title = json['title'];
    summary = json['summary'];
    modifiedAt = json['modifiedAt'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storyId'] = this.storyId;
    data['title'] = this.title;
    data['summary'] = this.summary;
    data['modifiedAt'] = this.modifiedAt;
    data['image'] = this.image;
    return data;
  }
}
