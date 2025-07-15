/// @author: xiao
/// created on: 2025/7/15 11:49
/// description:

class VideoInfoEntity {
  VideoInfoEntity({this.size, this.url});

  factory VideoInfoEntity.fromJson(Map<String, dynamic> json) {
    return VideoInfoEntity(
      size: json['size'],
      url: json['url'],
    );
  }

  int? size;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['size'] = size;
    map['url'] = url;
    return map;
  }
}
