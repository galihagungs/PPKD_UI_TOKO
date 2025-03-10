import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_store/bloc/category/category_bloc.dart';

class Sqlhome extends StatefulWidget {
  const Sqlhome({super.key});

  @override
  State<Sqlhome> createState() => _SqlhomeState();
}

class _SqlhomeState extends State<Sqlhome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Pages",
          style: TextStyle(fontFamily: "Kanit", fontSize: 25),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<CategoryBloc, CategoryState>(
              listener: (context, state) {
                if (state is CategoryFailed) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      constraints: BoxConstraints(
                        minHeight: 25,
                        minWidth: 25,
                        maxHeight: 25,
                        maxWidth: 25,
                      ),
                    ),
                  );
                } else if (state is CategorySucces) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.cattegory.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 150,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 113, 210, 255),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                  offset: Offset(2, 2), // Shadow position
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                state.cattegory[index].name.toString(),
                                style: TextStyle(
                                  fontFamily: "Kanit",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return Center(child: Text("Failed To Load Data"));
              },
            ),
          ),
        ],
      ),
    );
  }
}
