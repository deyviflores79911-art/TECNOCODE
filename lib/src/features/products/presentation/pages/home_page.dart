import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../../cart/presentation/providers/cart_provider.dart';
import '../../cart/presentation/pages/cart_page.dart';
import '../../auth/presentation/providers/auth_provider.dart';
import '../../auth/presentation/pages/login_page.dart';
import '../../orders/presentation/pages/order_history_page.dart';
import 'product_details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Store - Cell Phones'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (value) => productProvider.setSearchQuery(value),
              decoration: InputDecoration(
                hintText: 'Search for phones...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
        leading: authProvider.isAuthenticated
            ? IconButton(
                icon: const Icon(Icons.history),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OrderHistoryPage()),
                  );
                },
              )
            : IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
        actions: [
          if (authProvider.isAuthenticated)
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => authProvider.logout(),
            ),
          Consumer<CartProvider>(
            builder: (context, cart, child) => Badge(
              label: Text(cart.itemCount.toString()),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartPage()),
                  );
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            ),
          ),
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final products = provider.filteredProducts;
          final brands = provider.brands;

          return Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: brands.length + 1,
                  itemBuilder: (context, index) {
                    final isAll = index == 0;
                    final brand = isAll ? null : brands[index - 1];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(isAll ? 'All' : brand!),
                        selected: provider.brands.contains(brand) && (isAll ? provider.brands.length == 0 : true), // Simplified check
                        onSelected: (selected) {
                          provider.setSelectedBrand(isAll ? null : brand);
                        },
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: products.isEmpty
                    ? const Center(child: Text('No products found matching your search.'))
                    : ListView.builder(
                        itemCount: products.length,
                        padding: const EdgeInsets.all(16),
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  leading: const Icon(Icons.phone_android, size: 40, color: Colors.blue),
                  title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${product.brand} - \$${product.price.toStringAsFixed(2)}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsPage(product: product),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
