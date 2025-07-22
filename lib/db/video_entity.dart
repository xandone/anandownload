import 'package:hive/hive.dart';

part 'video_entity.g.dart';

/// @author: xiao
/// created on: 2025/7/15 11:49
/// description:

@HiveType(typeId: 1)
class VideoEntity {
  VideoEntity({
    this.id,
    this.size = 0,
    this.timelength,
    this.url,
    this.fileName,
    this.pic,
    this.pSize = 0,
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

  @HiveField(0)
  String? id;
  @HiveField(1)
  String? fileName;
  @HiveField(2)
  String? pic;
  @HiveField(3)
  String? url;
  @HiveField(4)
  int size;
  @HiveField(5)
  int? timelength;
  @HiveField(6)
  int pSize;
  @HiveField(7)
  double progress;
  @HiveField(8)
  late String savePath;
  @HiveField(9)
  late String basePath;
}
