import 'package:freezed_annotation/freezed_annotation.dart';

part 'topic.g.dart';

@JsonSerializable()
class Topic {
  String? id;
  String? title;
  DateTime? createdAt;

  Topic({this.id, this.title,this.createdAt});

  factory Topic.fromJson(json) => _$TopicFromJson(json);

  Map<String, dynamic> toJson() => _$TopicToJson(this);

  @override
  String toString() {
    print("topicID : $id \n title : $title");
    return super.toString();
  }
}
