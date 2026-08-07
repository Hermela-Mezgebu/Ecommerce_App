import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/product_provider.dart';
import 'product_details_page.dart';

class ProductSearchDelegate extends SearchDelegate {
  final WidgetRef ref;

  ProductSearchDelegate(this.ref);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildList();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildList();
  }

  Widget _buildList() {
    final products = ref.watch(productsProvider);

    return products.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (e, s) => const Center(
        child: Text('Error loading products'),
      ),
      data: (items) {
        final filtered = items.where((p) {
          return p.title
              .toLowerCase()
              .contains(query.toLowerCase());
        }).toList();

        if (filtered.isEmpty) {
          return const Center(
            child: Text('No products found'),
          );
        }

        return ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final product = filtered[index];

            return ListTile(
              leading: Image.network(
                product.image,
                width: 50,
                height: 50,
              ),
              title: Text(product.title),
              subtitle: Text('\$${product.price}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailsPage(
                      product: product,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}