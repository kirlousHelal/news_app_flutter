import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../modules/webview_screen.dart';

Widget itemArticleBulider(
        {required Map<String, dynamic> article, required context}) =>
    InkWell(
      onTap: () {
        navigateTo(context, WebviewScreen(url: article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage("${article['urlToImage']}"),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${article['title']}",
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("${article['publishedAt']}"),
                ],
              ),
            )
          ],
        ),
      ),
    );

Widget articleBuilder({
  required list,
  required RefreshCallback function,
}) =>
    RefreshIndicator(
      onRefresh: function,
      color: Colors.deepOrange,
      child: ConditionalBuilder(
          condition: list.isNotEmpty,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) =>
                  itemArticleBulider(article: list[index], context: context),
              separatorBuilder: (context, index) => Container(
                    height: 1,
                    color: Colors.grey,
                  ),
              itemCount: list.length),
          fallback: (context) => const Center(
                  child: CircularProgressIndicator(
                color: Colors.deepOrange,
              ))),
    );

ThemeData lightTheme() => ThemeData(
    primarySwatch: Colors.deepOrange,
    // Customize TextFormField globally
    inputDecorationTheme: InputDecorationTheme(
      // Default label color (grey when unfocused)
      labelStyle: const TextStyle(
        color: Colors.deepOrange,
      ),
      // Prefix icon color (grey when unfocused)
      prefixIconColor: Colors.deepOrange,

      // Border when not focused
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.grey, width: 1),
      ),
      // Border when focused
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.deepOrange, width: 2),
      ),
      // Icon color when focused
      focusColor: Colors.deepOrange,
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.deepOrange,
        type: BottomNavigationBarType.fixed),
    hintColor: Colors.black,
    textTheme: const TextTheme(
        bodyMedium: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black)));

ThemeData darkTheme() => ThemeData(
    primarySwatch: Colors.deepOrange,
    // Global primary color
    hintColor: Colors.white,
    // Customize TextFormField globally
    inputDecorationTheme: InputDecorationTheme(
      // Default label color (grey when unfocused)
      labelStyle: const TextStyle(
        color: Colors.deepOrange,
      ),
      // Prefix icon color (grey when unfocused)
      prefixIconColor: Colors.deepOrange,

      // Border when not focused
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.grey, width: 1),
      ),
      // Border when focused
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.deepOrange, width: 2),
      ),
      // Icon color when focused
      focusColor: Colors.deepOrange,
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black54,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black54,
            statusBarIconBrightness: Brightness.light),
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black54,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.deepOrange,
        type: BottomNavigationBarType.fixed),
    scaffoldBackgroundColor: Colors.black54,
    textTheme: const TextTheme(
        bodyMedium: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)));

void navigateTo(context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}
