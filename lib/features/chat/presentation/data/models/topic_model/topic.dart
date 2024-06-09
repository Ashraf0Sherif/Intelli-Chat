import 'package:freezed_annotation/freezed_annotation.dart';

import '../message_model/message.dart';

part 'topic.g.dart';

@JsonSerializable()
class Topic {
  String? id;
  String? title;
  List<Message>? messages;

  Topic({this.id, this.messages, this.title});

  factory Topic.fromJson(json) => _$TopicFromJson(json);

  Map<String, dynamic> toJson() => _$TopicToJson(this);

  @override
  String toString() {
    print("topicID : $id \n title : $title \n $messages");
    return super.toString();
  }
}
