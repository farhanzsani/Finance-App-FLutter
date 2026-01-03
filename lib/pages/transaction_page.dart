import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  bool isExpense = true;

  List<String> categoriesExpense = [
    "Makanan & Minuman",
    "Transportasi",
    "laundry",
    "jajan",
  ];

  late String dropDownValue = categoriesExpense.first;
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add New Transaction",
          style: GoogleFonts.montserrat(color: Color(0xFF8C9EFF), fontSize: 16),
        ),
        foregroundColor: Color(0xFF8C9EFF),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Switch(
                      value: isExpense,
                      onChanged: (bool value) {
                        setState(() {
                          isExpense = value;
                        });
                      },
                      inactiveTrackColor: Colors.green[200],
                      inactiveThumbColor: Colors.green,
                      activeThumbColor: Colors.red,
                      activeTrackColor: Colors.red[200],
                    ),
                    Text(
                      isExpense ? "Expense" : "Income",
                      style: GoogleFonts.montserrat(
                        color: isExpense ? Colors.red : Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Amount",
                      labelStyle: GoogleFonts.montserrat(
                        color: Color(0xFF8C9EFF),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 1,
                  ),
                  child: Text(
                    "Category",
                    style: GoogleFonts.montserrat(
                      color: Color(0xFF8C9EFF),
                      fontSize: 16,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: dropDownValue,
                    icon: Icon(Icons.arrow_downward, color: Color(0xFF8C9EFF)),
                    items: categoriesExpense.map<DropdownMenuItem<String>>((
                      String value,
                    ) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: GoogleFonts.montserrat(
                            color: Color(0xFF8C9EFF),
                            fontSize: 13,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {},
                  ),
                ),

                // SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: TextField(
                    controller: dateController,
                    readOnly: true,
                    decoration: InputDecoration(labelText: "Enter Date", labelStyle: GoogleFonts.montserrat(
                      color: Color(0xFF8C9EFF),
                    ),),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2101),
                      );

                       if (pickedDate != null){
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

                          dateController.text = formattedDate;
                        }
                      // You can handle the pickedDate here
                    },
                  ),
                ), 

                SizedBox(height: 30), 

                Center(child: ElevatedButton(onPressed: (){}, child: Text("Save")))         
              ],
            ),
          ),
        ),
      ),
    );
  }
}
