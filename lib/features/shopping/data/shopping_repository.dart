import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/data/auth_repository.dart';
import '../domain/models/shopping_item.dart';

class ShoppingRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static String get currentHouseholdId =>
      AuthRepository.instance.currentHouseholdId ?? 'default_home';

  static String get currentUserId =>
      AuthRepository.instance.currentUserId ?? 'unknown_user';

  static String get currentUserName =>
      AuthRepository.instance.currentUserName ?? 'Family Member';

  /// 1. Stream shopping items for the current household in real-time
  Stream<List<ShoppingItem>> getShoppingListStream() {
    return _firestore
        .collection('shopping_items')
        .where('householdId', isEqualTo: currentHouseholdId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ShoppingItem.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  /// 2. Seed initial items for a newly created household if empty
  Future<void> seedDefaultItemsIfNeeded() async {
    final snapshot = await _firestore
        .collection('shopping_items')
        .where('householdId', isEqualTo: currentHouseholdId)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) return;

    final defaults = [
      ShoppingItem(
        id: '1',
        name: 'Milk',
        quantity: 2,
        unit: 'liters',
        householdId: currentHouseholdId,
        isBought: false,
      ),
      ShoppingItem(
        id: '2',
        name: 'Bread',
        quantity: 1,
        unit: 'pack',
        householdId: currentHouseholdId,
        isBought: false,
      ),
      ShoppingItem(
        id: '3',
        name: 'Eggs',
        quantity: 12,
        unit: 'pieces',
        householdId: currentHouseholdId,
        isBought: false,
      ),
      ShoppingItem(
        id: '4',
        name: 'Chicken',
        quantity: 1,
        unit: 'kg',
        householdId: currentHouseholdId,
        isBought: false,
      ),
      ShoppingItem(
        id: '5',
        name: 'Tomatoes',
        quantity: 1,
        unit: 'kg',
        householdId: currentHouseholdId,
        isBought: false,
      ),
    ];

    final batch = _firestore.batch();
    for (final item in defaults) {
      final docRef = _firestore.collection('shopping_items').doc();
      batch.set(docRef, item.toMap()..['id'] = docRef.id);
    }
    await batch.commit();
  }

  /// 3. Add a new shopping item
  Future<void> addShoppingItem(ShoppingItem item) async {
    final docRef = _firestore.collection('shopping_items').doc();
    final data = item.toMap();
    data['id'] = docRef.id;
    data['householdId'] = currentHouseholdId;
    await docRef.set(data);
  }

  /// 4. Remove an item from the shopping list
  Future<void> deleteShoppingItem(String itemId) async {
    await _firestore.collection('shopping_items').doc(itemId).delete();
  }

  /// 5. Toggle item bought status & send notification to other household members
  Future<void> toggleItemBoughtStatus(ShoppingItem item) async {
    final newStatus = !item.isBought;
    final batch = _firestore.batch();

    final itemRef = _firestore.collection('shopping_items').doc(item.id);
    batch.update(itemRef, {
      'isBought': newStatus,
      'boughtByUserId': newStatus ? currentUserId : null,
      'boughtByUserName': newStatus ? currentUserName : null,
      'updatedAt': FieldValue.serverTimestamp(),
    });

    if (newStatus) {
      final notificationRef = _firestore.collection('notifications').doc();
      batch.set(notificationRef, {
        'id': notificationRef.id,
        'householdId': currentHouseholdId,
        'senderId': currentUserId,
        'senderName': currentUserName,
        'actionText': ' bought ',
        'itemName': item.name,
        'suffixText': ' (${item.formattedQuantity})',
        'title': 'Item Purchased!',
        'body':
        '$currentUserName bought ${item.name} (${item.formattedQuantity})',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    await batch.commit();
  }
}