import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:karaoke_manage/features/auth/domain/user.dart';

import '../../../core/utils/string_extension.dart';

class AuthRepository{
  final _auth = FirebaseAuth.instance;
  get auth => _auth;
  final _db = FirebaseFirestore.instance;
  get db => _db;

  Future<AppUser> signInWithEmailAndPassword(String email, String password) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = userCredential.user!.uid;
    final userDoc = await _db.collection('users').doc(uid).get();
    if (!userDoc.exists) {
      throw Exception('User data not found in Firestore');
    }
    return AppUser.fromJson(uid, userDoc.data()!);
  }

  Future<AppUser> signInWithUsernameAndPassword(String username, String password) async {
    final querySnapshot = await _db
        .collection('users')
        .where('username', isEqualTo: username)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      throw Exception('Username not found');
    }

    final userData = querySnapshot.docs.first.data();
    final email = userData['email'] as String;
    if(email.isEmpty){
      return AppUser.fromJson(querySnapshot.docs.first.id, userData);
    }else{
      return signInWithEmailAndPassword(email, password);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<AppUser?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) {
      return null;
    }
    final uid = user.uid;
    final userDoc = await _db.collection('users').doc(uid).get();
    if (!userDoc.exists) {
      return null;
    }
    return AppUser.fromJson(uid, userDoc.data()!);
  }

  Future<AppUser> signIn({ required String credential, required String password}) async {
    if(credential.isNotEmpty) {
      if (credential.isEmail) {
        return await signInWithEmailAndPassword(credential, password);
      } else {
        return await signInWithUsernameAndPassword(credential, password);
      }
    }else{
      throw Exception('Either email or username must be provided');
    }
  }

  Stream<User?> authState() => _auth.authStateChanges();


}