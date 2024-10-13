import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CartScreen(),
    );
  }
}

class CartScreen extends StatefulWidget {
  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  int appleCount = 0;
  int orangeCount = 0;
  int delivery  = 0;

  int _selectedIndex = 1;

  @override
  Widget build (BuildContext context) {
    if (appleCount >= 1 || orangeCount >= 1) {
      delivery = 100;
    }
    else {
      delivery = 0;
    }
      int subtotal = ((appleCount * 50) + (orangeCount * 30));
      int total = subtotal + delivery;

    return Scaffold(
      appBar: AppBar(title: Text('Your Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // List Items
            Container(
              width: double.infinity,
              height: 160,
              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 8.0),
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: Offset(0, 3),
                  )
                ]
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 5),
                  Image.asset(
                    'images/apple.png',
                    height: 90,
                    width: 90,
                  ),
                  SizedBox(width: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Apple',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: 130),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.add),
                        color: Colors.green,
                        iconSize:25,
                        onPressed: () {
                          setState(() {
                            appleCount++;
                          });
                        }
                      ),
                      Text(appleCount.toString()),
                      IconButton(
                          icon: Icon(Icons.remove),
                          color: Colors.green,
                          iconSize: 25,
                          onPressed: () {
                            setState(() {
                              appleCount--;
                            });
                          }
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 160,
              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 8.0),
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(0, 3),
                    )
                  ]
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 5),
                  Image.asset(
                    'images/orange.png',
                    height: 90,
                    width: 90,
                  ),
                  SizedBox(width: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Orange',
                      style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 18)
                      )
                    ],
                  ),
                  SizedBox(width: 120),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: Icon(Icons.add),
                          color: Colors.green,
                          iconSize: 25,
                          onPressed: () {
                            setState(() {
                              orangeCount++;
                            });
                          }
                      ),
                      Text(orangeCount.toString()),
                      IconButton(
                          icon: Icon(Icons.remove),
                          color: Colors.green,
                          iconSize: 25,
                          onPressed: () {
                            setState(() {
                              orangeCount--;
                            });
                          }
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 200),
            Container(
              width: double.infinity,
              height: 270,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: Offset(0, 3),
                )],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0)
                ),
                color: Colors.white
              ),
              //margin: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Padding (
                padding: EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Subtotal:', style: TextStyle(fontSize: 18)),
                          Text('₹$subtotal', style: TextStyle(fontSize: 18)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Delivery Fee:', style: TextStyle(fontSize: 18)),
                          Text('₹$delivery', style: TextStyle(fontSize: 18)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total:', style: TextStyle(fontSize: 18)),
                          Text('₹$total', style: TextStyle(fontSize: 18)),
                        ],
                      ),
                      SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () {
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          elevation: 5, // Controls the shadow height
                          shadowColor: Colors.grey.withOpacity(0.5),
                          minimumSize: Size(double.infinity, 50)
                        ),
                        child: Center(
                          child: Text(
                            'Continue to Checkout               ₹$total',
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Checkout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.green,
        currentIndex: _selectedIndex,
      ),
    );
  }
}