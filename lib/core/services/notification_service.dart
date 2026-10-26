import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService instance = NotificationService._internal();
  NotificationService._internal();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  StreamSubscription<QuerySnapshot>? _purchaseSubscription;
  String? _activeHouseholdId;

  /// 1. Initialize notifications on app startup
  Future<void> init() async {
    await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    const androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      settings: initSettings,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        showLocalNotification(
          title: message.notification!.title ?? 'Talaga',
          body: message.notification!.body ?? '',
        );
      }
    });
  }

  /// 2. Display local push notification on device
  Future<void> showLocalNotification({
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'talaga_household_channel',
      'Household Updates',
      channelDescription: 'Notifications when a family member buys an item',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    await _localNotifications.show(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: title,
      body: body,
      notificationDetails: notificationDetails,
    );
  }

  /// 3. Listen to household purchases in real-time and notify other members
  void listenToHouseholdPurchases({
    required String householdId,
    required String currentUserId,
  }) {
    if (_activeHouseholdId == householdId && _purchaseSubscription != null) {
      return;
    }

    _purchaseSubscription?.cancel();
    _activeHouseholdId = householdId;

    final startTime = Timestamp.now();

    _purchaseSubscription = FirebaseFirestore.instance
        .collection('notifications')
        .where('householdId', isEqualTo: householdId)
        .where('createdAt', isGreaterThan: startTime)
        .snapshots()
        .listen((snapshot) {
      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          final data = change.doc.data();
          if (data == null) continue;

          // Only show push notification to other family members, not the buyer
          if (data['senderId'] != currentUserId) {
            showLocalNotification(
              title: data['title'] ?? 'Shopping List Updated',
              body: data['body'] ?? 'A household item was marked as bought.',
            );
          }
        }
      }
    });
  }

  /// 4. Stop listening when user signs out
  void stopListening() {
    _purchaseSubscription?.cancel();
    _purchaseSubscription = null;
    _activeHouseholdId = null;
  }
}