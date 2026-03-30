import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttr/features/auth/models/user_model.dart';
import 'package:fluttr/shared/services/firestore_service.dart';

ValueNotifier<AuthService> authService = ValueNotifier(AuthService());
ValueNotifier<UserModel?> currentUser = ValueNotifier(null);

class AuthService {
  final firebaseAuth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn.instance;
  final firestoreService = FirestoreService();

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<UserModel?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    if (userCredential.user == null) {
      return null;
    }

    // TODO: Update user online status
    UserModel? user = await firestoreService.getUser(userCredential.user!.uid);

    currentUser.value = user;

    return user;
  }

  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await firebaseAuth.signInWithCredential(
        credential,
      );

      if (userCredential.user == null) {
        throw Exception('Failed to sign in');
      }

      UserModel? user = await firestoreService.getUser(
        userCredential.user!.uid,
      );

      if (user == null) {
        user = UserModel(
          uid: userCredential.user!.uid,
          email: userCredential.user!.email!,
          displayName: userCredential.user!.displayName,
          photoUrl: userCredential.user!.photoURL,
          isOnline: true,
          lastSeen: DateTime.now(),
          createdAt: DateTime.now(),
        );

        await firestoreService.createUser(user);
      }

      currentUser.value = user;

      return user;
    } catch (e) {
      debugPrint("Sign-in error: $e");
      rethrow;
    }
  }

  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user == null) {
        throw Exception('Failed to create user');
      }

      UserModel user = UserModel(
        uid: userCredential.user!.uid,
        email: email,
        displayName: userCredential.user!.displayName,
        photoUrl: userCredential.user!.photoURL,
        isOnline: true,
        lastSeen: DateTime.now(),
        createdAt: DateTime.now(),
      );

      await firestoreService.createUser(user);

      currentUser.value = user;
      return user;
    } catch (e) {
      debugPrint("Sign-up error: $e");
      rethrow;
    }
  }

  Future<void> signOut() async {
    // TODO: Update user online status
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
    currentUser.value = null;
  }
}
