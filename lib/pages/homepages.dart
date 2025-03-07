import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_store/bloc/category/category_bloc.dart';
import 'package:ui_store/bloc/product/product_bloc.dart';
import 'package:ui_store/models/productModel.dart';
import 'package:ui_store/services/service/productService.dart';

class Homepages extends StatefulWidget {
  const Homepages({super.key});

  @override
  State<Homepages> createState() => _HomepagesState();
}

class _HomepagesState extends State<Homepages> {
  List<ProductModel>? prodMod;
  bool isLoaded = false;
  // int count = 0;

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(CategoryGet());
  }

  Future<void> loadProduct(String url) async {
    prodMod = await Productservice(url).getData(url);
  }

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
                        onTap: () {
                          context.read<ProductBloc>().add(
                            ProductGetbyUrl(
                              state.cattegory[index].url.toString(),
                            ),
                          );
                          // setState(() {
                          //   loadProduct(state.cattegory[index].url.toString());
                          // });
                        },
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

          // Expanded(flex: 10, child: Center(child: Text(prodMod.toString()))),
          // Expanded(
          //   flex: 10,
          //   child: ListView.builder(
          //     itemCount: prodMod?.length ?? 0,
          //     itemBuilder: (context, index) {
          //       return Text(prodMod?.length.toString() ?? "Null");
          //     },
          //   ),
          // ),
          Expanded(
            flex: 10,
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                print(state);
                if (state is ProductLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProductSucces) {
                  return ListView.builder(
                    itemCount: state.prod.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          state.prod[index].products?[index].title ??
                              'No Title',
                        ),
                      );
                    },
                  );
                } else if (state is ProductFailed) {
                  return Center(child: Text(e.toString()));
                }
                return Center(
                  child: Text("Select a category to view products"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
