import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_files/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'cart_provider.g.dart';

@riverpod
class CartNotifier extends _$CartNotifier {
  final _db = FirebaseFirestore.instance.collection('cart');

  @override
  Set<Product> build() {
    return {}; // Start with empty set (local state)
  }

  Future<void> fetchCart() async {
    try {
      final snapshot = await _db.get();

      state = snapshot.docs
            .map((doc) => Product.fromMap(doc.data(), doc.id))
            .toSet();
    } catch (e) {
      // handle error (log or show message)
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      await _db.doc(product.title).set(product.toJson());

      // Update local state
      if (!state.contains(product)) {
        state = {...state, product};
      }
    } catch (e) {
      // handle error (log or show message)
    }
  }

  Future<void> removeProduct(Product product) async {
    try {
      await _db.doc(product.title).delete();

      // Update local state
      state = state.where((p) => p.id != product.id).toSet();
    } catch (e) {
      // handle error
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await _db.doc(product.title).update(product.toJson());

      // Update local state
      state = {
        for (final p in state)
          if (p.id == product.id) product else p,
      };
    } catch (e) {
      // handle error
    }
  }
}

// Generated notifier providers

// @riverpod
// class CartNotifier extends _$CartNotifier {
//   // Initial state
//   @override
//   Set<Product> build() {
//     return {};
//   }

//   // Method to update state
//   void addProduct(Product product) {
//     if (!state.contains(product)) {
//       state = {...state, product};
//     }
//   }

//   void removeProduct(Product product) {
//     if (state.contains(product)) {
//       state = state.where((p) => p.id != product.id).toSet();
//     }
//   }
// }

// Dependent provider

@riverpod
int cartTotal(ref) {
  final cartProducts = ref.watch(cartNotifierProvider);
  int total = 0;

  for (Product product in cartProducts) {
    total += product.price;
  }

  return total;
}