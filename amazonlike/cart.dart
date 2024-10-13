import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'detail.dart';
import 'main.dart';
import 'favorite.dart';
import 'history.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {

  final int _currentIndex = 2;
  double delivery = 100.0;

  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<CartItemsProvider>(context).cartItems;

    // Reformatting and Converting Price Info
    double subtotal = cartItems.fold(0, (sum, item) {
      String priceString = item["price"]!.replaceAll("Rs. ", "");
      double price = double.parse(priceString);
      return sum + price;
    });

    if (subtotal > 0) {
      delivery = 100.0;
    }
    else {
      delivery = 0.0;
    }

    double total = subtotal + delivery;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: true,
        backgroundColor: const Color(0xFF4682B4),
        titleTextStyle: const TextStyle(color: Colors.black87, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      backgroundColor: const Color(0xFFFAFAFA),
      body: Column(
        children: [
          Expanded(
            child: cartItems.isEmpty
            ? const Center(
              child: Text(
                "Cart is Empty!",
                style: TextStyle(fontSize: 18),
              ),
            )
                : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  leading: Image.asset(item["image"]!),
                  title: Text(item["name"]!),
                  subtitle: Text(item["price"]!, style: const TextStyle(color: Color(0xFFCD5C5C))),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      Provider.of<CartItemsProvider>(context, listen: false)
                          .removeCartItem(item);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailScreen(item: item)
                        )
                    );
                  },
                );
              },
            ),
          ),
          // New Container section below the list
          Container(
            width: double.infinity,
            height: 270,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: const Offset(0, 3),
                  )],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0)
                ),
                color: Colors.white
            ),
            //margin: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Padding (
              padding: const EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Subtotal:', style: TextStyle(fontSize: 18)),
                      Text('₹$subtotal', style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Delivery Fee:', style: TextStyle(fontSize: 18)),
                      Text('₹$delivery', style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('₹$total', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () {
                    },
                    style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFF4682B4),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        elevation: 5, // Controls the shadow height
                        shadowColor: Colors.grey.withOpacity(0.5),
                        minimumSize: const Size(double.infinity, 50)
                    ),
                    child: const Center(
                      child: Text(
                        'Continue to Checkout',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
          onTap: (index) {
            try {
              if (index == 0) {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AmazonLikeScreen())
                );
              } else if (index == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FavoriteScreen())
                );
              } else if (index == 3) {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HistoryScreen())
                );
              }
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Navigation error: $e"))
              );
            }
          },
          items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Search',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History'
          )
        ],
        selectedItemColor: const Color(0xFF4682B4),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.black87,
        type: BottomNavigationBarType.fixed, // Ensure even spacing of items
      ),
    );
  }
}
