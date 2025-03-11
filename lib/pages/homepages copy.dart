// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ui_store/bloc/category/category_bloc.dart';
// import 'package:ui_store/bloc/product/product_bloc.dart';

// class Homepages extends StatefulWidget {
//   const Homepages({super.key});

//   @override
//   State<Homepages> createState() => _HomepagesState();
// }

// class _HomepagesState extends State<Homepages> {
//   @override
//   void initState() {
//     super.initState();
//     // context.read<CategoryBloc>().add(CategoryGet());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Inventory",
//           style: TextStyle(fontFamily: "Kanit", fontSize: 25),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: Colors.white,
//                     child: Container(
//                       color: Colors.white,
//                       child: Icon(Icons.person),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Text(
//                     "Selamat Datang, User",
//                     style: TextStyle(fontFamily: "Kanit", fontSize: 15),
//                   ),
//                 ],
//               ),
//               IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
//             ],
//           ),
//           SizedBox(height: 25),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   flex: 7,
//                   child: TextField(
//                     decoration: InputDecoration(
//                       fillColor: Colors.white,
//                       filled: true,
//                       hintStyle: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w300,
//                         color: Colors.white,
//                       ),
//                       hintText: "Search",
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: BorderSide(
//                           width: 1,
//                           color: Color(0xFFC4C4C4),
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: BorderSide(
//                           width: 1,
//                           color: Color(0xFFC4C4C4),
//                         ),
//                       ),
//                       contentPadding: EdgeInsets.symmetric(
//                         horizontal: 20,
//                         vertical: 10,
//                       ),
//                       prefixIcon: Icon(Icons.search_rounded),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: IconButton(
//                     onPressed: () {},
//                     icon: Icon(Icons.app_settings_alt),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           Expanded(
//             child: BlocConsumer<CategoryBloc, CategoryState>(
//               listener: (context, state) {
//                 if (state is CategoryFailed) {
//                   ScaffoldMessenger.of(
//                     context,
//                   ).showSnackBar(SnackBar(content: Text(e.toString())));
//                 }
//               },
//               builder: (context, state) {
//                 if (state is CategoryLoading) {
//                   return Center(
//                     child: CircularProgressIndicator(
//                       constraints: BoxConstraints(
//                         minHeight: 25,
//                         minWidth: 25,
//                         maxHeight: 25,
//                         maxWidth: 25,
//                       ),
//                     ),
//                   );
//                 } else if (state is CategorySucces) {
//                   return ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: state.cattegory.length,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () {
//                           context.read<ProductBloc>().add(
//                             ProductGetbyUrl(
//                               state.cattegory[index].url.toString(),
//                               state.cattegory[index].name.toString(),
//                             ),
//                           );
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             width: 150,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.15),
//                                   spreadRadius: 0,
//                                   blurRadius: 5,
//                                   offset: Offset(2, 2), // Shadow position
//                                 ),
//                               ],
//                             ),
//                             child: Center(
//                               child: Text(
//                                 state.cattegory[index].name.toString(),
//                                 style: TextStyle(
//                                   fontFamily: "Kanit",
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }
//                 return Center(child: Text("Failed To Load Data"));
//               },
//             ),
//           ),
//           Expanded(
//             flex: 10,
//             child: BlocBuilder<ProductBloc, ProductState>(
//               builder: (context, state) {
//                 // print(state);
//                 if (state is ProductLoading) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (state is ProductSucces) {
//                   return ListView.builder(
//                     itemCount: state.map2.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.grey,
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 Text(state.map2[index]['id'].toString()),
//                                 Text(state.map2[index]['title'].toString()),
//                                 Text(
//                                   state.map2[index]['description'].toString(),
//                                 ),
//                                 Text(state.map2[index]['price'].toString()),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 } else if (state is ProductFailed) {
//                   return Center(child: Text(e.toString()));
//                 }
//                 return Center(
//                   child: Text("Select a category to view products"),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
