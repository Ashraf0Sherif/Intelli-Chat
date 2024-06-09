import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intellichat/features/auth/models/user_model/user.dart'
    as UserModel;

class CustomFirebase {
  Future<UserModel.User> addToFirestore(User firebaseUser) async {
    DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid);
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

    Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
    UserModel.User user = UserModel.User(
      id: firebaseUser.uid,
      displayName: userData?['displayName'] ?? 'Anonymous',
      email: userData?['email'] ?? '',
    );
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
    UserModel.User user = await addToFirestore(firebaseUser!);
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
    UserModel.User user = await addToFirestore(firebaseUser!);
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
    addToFirestore(user);
    return userCredential;
  }

  Future<void> resetPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
