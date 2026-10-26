import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/services/notification_service.dart';

class AuthRepository {
  static final AuthRepository instance = AuthRepository._internal();
  AuthRepository._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Cached session details for the currently logged-in user
  String? currentUserId;
  String? currentUserName;
  String? currentUserEmail;
  String? currentHouseholdId;

  User? get currentUser => _auth.currentUser;

  /// 1. Register a new user in Firebase Auth & create user document in 'users' collection
  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final user = credential.user;
    if (user == null) {
      throw Exception('Failed to create user account.');
    }

    await user.updateDisplayName(name.trim());

    final userData = {
      'uid': user.uid,
      'name': name.trim(),
      'email': email.trim(),
      'householdId': null,
      'createdAt': FieldValue.serverTimestamp(),
    };

    await _firestore.collection('users').doc(user.uid).set(userData);

    currentUserId = user.uid;
    currentUserName = name.trim();
    currentUserEmail = email.trim();
    currentHouseholdId = null;
  }

  /// 2. Sign in an existing user & load their profile from 'users' collection
  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final user = credential.user;
    if (user == null) {
      throw Exception('Invalid login credentials.');
    }

    return await loadCurrentUserSession();
  }

  /// 3. Load current user profile from Firestore and start notification listener if in a household
  /// Returns true if the user already belongs to a household, false otherwise.
  Future<bool> loadCurrentUserSession() async {
    final user = _auth.currentUser;
    if (user == null) return false;

    final doc = await _firestore.collection('users').doc(user.uid).get();

    if (doc.exists && doc.data() != null) {
      final data = doc.data()!;
      currentUserId = user.uid;
      currentUserName = data['name'] ?? user.displayName ?? 'Member';
      currentUserEmail = data['email'] ?? user.email ?? '';
      currentHouseholdId = data['householdId'] as String?;
    } else {
      // Fallback if user doc was not created yet
      currentUserId = user.uid;
      currentUserName = user.displayName ?? 'Member';
      currentUserEmail = user.email ?? '';
      currentHouseholdId = null;

      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'name': currentUserName,
        'email': currentUserEmail,
        'householdId': null,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    if (currentHouseholdId != null && currentHouseholdId!.isNotEmpty) {
      NotificationService.instance.listenToHouseholdPurchases(
        householdId: currentHouseholdId!,
        currentUserId: currentUserId!,
      );
      return true;
    }

    return false;
  }

  /// 4. Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email.trim());
  }

  /// 5. Sign out
  Future<void> signOut() async {
    NotificationService.instance.stopListening();
    await _auth.signOut();
    currentUserId = null;
    currentUserName = null;
    currentUserEmail = null;
    currentHouseholdId = null;
  }

  /// Helper to convert FirebaseAuthException into readable English messages
  static String getReadableErrorMessage(Object error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
        case 'invalid-credential':
          return 'Incorrect email or password. Please check your credentials or register a new account.';
        case 'wrong-password':
          return 'Incorrect password. Please try again.';
        case 'email-already-in-use':
          return 'This email is already registered. Please sign in instead.';
        case 'weak-password':
          return 'Password is too weak. Please use at least 6 characters.';
        case 'invalid-email':
          return 'Please enter a valid email address.';
        default:
          return error.message ?? 'Authentication failed. Please try again.';
      }
    }
    return error.toString();
  }
}