import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_store/bloc/category/category_bloc.dart';
import 'package:ui_store/bloc/product/product_bloc.dart';

class Homepages extends StatefulWidget {
  const Homepages({super.key});

  @override
  State<Homepages> createState() => _HomepagesState();
}

class _HomepagesState extends State<Homepages> {
  // List<ProductModel>? prodMod;
  // bool isLoaded = false;
  // int count = 0;
  // final DbHelper _helper = new DbHelper();

  @override
  void initState() {
    super.initState();
    // var db = new NewData();

    context.read<CategoryBloc>().add(CategoryGet());
  }

  // _helper.getData(CountryQuery.TABLE_NAME).then((value) {
  //     value.forEach((element) {
  //       Country country = Country.fromJson(element);
  //       print(country.toJson());
  //     });
  //   });

  // Future<void> loadProduct(String url) async {
  //   prodMod = await Productservice(url).getData(url);
  // }

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
          Expanded(
            flex: 10,
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                // print(state);
                if (state is ProductLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProductSucces) {
                  return ListView.builder(
                    itemCount: state.prod.total,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  state.prod.products?[index].id.toString() ??
                                      "Null",
                                ),
                                Text(
                                  state.prod.products?[index].title
                                          .toString() ??
                                      "Null",
                                ),
                                Text(state.map2[index]['title'].toString()),
                                // Text(
                                //   state.prod.products?[index].description ??
                                //       "Null",
                                // ),
                              ],
                            ),
                          ),
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
