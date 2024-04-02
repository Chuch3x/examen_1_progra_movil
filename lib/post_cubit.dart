import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:progra_movil_examen_1/posts.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  List<Posts> _posts = []; // Lista de posts

  PostCubit() : super(PostInitial());
  
  Future<void> fetchPosts() async {
    try {
      emit(PostLoading());
      final response =
          await Dio().get('https://jsonplaceholder.typicode.com/posts');
      final List<Posts> posts =
          (response.data as List).map((json) => Posts.fromJson(json)).toList();
      _posts = posts; // Almacenar los posts en la lista local
      emit(PostLoaded(posts));
    } catch (e) {
      emit(const PostError('Failed to fetch posts.'));
    }
  }

  // Método para calificar un post
  void ratePost(int postId, int rating) {
    final index = _posts.indexWhere((post) => post.id == postId);
    if (index != -1) {
      _posts[index].rating = rating; // Actualizar la calificación del post
      emit(PostLoaded(List.of(_posts)));
    }
  }

  void sortPostsByRating() {
    _posts.sort((a, b) => b.rating.compareTo(a.rating)); // Ordenar los posts por calificación
    emit(PostLoaded(List.of(_posts)));
  }
}
