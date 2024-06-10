import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intellichat/constants.dart';
import 'package:intellichat/features/auth/models/user_model/user.dart'
    as UserModel;

import '../../features/chat/presentation/data/models/message_model/message.dart';
import '../../features/chat/presentation/data/models/topic_model/topic.dart';

class CustomFirebase {
  Future<UserModel.User> fetchUserDate(User firebaseUser) async {
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection(kUserCollection)
        .doc(firebaseUser.uid);
    DocumentSnapshot userDoc = await userDocRef.get();
    if (!userDoc.exists) {
      String displayName = firebaseUser.displayName!;
      String email = firebaseUser.email!;
      await userDocRef.set(
        {
          'displayName': displayName,
          'email': email,
        },
      );
      userDoc = await userDocRef.get();
    }
    List<Topic> topics = await getTopicsWithMessages(firebaseUser);
    Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
    UserModel.User user = UserModel.User(
        id: firebaseUser.uid,
        displayName: userData?['displayName'] ?? 'Anonymous',
        email: userData?['email'] ?? '',
        topics: topics);
    return user;
  }

  Future<UserModel.User> loginUsingEmailAndPassword({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? firebaseUser = userCredential.user;
    UserModel.User user = await fetchUserDate(firebaseUser!);
    return user;
  }

  Future<UserModel.User> loginUsingGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User? firebaseUser = userCredential.user;
    UserModel.User user = await fetchUserDate(firebaseUser!);
    return user;
  }

  Future<UserCredential> signupUsingEmailAndPassword({
    required String email,
    required String password,
    required String username,
  }) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User user = userCredential.user!;
    await user.updateDisplayName(username);
    await user.reload();
    user = FirebaseAuth.instance.currentUser!;
    fetchUserDate(user);
    return userCredential;
  }

  Future<List<Topic>> getTopicsWithMessages(User firebaseUser) async {
    QuerySnapshot topicsSnapshot = await FirebaseFirestore.instance
        .collection(kUserCollection)
        .doc(firebaseUser.uid)
        .collection(kTopicsCollection)
        .get();

    List<Topic> topics = await Future.wait(topicsSnapshot.docs.map(
      (doc) async {
        String topicId = doc.id;
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        List<Message> messages =
            await getMessagesForTopic(firebaseUser.uid, topicId);

        return Topic(
          id: topicId,
          title: data['title'] as String?,
          messages: messages,
        );
      },
    ).toList());

    return topics;
  }

  Future<List<Message>> getMessagesForTopic(
      String userId, String topicId) async {
    QuerySnapshot messagesSnapshot = await FirebaseFirestore.instance
        .collection(kUserCollection)
        .doc(userId)
        .collection(kTopicsCollection)
        .doc(topicId)
        .collection(kMessagesCollection)
        .get();
    List<Message> messages = messagesSnapshot.docs.map(
      (doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Message.fromJson(data);
      },
    ).toList();
    return messages;
  }

  Future<void> resetPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
