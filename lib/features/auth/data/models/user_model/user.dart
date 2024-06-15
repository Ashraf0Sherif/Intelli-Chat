import '../../../../chat/data/models/topic_model/topic.dart';

class User {
  String? id, displayName, email, avatarUrl;
  List<Topic>? topics;

  User({this.id, this.displayName, this.email, this.topics, this.avatarUrl});
}
