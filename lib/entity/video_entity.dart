/// @author: xiao
/// created on: 2025/7/15 11:49
/// description:

class VideoEntity {
  VideoEntity({
    this.id,
    this.size,
    this.timelength,
    this.url,
    this.fileName,
    this.pic,
    required this.savePath,
  });

  factory VideoEntity.fromJson(Map<String, dynamic> json) {
    return VideoEntity(
      id: json['id'],
      size: json['size'],
      timelength: json['timelength'],
      url: json['url'],
      fileName: json['fileName'],
      pic: json['pic'],
      savePath: json['savePath'],
    );
  }

  int? id;
  String? fileName;
  String? pic;
  String? url;
  int? size;
  int? timelength;
  late String savePath;
}
