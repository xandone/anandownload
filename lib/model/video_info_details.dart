/// @author: xiao
/// created on: 2025/7/16 16:40
/// description:

class VideoInfoDetails {
  VideoInfoDetails({this.size, this.url});

  factory VideoInfoDetails.fromJson(Map<String, dynamic> json) {
    return VideoInfoDetails(
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
