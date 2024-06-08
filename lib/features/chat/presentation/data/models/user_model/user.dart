import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String? id, displayName;

  User({this.id, this.displayName});

  factory User.fromJson(json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}