import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/providers/cart_provider.dart';
import 'package:riverpod_files/shared/confirm_button.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProducts = ref.watch(cartNotifierProvider);
    final total = ref.watch(cartTotalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Column(
              children: cartProducts.toList().asMap().entries.map((entry) {
                final index = entry.key;        // index of the product
                final product = entry.value;    // actual product object

                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Text('#$index'), // show index
                      const SizedBox(width: 10),
                      Image.asset(product.image, width: 60, height: 60),
                      const SizedBox(width: 10),
                      Text('${product.title}...'),
                      const Expanded(child: SizedBox()),
                      Text('£${product.price}'),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => {
                          ref.read(cartNotifierProvider.notifier).removeProduct(product),
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // output totals here
            Row(
              children: [
                Text('Total price - £$total'),
              ],
            ),

            const SizedBox(height: 20),

            // Confirm Button
            if (cartProducts.isNotEmpty)
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ConfirmButton()],
            )
          ],
        ),
      ),
    );
  }
}