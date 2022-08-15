import 'dart:async';

import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeProductsRepository {
  final List<Product> _products = kTestProducts;

  Future<List<Product>> getProductsList() {
    return Future.value(_products);
  }

  Product? getProduct(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Future<List<Product>> fetchProductsList() async {
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(_products);
  }

  Stream<List<Product>> watchProductsList() async* {
    await Future.delayed(const Duration(seconds: 2));
    yield _products;
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductsList()
        .map((products) => products.firstWhere((product) => product.id == id));
  }

  // get list of products from a search query as a stream
  Stream<List<Product>> searchProducts(String query) {
    return watchProductsList().map((products) {
      return products
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}

final productsRepositoryProvider =
    Provider.autoDispose<FakeProductsRepository>((ref) {
  return FakeProductsRepository();
});

final productsListStreamProvider =
    StreamProvider.autoDispose<List<Product>>((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);

  return productsRepository.watchProductsList();
});

final productsListFutureProvider =
    FutureProvider.autoDispose<List<Product>>((ref) async {
  final productsRepository = ref.watch(productsRepositoryProvider);

  return await productsRepository.fetchProductsList();
});

// write a provider that returns a stream of products that match the search query string
final productsListQueryStreamProvider =
    StreamProvider.family.autoDispose<List<Product>, String>((ref, query) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.searchProducts(query);
});

// final productProvider = StreamProvider.family<Product?, String>((ref, id) {
//   final productsRepository = ref.watch(productsRepositoryProvider);
//   return productsRepository.watchProduct(id);
// });

final productProvider =
    StreamProvider.family.autoDispose<Product?, String>((ref, id) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProduct(id);
});
