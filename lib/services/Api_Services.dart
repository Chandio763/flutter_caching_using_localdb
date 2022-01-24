// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_caching_using_localdb/Model/UserPost.dart';
import 'package:flutter_caching_using_localdb/services/db_services.dart';

class ApiServices {
  static Future<List<UserPost>> getPosts() async {
    DbHelper dbHelper = DbHelper();
    List<UserPost> posts = [];
    var listMaps = [];
    var dio = Dio();
    try {
      var response = await dio.get(
        'https://jsonplaceholder.typicode.com/posts',
      );
      
      if (response.statusCode == 200) {
        print(response.statusCode);
        listMaps = response.data;
        for (var i = 0; i < 10; i++) {
          bool isSuccess =await dbHelper.insertPost(UserPost.fromMap(listMaps[i]));
          print(isSuccess);
        }
      }
    } catch (e) {
      listMaps=await dbHelper.fetchPosts();
      print('object');
    }
    //print(listMaps);
    for (var item in listMaps) {
      posts.add(UserPost.fromMap(item));
    }
    print(posts.length);
    return posts;
  }
}
