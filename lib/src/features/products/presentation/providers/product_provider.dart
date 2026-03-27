import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductProvider with ChangeNotifier {
  final ProductRepository _repository;

  ProductProvider(this._repository);

  List<Product> _products = [];
  bool _isLoading = false;
  String _searchQuery = '';
  String? _selectedBrand;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  List<Product> get filteredProducts {
    return _products.where((product) {
      final matchesSearch = product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.brand.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesBrand = _selectedBrand == null || product.brand == _selectedBrand;
      return matchesSearch && matchesBrand;
    }).toList();
  }

  List<String> get brands {
    return _products.map((p) => p.brand).toSet().toList();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSelectedBrand(String? brand) {
    _selectedBrand = brand;
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _repository.getProducts();
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
