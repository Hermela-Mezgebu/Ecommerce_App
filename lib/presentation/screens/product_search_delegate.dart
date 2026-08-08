import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class ProductSearchDelegate extends SearchDelegate {

  final WidgetRef ref;

  ProductSearchDelegate(this.ref);


  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text("Search products"),
    );
  }


  @override
  Widget buildResults(BuildContext context) {
    return const Center(
      child: Text("Results"),
    );
  }


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }


  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }
}