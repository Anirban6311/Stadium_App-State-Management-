import 'dart:async';

// import 'package:api_bloc/features/posts/repos/posts_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/posts_data_ui_model.dart';
import '../../repos/posts_repo.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
  }

  FutureOr<void> postsInitialFetchEvent(
      PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
    emit(PostsfetchingLoadingState());
    // final List<CountryDataModel> posts = await PostsRepo(country: event.country).fetchPosts();
    try {
      List<CountryDataModel> posts = await PostsRepo.fetchPosts(event.country);
      emit(PostFetchingSuccessfulState(posts: posts));
    } catch (e) {
      emit(PostsfetchingErrorState());
    }
  }
}
