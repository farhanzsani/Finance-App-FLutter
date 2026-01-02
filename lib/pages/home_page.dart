
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // dashboarf total income dan expense
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Container(
                        child: Icon(Icons.download, color: Colors.green,),
                        decoration: BoxDecoration(
                          color: const Color(0xFFCADEFC),
                          borderRadius: BorderRadius.circular(8)
                          ),), 
                          SizedBox(width: 15,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("income", style: GoogleFonts.montserrat(
                                color: const Color(0xFF8C9EFF), fontSize: 12),
                                ), 
                              SizedBox(width: 10,),
                              Text("Rp. 3.880.000", style: GoogleFonts.montserrat(
                                color: const Color(0xFF8C9EFF), fontSize: 14),
                                ),
                            ],
                          )
                    ],
                    ),

                    Row(children: [
                      Container(
                        child: Icon(Icons.upload, color: Colors.red,),
                        decoration: BoxDecoration(
                          color: const Color(0xFFCADEFC),
                          borderRadius: BorderRadius.circular(8)
                          ),), 
                          SizedBox(width: 15,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Expense", style: GoogleFonts.montserrat(
                                color: const Color(0xFF8C9EFF), fontSize: 12),
                                ), 
                              SizedBox(width: 10,),
                              Text("Rp. 3.880.000", style: GoogleFonts.montserrat(
                                color: const Color(0xFF8C9EFF), fontSize: 14),
                                ),
                            ],
                          )
                    ],
                    )
                  ],
                ),
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFFCADEFC),
                  borderRadius: BorderRadius.circular(16)
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Transaksi", style: GoogleFonts.montserrat(
                fontSize: 16, fontWeight: FontWeight.bold
                ),
                ),
            ),

            // list transaksi
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 10 ,
                child: ListTile(
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.delete, color: const Color(0xFFCADEFC),),
                      SizedBox(width: 10),
                      Icon(Icons.edit, color: const Color(0xFFCADEFC),),
                    ],
                  ),
                  title: Text("Rp. 20.000"),
                  subtitle: Text("Makan siang"),
                  leading: Container(
                            child: Icon(Icons.upload, color: Colors.red,),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)
                              ),) ,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 10 ,
                child: ListTile(
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.delete, color: const Color(0xFFCADEFC),),
                      SizedBox(width: 10),
                      Icon(Icons.edit, color: const Color(0xFFCADEFC),),
                    ],
                  ),
                  title: Text("Rp. 2000.000"),
                  subtitle: Text("Gaji Bulan ini"),
                  leading: Container(
                            child: Icon(Icons.download, color: Colors.green,),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)
                              ),) ,
                ),
              ),
            )
          ],
        )) ,
    );
  }
}