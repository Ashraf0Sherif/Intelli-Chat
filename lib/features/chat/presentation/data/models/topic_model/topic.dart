import 'package:freezed_annotation/freezed_annotation.dart';

import '../message_model/message.dart';

part 'topic.g.dart';

@JsonSerializable()
class Topic {
  String? id;
  List<Message>? messages;

  Topic({this.id, this.messages});

  factory Topic.fromJson(json) => _$TopicFromJson(json);

  Map<String, dynamic> toJson() => _$TopicToJson(this);
}
