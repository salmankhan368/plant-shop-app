import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final String name;
  final String address;
  final String phone;
  final String paymentMethod;
  final double totalPrice;
  const OrderConfirmationScreen({
    super.key,
    required this.name,
    required this.address,
    required this.phone,
    required this.paymentMethod,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Iconsax.tick_circle, color: Colors.green, size: 90),
              const SizedBox(height: 20),
              const Text(
                'Order Placed Successfully!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: $name'),
                    SizedBox(height: 6),
                    Text('Address: $address'),
                    SizedBox(height: 6),
                    Text('Phone: $phone'),
                    SizedBox(height: 6),
                    Text(
                      'Payement: ${paymentMethod == 'cod' ? 'Cash on Delivery' : 'card ****1234'}',
                    ),
                    Divider(height: 24),
                    Text(
                      'Total Paid: \$${totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Back to Home',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
