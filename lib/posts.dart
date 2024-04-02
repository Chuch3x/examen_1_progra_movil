import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  late List<dynamic> _posts;
  
  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    try {
      Response response = await Dio().get('https://jsonplaceholder.typicode.com/posts');
      setState(() {
        _posts = response.data;
      });
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts List'),
      ),
      body: _posts != null
          ? ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_posts[index]['title']),
                  subtitle: Text(_posts[index]['body']),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}