/// @author: xiao
/// created on: 2025/7/15 9:41
/// description:

class VideoInfoModel {
  VideoInfoModel({
    required this.bvid,
    required this.aid,
    required this.cid,
    required this.title,
    required this.pic,
    required this.pubdate,
  });

  factory VideoInfoModel.fromJson(Map<String, dynamic> json) {
    return VideoInfoModel(
      bvid: json['bvid'],
      aid: json['aid'],
      cid: json['cid'],
      title: json['title'],
      pic: json['pic'],
      pubdate: json['pubdate'],
    );
  }

  String bvid;
  int aid;
  int cid;
  String title;
  String pic;
  int pubdate;
}
