import 'package:amazonlike/detail.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'cart.dart';
import 'favorite.dart';


class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  HistoryScreenState createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {

  final int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    final viewedItems = Provider.of<HistoryProvider>(context).viewedItems;
    return Scaffold (
      appBar: AppBar(
        title: const Text("View History"),
        centerTitle: true,
        backgroundColor: const Color(0xFF4682B4),
        titleTextStyle: const TextStyle(color: Colors.black87, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      backgroundColor: const Color(0xFFFAFAFA),
      body: viewedItems.isEmpty
      ? const Center(
        child: Text(
          "View History is Empty!",
          style: TextStyle(fontSize: 18),
        ),
      )
      : ListView.builder(
        itemCount: viewedItems.length,
        itemBuilder: (context, index) {
          final item = viewedItems[index];
          return ListTile(
            leading: Image.asset(item["image"]!),
            title: Text(item["name"]!),
            subtitle: Text(item["price"]!, style: const TextStyle(color: Color(0xFFCD5C5C))),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                Provider.of<HistoryProvider>(context, listen: false).removeFromHistory(item);
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
              } else if (index == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FavoriteScreen())
                );
              } else if (index == 2) {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen())
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