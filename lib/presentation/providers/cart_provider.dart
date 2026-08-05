import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/cart_item_model.dart';
import '../../domain/models/product_model.dart';

class CartNotifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() {
    return [];
  }

  void addProduct(Product product) {
    final index = state.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index != -1) {
      final updatedItem = state[index].copyWith(
        quantity: state[index].quantity + 1,
      );

      state = [
        ...state.sublist(0, index),
        updatedItem,
        ...state.sublist(index + 1),
      ];
    } else {
      state = [
        ...state,
        CartItem(
          product: product,
          quantity: 1,
        ),
      ];
    }
  }

  void removeProduct(Product product) {
    state = state
        .where((item) => item.product.id != product.id)
        .toList();
  }

  void increaseQuantity(Product product) {
    final index = state.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index == -1) return;

    final updatedItem = state[index].copyWith(
      quantity: state[index].quantity + 1,
    );

    state = [
      ...state.sublist(0, index),
      updatedItem,
      ...state.sublist(index + 1),
    ];
  }

  void decreaseQuantity(Product product) {
    final index = state.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index == -1) return;

    if (state[index].quantity > 1) {
      final updatedItem = state[index].copyWith(
        quantity: state[index].quantity - 1,
      );

      state = [
        ...state.sublist(0, index),
        updatedItem,
        ...state.sublist(index + 1),
      ];
    } else {
      state = [
        ...state.sublist(0, index),
        ...state.sublist(index + 1),
      ];
    }
  }

  void clearCart() {
    state = [];
  }

  double get totalPrice {
    return state.fold(
      0,
      (sum, item) => sum + item.product.price * item.quantity,
    );
  }

  int get totalItems {
    return state.fold(
      0,
      (sum, item) => sum + item.quantity,
    );
  }
}

final cartProvider =
    NotifierProvider<CartNotifier, List<CartItem>>(
  CartNotifier.new,
);