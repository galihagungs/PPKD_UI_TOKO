import 'package:flutter/material.dart';
import 'package:ui_store/models/categoryModel.dart';
import 'package:ui_store/services/api/category.dart';
import 'package:ui_store/services/service/categoryService.dart';

class Homepages extends StatefulWidget {
  const Homepages({super.key});

  @override
  State<Homepages> createState() => _HomepagesState();
}

class _HomepagesState extends State<Homepages> {
  List<CategoryModel>? catModel;
  bool isLoaded = false;

  void iniState() {
    super.initState();
    loadCat();
    // context.read<CategoryBloc>().add(CategoryGet());
  }

  Future<void> loadCat() async {
    catModel = await Categoryservice().getData();
    // setState(() {
    //   isLoaded = true;
    // });
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
      body: ListView.builder(
        itemCount: catModel?.length,
        itemBuilder: (context, index1) {
          return Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.all(5),
            child: Column(children: [Text("ASA")]),
          );
        },
      ),
    );
  }
}
