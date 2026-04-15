import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import '../models/user_model.dart';
import '../models/cart_model.dart';

class FirebaseService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  // --- AUTH & PROFILE ---
  static Future<UserModel?> registerUser({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = cred.user;
      if (user != null) {
        final model = UserModel(email: email, password: password, name: username);
        // Buat doc auth users
        await _firestore.collection('users').doc(user.uid).set(model.toMap());
        
        // Buat detail profil
        await _firestore.collection('users').doc(user.uid).update({
          'foto': '',
          'noHp': '-',
          'alamat': '-',
        });
        return model;
      }
    } on FirebaseAuthException catch (e) {
      print("Register Error FirebaseAuthException: ${e.message}");
      rethrow;
    } catch (e) {
      print("Register Error: $e");
      rethrow;
    }
    return null;
  }

  static Future<UserModel?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (cred.user != null) {
        final doc = await _firestore.collection('users').doc(cred.user!.uid).get();
        if (doc.exists) {
           return UserModel.fromMap(doc.data()!);
        }
      }
    } on FirebaseAuthException catch (e) {
      print("Login FirebaseAuthException: ${e.message}");
      rethrow; // Rethrow to handle wrong password or user not found
    } catch (e) {
      print("Login Error: $e");
      rethrow;
    }
    return null;
  }

  static Future<void> logoutUser() async {
    await _auth.signOut();
  }

  static Future<Map<String, dynamic>?> getProfile([String? emailOrUid]) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      return doc.data();
    } catch (e) {
      print("Get Profile Error: $e");
    }
    return null;
  }

  static Future<void> updateProfileName(String newName) async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      await _firestore.collection('users').doc(uid).update({'name': newName});
    }
  }

  static Future<void> updateProfilePhoto(File imageFile) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;
    try {
      final ext = p.extension(imageFile.path);
      final ref = _storage.ref().child('profile_pictures/$uid$ext');
      await ref.putFile(imageFile);
      final downloadUrl = await ref.getDownloadURL();
      await _firestore.collection('users').doc(uid).update({'foto': downloadUrl});
    } catch (e) {
      print("Update Photo Error: $e");
      rethrow;
    }
  }

  // --- CART & ORDER ---
  static Future<void> addToCart(CartItem item) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;
    await _firestore.collection('users').doc(uid).collection('cart').add(item.toMap());
  }

  static Future<List<CartItem>> getCartItems() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return [];
    final snapshot = await _firestore.collection('users').doc(uid).collection('cart').orderBy('date', descending: true).get();
    return snapshot.docs.map((doc) => CartItem.fromMap(doc.data(), doc.id)).toList();
  }

  static Future<void> deleteCartItem(String docId) async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      await _firestore.collection('users').doc(uid).collection('cart').doc(docId).delete();
    }
  }

  static Future<void> updateCartItemNotes(String docId, String notes) async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      await _firestore.collection('users').doc(uid).collection('cart').doc(docId).update({'notes': notes});
    }
  }

  static Future<void> checkout(List<CartItem> cartItems) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null || cartItems.isEmpty) return;

    final batch = _firestore.batch();
    final userDocRef = _firestore.collection('users').doc(uid);

    for (var item in cartItems) {
      // Create new order doc
      item.date = DateTime.now().toString().substring(0, 16);
      final newOrderRef = userDocRef.collection('orders').doc();
      batch.set(newOrderRef, item.toMap());

      // Delete cart item
      if (item.id.isNotEmpty) {
        final cartItemRef = userDocRef.collection('cart').doc(item.id);
        batch.delete(cartItemRef);
      }
    }
    await batch.commit();
  }

  static Future<List<CartItem>> getOrders() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return [];
    final snapshot = await _firestore.collection('users').doc(uid).collection('orders').orderBy('date', descending: true).get();
    return snapshot.docs.map((doc) => CartItem.fromMap(doc.data(), doc.id)).toList();
  }

  // --- REQUEST ORDER ---
  static Future<void> addRequestOrder(String content) async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      await _firestore.collection('users').doc(uid).collection('request_orders').add({
        'content': content,
        'created_at': FieldValue.serverTimestamp(),
      });
    }
  }

  static Future<List<Map<String, dynamic>>> getRequestOrders() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return [];
    final snapshot = await _firestore.collection('users').doc(uid).collection('request_orders').orderBy('created_at', descending: true).get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
  }

  static Future<void> updateRequestOrder(String docId, String content) async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      await _firestore.collection('users').doc(uid).collection('request_orders').doc(docId).update({
        'content': content,
      });
    }
  }

  static Future<void> deleteRequestOrder(String docId) async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      await _firestore.collection('users').doc(uid).collection('request_orders').doc(docId).delete();
    }
  }
}
