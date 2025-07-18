/// @author: xiao
/// created on: 2025/7/15 11:49
/// description:

class VideoEntity {
  VideoEntity({
    this.id,
    this.size = 0,
    this.timelength,
    this.url,
    this.fileName,
    this.pic,
    this.dSize = 0,
    this.progress = 0,
    required this.basePath,
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
      basePath: json['basePath'],
    );
  }

  int? id;
  String? fileName;
  String? pic;
  String? url;
  int size;
  int? timelength;
  int dSize;
  double progress;
  late String savePath;
  late String basePath;
}
