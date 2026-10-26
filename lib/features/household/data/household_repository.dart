import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/services/notification_service.dart';
import '../../auth/data/auth_repository.dart';
import '../../shopping/data/shopping_repository.dart';

class HouseholdRepository {
  static final HouseholdRepository instance = HouseholdRepository._internal();
  HouseholdRepository._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _generateInviteCode() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final rnd = Random();
    return String.fromCharCodes(
      Iterable.generate(6, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))),
    );
  }

  /// 1. Create a new household and link the current user as Owner
  Future<Map<String, dynamic>> createHousehold(String homeName) async {
    final uid = AuthRepository.instance.currentUserId;
    if (uid == null) {
      throw Exception('You must be logged in to create a home.');
    }

    final docRef = _firestore.collection('households').doc();
    final inviteCode = _generateInviteCode();

    final householdData = {
      'id': docRef.id,
      'homeName': homeName.trim(),
      'inviteCode': inviteCode,
      'ownerId': uid,
      'memberIds': [uid],
      'createdAt': FieldValue.serverTimestamp(),
    };

    final batch = _firestore.batch();
    batch.set(docRef, householdData);
    batch.update(_firestore.collection('users').doc(uid), {
      'householdId': docRef.id,
    });
    await batch.commit();

    AuthRepository.instance.currentHouseholdId = docRef.id;

    // Start listening for purchases in this household
    NotificationService.instance.listenToHouseholdPurchases(
      householdId: docRef.id,
      currentUserId: uid,
    );

    // Seed initial shopping list items for the new home
    await ShoppingRepository().seedDefaultItemsIfNeeded();

    return householdData;
  }

  /// 2. Join an existing household using a 6-character invite code
  Future<void> joinHouseholdByCode(String code) async {
    final uid = AuthRepository.instance.currentUserId;
    if (uid == null) {
      throw Exception('You must be logged in to join a home.');
    }

    final cleanCode = code.replaceAll(' ', '').trim().toUpperCase();
    final query = await _firestore
        .collection('households')
        .where('inviteCode', isEqualTo: cleanCode)
        .limit(1)
        .get();

    if (query.docs.isEmpty) {
      throw Exception('Invalid invite code. No home found with this code.');
    }

    final householdDoc = query.docs.first;
    final householdId = householdDoc.id;

    final batch = _firestore.batch();
    batch.update(householdDoc.reference, {
      'memberIds': FieldValue.arrayUnion([uid]),
    });
    batch.update(_firestore.collection('users').doc(uid), {
      'householdId': householdId,
    });
    await batch.commit();

    AuthRepository.instance.currentHouseholdId = householdId;

    // Start listening for purchases in this household
    NotificationService.instance.listenToHouseholdPurchases(
      householdId: householdId,
      currentUserId: uid,
    );
  }

  /// 3. Stream current household document
  Stream<DocumentSnapshot<Map<String, dynamic>>>? getCurrentHouseholdStream() {
    final householdId = AuthRepository.instance.currentHouseholdId;
    if (householdId == null || householdId.isEmpty) return null;
    return _firestore.collection('households').doc(householdId).snapshots();
  }

  /// 4. Stream all members belonging to the current household
  Stream<QuerySnapshot<Map<String, dynamic>>>? getHouseholdMembersStream() {
    final householdId = AuthRepository.instance.currentHouseholdId;
    if (householdId == null || householdId.isEmpty) return null;
    return _firestore
        .collection('users')
        .where('householdId', isEqualTo: householdId)
        .snapshots();
  }
}