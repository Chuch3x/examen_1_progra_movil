import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:progra_movil_examen_1/posts.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());

  Future<void> fetchPosts() async {
    try {
      emit(PostLoading());
      final response = await Dio().get('https://jsonplaceholder.typicode.com/posts');
      final List<Posts> posts = (response.data as List).map((json) => Posts.fromJson(json)).toList();
      emit(PostLoaded(posts));
    } catch (e) {
      emit(const PostError('Failed to fetch posts.'));
    }
  }
}
