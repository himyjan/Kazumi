import 'package:hive/hive.dart';
import 'package:kazumi/utils/utils.dart';
import 'package:kazumi/modules/bangumi/bangumi_tag.dart';

part 'bangumi_item.g.dart';

@HiveType(typeId: 0)
class BangumiItem {
  @HiveField(0)
  int id;
  // String? url;
  @HiveField(1)
  int type;
  @HiveField(2)
  String name;
  @HiveField(3)
  String nameCn;
  @HiveField(4)
  String summary;
  @HiveField(5)
  String airDate;
  @HiveField(6)
  int airWeekday;
  // Rating? rating;
  @HiveField(7)
  int rank;
  @HiveField(8)
  Map<String, String> images;
  // Map<String, int>? collection;
  @HiveField(9, defaultValue: [])
  List<BangumiTag> tags;

  BangumiItem({
    required this.id,
    // this.url,
    required this.type,
    required this.name,
    required this.nameCn,
    required this.summary,
    required this.airDate,
    required this.airWeekday,
    // this.rating,
    required this.rank,
    required this.images,
    // this.collection,
    required this.tags
  });

  factory BangumiItem.fromJson(Map<String, dynamic> json) {
    List list = json['tags'] ?? [];
    List<BangumiTag> tagList =
    list.map((i) => BangumiTag.fromJson(i)).toList();
    return BangumiItem(
      id: json['id'],
      type: json['type'] ?? 2,
      name: json['name'] ?? '',
      nameCn: (json['name_cn'] ?? '') == '' ? (((json['nameCN'] ?? '') == '') ? json['name'] : json['nameCN']) : json['name_cn'],
      summary: json['summary'] ?? '',
      airDate: json['air_date'] ?? json ['date'] ?? '',
      airWeekday: json['air_weekday'] ?? Utils.dateStringToWeekday(json['date'] ?? '2000-11-11'),
      // rating: Rating.fromJson(json['rating']),
      rank: json['rating']['rank'] ?? json['rank'] ?? 0,
      images: Map<String, String>.from(json['images'] ?? {
          "large": json['image'],
          "common": "",
          "medium": "",
          "small": "",
          "grid": ""
        },),
      tags: tagList
      // collection: Map<String, int>.from(json['collection']),
    );
  }
}
