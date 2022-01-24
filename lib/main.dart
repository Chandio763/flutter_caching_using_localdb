// ignore_for_file: avoid_print, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_caching_using_localdb/services/Api_Services.dart';
import 'Model/UserPost.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: FutureBuilder<List<UserPost>>(
        future: ApiServices.getPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(snapshot.data![index].userId.toString()),
                  ),
                  title: Text(snapshot.data![index].title),
                  subtitle: Text(
                    snapshot.data![index].body,
                    maxLines: 1,
                  ),
                );
              },
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.green,
            ));
          }
        },
      ),
    );
  }
}