import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:my_finance/core/data/types/body_data.dart';

class SyncService {
  final FirebaseDatabase _db = FirebaseDatabase.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _uid => _auth.currentUser?.uid;

  Future<void> saveCategory(BodyData body, String id) async {
    if (_uid == null) return;

    try {
      await _db.ref('users/$_uid/categories/$id').set(body);
    } catch (e) {
      debugPrint("Error on sync category: $e");
    }
  }

  Future<void> deleteCategory(String id) async {
    if (_uid == null) return;

    try {
      await _db.ref('users/$_uid/categories/$id').remove();
    } catch (e) {
      debugPrint("Error on delete category sync: $e");
    }
  }

  Future<void> saveTransaction(BodyData body, String id) async {
    if (_uid == null) return;

    try {
      await _db.ref("users/$_uid/transaction/$id").set(body);
    } catch (e) {
      debugPrint("Error on sync transaction: $e");
    }
  }

  Future<void> deleteTransaction(String id) async {
    if (_uid == null) return;

    try {
      await _db.ref("users/$_uid/transaction/$id").remove();
    } catch (e) {
      debugPrint("Error on delete transaction sync: $e");
    }
  }
}
