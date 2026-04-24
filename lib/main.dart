import 'package:flutter/material.dart';
import 'shopping_tab.dart';
import 'summary_tab.dart';
import 'about_tab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daftar Belanja',
      theme: ThemeData(primarySwatch: Colors.deepPurple, useMaterial3: true),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> shoppingList = [];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Daftar Belanja",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[700],
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: [
            Tab(icon: Icon(Icons.shopping_cart), text: "Belanja"),
            Tab(icon: Icon(Icons.bar_chart), text: "Ringkasan"),
            Tab(icon: Icon(Icons.info_outline), text: "Tentang"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ShoppingTab(
            shoppingList: shoppingList,
            onAdd: _addItem,
            onToggle: _toggleItem,
            onDelete: _deleteItem,
          ),
          SummaryTab(shoppingList: shoppingList),
          const AboutTab(),
        ],
      ),
    );
  }

  void _addItem(String name, String category) {
    setState(() {
      shoppingList.add({'name': name, 'category': category, 'isBought': false});
    });
  }

  void _toggleItem(int index) {
    setState(() {
      if (index >= 0 && index < shoppingList.length) {
        shoppingList[index]['isBought'] = !shoppingList[index]['isBought'];
      }
    });
  }

  void _deleteItem(int index) {
    setState(() {
      if (index >= 0 && index < shoppingList.length) {
        shoppingList.removeAt(index);
      }
    });
  }
}
