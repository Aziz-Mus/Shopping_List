import 'package:flutter/material.dart';

class ShoppingTab extends StatefulWidget {
  final List<Map<String, dynamic>> shoppingList;
  final Function(String, String) onAdd;
  final Function(int) onToggle;
  final Function(int) onDelete;

  const ShoppingTab({
    super.key,
    required this.shoppingList,
    required this.onAdd,
    required this.onDelete,
    required this.onToggle,
  });
  @override
  State<ShoppingTab> createState() => _ShoppingTabState();
}

class _ShoppingTabState extends State<ShoppingTab> {
  final TextEditingController _itemController = TextEditingController();
  String _selectedCategory = 'Makanan';
  final List<String> _category = [
    'Makanan',
    'Minuman',
    'Kebutuhan Rumah',
    'Lainnya',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.deepPurple[700],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.only(top: 16, bottom: 25, left: 25, right: 25),
            child: Column(
              children: [
                TextField(
                  controller: _itemController,
                  decoration: InputDecoration(
                    hintText: "Nama Barang",
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.3),
                      fontWeight: FontWeight.bold,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButton<String>(
                          value: _selectedCategory,
                          isExpanded: true,
                          underline: const SizedBox(),
                          items: _category.map((category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          255,
                          255,
                          255,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (_itemController.text.isNotEmpty) {
                          widget.onAdd(_itemController.text, _selectedCategory);
                          _itemController.clear();
                        }
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.deepPurple,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: widget.shoppingList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 40,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Daftar Belanja Kosong",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    itemCount: widget.shoppingList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: IconButton(
                            icon: Icon(
                              (widget.shoppingList[index]['isBought'])
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              color: (widget.shoppingList[index]['isBought'])
                                  ? Colors.deepPurple
                                  : Colors.grey,
                            ),
                            onPressed: () => widget.onToggle(index),
                          ),
                          title: Text(
                            widget.shoppingList[index]['category'],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: Colors.grey,
                            ),
                          ),
                          subtitle: Text(
                            widget.shoppingList[index]['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              decoration:
                                  (widget.shoppingList[index]['isBought'])
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.edit_note_outlined,
                                  color: Colors.teal,
                                ),
                                onPressed: () {
                                  _showEditListDialog(index);
                                },
                              ),
                              IconButton(
                                onPressed: () {
                                  _showAlertDelete(index);
                                },
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showEditListDialog(int index) {
    final editController = TextEditingController(
      text: widget.shoppingList[index]['name'],
    );
    String editCategory = widget.shoppingList[index]['category'];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: Colors.white,
              title: const Text("Edit List Belanja"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: editController,
                    decoration: InputDecoration(
                      hintText: "Nama Barang",
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.3),
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: DropdownButton<String>(
                      value: editCategory,
                      isExpanded: true,
                      underline: const SizedBox(),
                      items: _category.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setStateDialog(() {
                          editCategory = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextButton(
                          onPressed: () {
                            editController.dispose();
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Batal",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple[700],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            if (editController.text.isNotEmpty) {
                              setState(() {
                                widget.shoppingList[index]['name'] =
                                    editController.text;
                                widget.shoppingList[index]['category'] =
                                    editCategory;
                              });
                              editController.dispose();
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            "Simpan",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showAlertDelete(int index) {
    String _selectedDelete = widget.shoppingList[index]['name'];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.warning_outlined, color: Colors.red),
              const SizedBox(height: 5),
              const Text("Yakin Ingin Menghapus List Ini?"),
              const SizedBox(height: 5),
              Text('"$_selectedDelete"'),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Batal",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        widget.onDelete(index);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Hapus",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
