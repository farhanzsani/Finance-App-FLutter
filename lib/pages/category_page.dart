import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:finance_app_for_nacha/Models/database.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isExpense = true;
  int type = 2;
  final AppDatabase db = AppDatabase();

  TextEditingController categoryNameController = TextEditingController();

  Future insert(String name, int type) async {
    DateTime now = DateTime.now();
    final row = await db
        .into(db.categories)
        .insertReturning(
          CategoriesCompanion.insert(
            name: name,
            type: type,
            created: now,
            updated_at: now,
          ),
        );

    print(row);
  }

  Future<List<Category>> getAllCategories(int type) async {
    return await db.getAllCategoryRepo(type);
  }

  Future update(int id, String name) async {
    return await db.updateCategoryRepo(id, name);
  }

  Future delete(int id) async {
    return await db.deleteCategoryRepo(id);
  }

  void openDialog(Category? category) {

    if (category != null) {
      categoryNameController.text = category.name;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFCADEFC),
          content: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Text(
                    (isExpense)
                        ? 'Add Expense category'
                        : 'Add Income category',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      color: (isExpense) ? Colors.red : Colors.green,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: categoryNameController,
                    decoration: InputDecoration(
                      hintText: 'category name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (category != null) {
                        update(category.id, categoryNameController.text);
                      } else {
                        insert(categoryNameController.text, type);
                      }
                    
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                      setState((){});
                      categoryNameController.clear();
                    },
                    child: Text(
                      'save',
                      style: GoogleFonts.montserrat(color: Color(0xFF8C9EFF)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Switch(
                  value: isExpense,
                  onChanged: (bool value) {
                    setState(() {
                      isExpense = value;
                      type = value ? 2 : 1;
                    });
                  },
                  inactiveTrackColor: Colors.green[200],
                  inactiveThumbColor: Colors.green,
                  activeThumbColor: Colors.red,
                  activeTrackColor: Colors.red[200],
                ),
                IconButton(
                  onPressed: () {
                    openDialog(null);
                  },
                  icon: Icon(Icons.add, color: Color(0xFF8C9EFF)),
                ),
              ],
            ),
          ),

          
          FutureBuilder<List<Category>>(
            future: getAllCategories(type),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData){
                  if (snapshot.data!.length > 0){
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final category = snapshot.data![index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            child: Card(
                              elevation: 10,
                              child: ListTile(
                                leading: (isExpense)
                                    ? Icon(Icons.upload, color: Colors.red)
                                    : Icon(Icons.download, color: Colors.green),
                                title: Text(category.name),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        delete(category.id);
                                        setState((){});
                                      },
                                      icon: Icon(Icons.delete),
                                      color: Color(0xFF8C9EFF),
                                    ),
                                    SizedBox(width: 10),
                                    IconButton(
                                      onPressed: () {
                                        openDialog(snapshot.data![index]);
                                      },
                                      icon: Icon(Icons.edit),
                                      color: Color(0xFF8C9EFF),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: Text('No categories found.'),
                    );
                  }
                } else {
                  return Center(
                    child: Text('No categories found.'),
                  );
                }
              }
            })
        ],
      ),
    );
  }
}
