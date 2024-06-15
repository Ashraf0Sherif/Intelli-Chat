import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intellichat/constants.dart';
import 'package:intellichat/features/auth/data/models/user_model/user.dart'
    as UserModel;

import '../../features/chat/data/models/topic_model/topic.dart';

class CustomFirebase {
  Future<UserCredential> loginUsingEmailAndPassword({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    addFirstTopic(userCredential.user!);
    return userCredential;
  }

  Future<UserCredential> loginUsingGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    addFirstTopic(userCredential.user!);
    return userCredential;
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
    return userCredential;
  }

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
      topics: topics,
      avatarUrl: userData?['avatarUrl'],
    );
    return user;
  }

  Future<List<Topic>> getTopicsWithMessages(User firebaseUser) async {
    QuerySnapshot topicsSnapshot = await FirebaseFirestore.instance
        .collection(kUserCollection)
        .doc(firebaseUser.uid)
        .collection(kTopicsCollection)
        .get();

    List<Topic> topics = await Future.wait(
      topicsSnapshot.docs.map(
        (doc) async {
          String topicId = doc.id;
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          Timestamp? createdTimeStamp = data['createdAt'] as Timestamp?;
          DateTime createdAt =
              createdTimeStamp?.toDate() ?? DateTime(1970, 1, 1);
          return Topic(
            id: topicId,
            title: data['title'] as String?,
            createdAt: createdAt,
          );
        },
      ).toList(),
    );
    topics.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    return topics;
  }

  Future<void> createTopic(
      {required User firebaseUser, required String title}) async {
    await FirebaseFirestore.instance
        .collection(kUserCollection)
        .doc(firebaseUser.uid)
        .collection(kTopicsCollection)
        .add(
      {
        'title': title,
        'createdAt': DateTime.now(),
      },
    );
  }

  Future<void> removeTopic(
      {required User firebaseUser, required String topicID}) async {
    await FirebaseFirestore.instance
        .collection(kUserCollection)
        .doc(firebaseUser.uid)
        .collection(kTopicsCollection)
        .doc(topicID)
        .delete();
  }

  Future<void> renameTopic(
      {required User firebaseUser,
      required String topicID,
      required String newTitle}) async {
    await FirebaseFirestore.instance
        .collection(kUserCollection)
        .doc(firebaseUser.uid)
        .collection(kTopicsCollection)
        .doc(topicID)
        .update(
      {
        'title': newTitle,
      },
    );
  }

  Future<void> sendMessage(
      User firebaseUser, String topicID, ChatMessage message) async {
    String? imageURL;
    if (message.medias != null && message.medias!.isNotEmpty) {
      Reference storageRef = FirebaseStorage.instance.ref().child(
          'users/${firebaseUser.uid}/topics/$topicID/${DateTime.now().millisecondsSinceEpoch}.jpg');

      UploadTask uploadTask =
          storageRef.putFile(File(message.medias!.first.url));
      TaskSnapshot taskSnapshot = await uploadTask;
      imageURL = await taskSnapshot.ref.getDownloadURL();
    }
    await FirebaseFirestore.instance
        .collection(kUserCollection)
        .doc(firebaseUser.uid)
        .collection(kTopicsCollection)
        .doc(topicID)
        .collection(kMessagesCollection)
        .add(
      {
        'message': message.text,
        'createdAt': message.createdAt,
        'userID': message.user.id,
        'imageURL': imageURL
      },
    );
  }

  Future<void> addFirstTopic(User firebaseUser) async {
    QuerySnapshot topicsSnapshot = await FirebaseFirestore.instance
        .collection(kUserCollection)
        .doc(firebaseUser.uid)
        .collection(kTopicsCollection)
        .get();
    if (topicsSnapshot.docs.isEmpty) {
      await FirebaseFirestore.instance
          .collection(kUserCollection)
          .doc(firebaseUser.uid)
          .collection(kTopicsCollection)
          .add(
        {
          "title": "Your first topic",
          'createdAt': DateTime.now(),
        },
      );
    }
  }

  Future<String> changeUserAvatar(
      {required User firebaseUser, required File image}) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('user_avatars/${firebaseUser.uid}.jpg');
    final uploadTask = storageRef.putFile(image);
    final snapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .update({'avatarUrl': downloadUrl});
    return downloadUrl;
  }

  Future<void> resetPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
