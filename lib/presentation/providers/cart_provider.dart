import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/cart_item.dart';
import '../../domain/models/product_model.dart';

class CartNotifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() {
    return [];
  }

  /// Add a product to the cart.
  ///
  /// If the product is already in the cart,
  /// its quantity is increased.
  /// Otherwise, a new CartItem is created.
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

  /// Add an existing CartItem directly.
  void addToCart(CartItem item) {
    final index = state.indexWhere(
      (cartItem) => cartItem.product.id == item.product.id,
    );

    if (index != -1) {
      final updatedItem = state[index].copyWith(
        quantity: state[index].quantity + item.quantity,
      );

      state = [
        ...state.sublist(0, index),
        updatedItem,
        ...state.sublist(index + 1),
      ];
    } else {
      state = [
        ...state,
        item,
      ];
    }
  }

  /// Remove a product completely from the cart.
  void removeFromCart(String id) {
    state = state
        .where(
          (item) => item.product.id != id,
        )
        .toList();
  }

  /// Alias for removeFromCart.
  void removeProduct(Product product) {
    removeFromCart(product.id.toString());
  }

  /// Increase product quantity.
  void increaseQuantity(String id) {
    state = state.map((item) {
      if (item.product.id.toString() == id) {
        return item.copyWith(
          quantity: item.quantity + 1,
        );
      }

      return item;
    }).toList();
  }

  /// Decrease product quantity.
  ///
  /// If quantity reaches 0, the product is removed.
  void decreaseQuantity(String id) {
    final updatedState = <CartItem>[];

    for (final item in state) {
      if (item.product.id.toString() == id) {
        if (item.quantity > 1) {
          updatedState.add(
            item.copyWith(
              quantity: item.quantity - 1,
            ),
          );
        }
      } else {
        updatedState.add(item);
      }
    }

    state = updatedState;
  }

  /// Clear the entire cart.
  void clearCart() {
    state = [];
  }

  /// Total number of products in the cart.
  int get totalItems {
    return state.fold(
      0,
      (total, item) => total + item.quantity,
    );
  }

  /// Total price of all products in the cart.
  double get totalPrice {
    return state.fold(
      0.0,
      (total, item) =>
          total + (item.product.price * item.quantity),
    );
  }
}

final cartProvider =
    NotifierProvider<CartNotifier, List<CartItem>>(
  CartNotifier.new,
);