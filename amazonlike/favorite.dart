import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'cart.dart';
import 'history.dart';
import 'detail.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  FavoriteScreenState createState() => FavoriteScreenState();
}

class FavoriteScreenState extends State<FavoriteScreen> {

  final int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {

    final likedItems = Provider.of<LikedItemsProvider>(context).likedItems;

    return Scaffold (
      appBar: AppBar(
        title: const Text("Favorite Items"),
        centerTitle: true,
        backgroundColor: const Color(0xFF4682B4),
        titleTextStyle: const TextStyle(color: Colors.black87, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      backgroundColor: const Color(0xFFFAFAFA),
      body: likedItems.isEmpty
      ? const Center(
        child: Text(
          "No Favorite Items!",
          style: TextStyle(fontSize: 18),
        ),
      )
      : ListView.builder(
        itemCount: likedItems.length,
        itemBuilder: (context, index) {
          final item = likedItems[index];
          return ListTile(
            leading: Image.asset(item["image"]!),
            title: Text(item["name"]!),
            subtitle: Text(item["price"]!, style: const TextStyle(color: Color(0xFFCD5C5C))),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                Provider.of<LikedItemsProvider>(context, listen: false)
                    .removeLikedItem(item);
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
          onTap: (index) {
            try {
              if (index == 0) {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AmazonLikeScreen())
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