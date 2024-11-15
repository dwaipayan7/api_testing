import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:api_testing/feature/models/posts_model.dart';
import 'package:api_testing/feature/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;
part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
  }

  FutureOr<void> postsInitialFetchEvent(PostsInitialFetchEvent event, Emitter<PostsState> emit) async{
    emit(PostFetchingLoadingState());
    List<PostDataUiModel> posts = await Repository.fetchPosts();
      emit(PostFetchingSuccessfulState(posts: posts));
    }
  }

