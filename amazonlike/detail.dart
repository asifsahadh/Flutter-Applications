import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favorite.dart';
import 'history.dart';
import 'cart.dart';
import 'main.dart';

class CartItemsProvider with ChangeNotifier {
  final List<Map<String, String>> _cartItems = [];
  List<Map<String, String>> get cartItems => _cartItems;

  void addCartItem(Map<String, String> item) {
    if (!_cartItems.contains(item)) {
      _cartItems.add(item);
      notifyListeners();
    }
  }

  void removeCartItem(Map<String, String> item) {
    _cartItems.remove(item);
    notifyListeners();
  }
}

class LikedItemsProvider with ChangeNotifier {
  final List<Map<String, String>> _likedItems = [];
  List<Map<String, String>> get likedItems => _likedItems;

  void addLikedItem(Map<String, String> item) {
    if (!_likedItems.contains(item)) {
      _likedItems.add(item);
      notifyListeners();
    }
  }

  void removeLikedItem(Map<String, String> item) {
    _likedItems.remove(item);
    notifyListeners();
  }
}

class DetailScreen extends StatefulWidget {
  final Map<String, String> item;
  const DetailScreen({super.key, required this.item});

  @override
  DetailScreenState createState() => DetailScreenState();
}

class DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4682B4),
      ),
      backgroundColor: const Color(0xFFFAFAFA),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(widget.item["image"]!, height: 450, width: 450), // Product Image,
            ),
            const SizedBox(height: 20),
            Text(
              widget.item["name"]!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.item["price"]!,
              style: const TextStyle(fontSize: 20, color: Color(0xFFCD5C5C)),
            ),
            const SizedBox(height: 30),
            Text(
              widget.item["desc"]!,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Provider.of<CartItemsProvider>(context, listen: false).addCartItem(widget.item); // Cart Button Function
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Item added to Cart!'),
                            duration: Duration(seconds: 2),
                          )
                      );
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
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Like Button
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.favorite),
                    color: const Color(0xFFCD5C5C),
                    onPressed: () {
                      Provider.of<LikedItemsProvider>(context, listen: false).addLikedItem(widget.item); // Like Button Function
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Item added to Favorites!'),
                          duration: Duration(seconds: 2),
                        )
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        selectedItemColor: Colors.black87,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.black87,
        type: BottomNavigationBarType.fixed, // Ensure even spacing of items
          onTap: (index) {
            try {
              if (index == 0) {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AmazonLikeScreen())
                );
              }
              else if (index == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FavoriteScreen())
                );
              } else if (index == 2) {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen())
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
          }

      ),
    );
  }
}