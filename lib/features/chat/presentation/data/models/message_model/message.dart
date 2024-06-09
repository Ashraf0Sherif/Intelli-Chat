import 'package:freezed_annotation/freezed_annotation.dart';
part 'message.g.dart';
@JsonSerializable()
class Message {
  String? message;

  Message({this.message});

  factory Message.fromJson(json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
  @override
  String toString() {
    print(message);
    return super.toString();
  }
}
