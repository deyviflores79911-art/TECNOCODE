import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<List<Product>> getProducts() async {
    // Mocking an API call
    await Future.delayed(const Duration(seconds: 1));
    return [
      const ProductModel(
        id: '1',
        name: 'iPhone 15 Pro',
        description: 'Titanium design, A17 Pro chip.',
        price: 999.99,
        imageUrl: 'https://example.com/iphone15.png',
        brand: 'Apple',
      ),
      const ProductModel(
        id: '2',
        name: 'Samsung Galaxy S24 Ultra',
        description: 'AI-powered photography and performance.',
        price: 1199.99,
        imageUrl: 'https://example.com/s24u.png',
        brand: 'Samsung',
      ),
      const ProductModel(
        id: '3',
        name: 'Google Pixel 8 Pro',
        description: 'The best of Google AI in a phone.',
        price: 899.99,
        imageUrl: 'https://example.com/pixel8.png',
        brand: 'Google',
      ),
    ];
  }

  @override
  Future<Product?> getProductById(String id) async {
    final products = await getProducts();
    return products.firstWhere((p) => p.id == id);
  }
}
