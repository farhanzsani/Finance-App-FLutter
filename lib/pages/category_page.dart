import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Monchaa/Models/database.dart';

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
    final row = await db.into(db.categories).insertReturning(
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
    } else {
      categoryNameController.clear();
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFCADEFC),
                  Color(0xFFE8F0FE),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: (isExpense)
                            ? Colors.red.withAlpha(50)
                            : Colors.green.withAlpha(50),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        category != null ? Icons.edit_rounded : Icons.add_rounded,
                        color: (isExpense) ? Colors.red : Colors.green,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        category != null
                            ? 'Edit Category'
                            : (isExpense ? 'Add Expense' : 'Add Income'),
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close, color: Colors.grey[600]),
                      splashRadius: 20,
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Text(
                  'Category Name',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: categoryNameController,
                  autofocus: true,
                  style: GoogleFonts.montserrat(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Enter category name',
                    hintStyle: GoogleFonts.montserrat(
                      color: Colors.grey[400],
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[200]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Color(0xFF8C9EFF),
                        width: 2,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (categoryNameController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please enter a category name'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                          
                          if (category != null) {
                            update(category.id, categoryNameController.text);
                          } else {
                            insert(categoryNameController.text, type);
                          }

                          Navigator.pop(context);
                          setState(() {});
                          categoryNameController.clear();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF8C9EFF),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Save',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            SizedBox(height: 60),
            Center(
              child: Text("Categories",
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8C9EFF),
                  )),
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                // color: Colors.white,
                
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Color(0xFFCADEFC),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isExpense = false;
                                type = 1;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: !isExpense
                                    ? Colors.white
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: !isExpense
                                    ? [
                                        BoxShadow(
                                          color: Colors.black.withAlpha(50),
                                          blurRadius: 5,
                                          offset: Offset(0, 2),
                                        ),
                                      ]
                                    : [],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.download_rounded,
                                    color: !isExpense
                                        ? Colors.green
                                        : Color(0xFF8C9EFF),
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Income',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      fontWeight: !isExpense
                                          ? FontWeight.w600
                                          : FontWeight.w500,
                                      color: !isExpense
                                          ? Colors.green
                                          : Color(0xFF8C9EFF),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isExpense = true;
                                type = 2;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: isExpense
                                    ? Colors.white
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: isExpense
                                    ? [
                                        BoxShadow(
                                          color: Colors.black.withAlpha(50),
                                          blurRadius: 1,
                                          offset: Offset(0, 2),
                                        ),
                                      ]
                                    : [],  
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.upload_rounded,
                                    color: isExpense
                                        ? Colors.red
                                        : Color(0xFF8C9EFF),
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Expense',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      fontWeight: isExpense
                                          ? FontWeight.w600
                                          : FontWeight.w500,
                                      color: isExpense
                                          ? Colors.red
                                          : Color(0xFF8C9EFF),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Categories List
            Expanded(
              child: FutureBuilder<List<Category>>(
                future: getAllCategories(type),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF8C9EFF),
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.category_outlined,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No categories yet',
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Tap the + button to add a new category',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final category = snapshot.data![index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(50),
                              blurRadius: 10,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          leading: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: (isExpense
                                      ? Colors.red
                                      : Colors.green)
                                  .withAlpha(50),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              isExpense
                                  ? Icons.upload_rounded
                                  : Icons.download_rounded,
                              color: isExpense ? Colors.red : Colors.green,
                              size: 24,
                            ),
                          ),
                          title: Text(
                            category.name,
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  openDialog(category);
                                },
                                icon: Icon(Icons.edit_rounded),
                                color: Color(0xFF8C9EFF),
                                splashRadius: 20,
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      title: Text(
                                        'Delete Category',
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      content: Text(
                                        'kamu yakin mau hapus category "${category.name}" ini chaaa ??',
                                        style: GoogleFonts.montserrat(),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text(
                                            'Cancel',
                                            style: GoogleFonts.montserrat(
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            delete(category.id);
                                            Navigator.pop(context);
                                            setState(() {});
                                          },
                                          child: Text(
                                            'Delete',
                                            style: GoogleFonts.montserrat(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                icon: Icon(Icons.delete_rounded),
                                color: Colors.red[300],
                                splashRadius: 20,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openDialog(null);
        },
        backgroundColor: Color(0xFF8C9EFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(Icons.add, color: Colors.white, size: 28),
        elevation: 4,
      ),
    );
  }
}