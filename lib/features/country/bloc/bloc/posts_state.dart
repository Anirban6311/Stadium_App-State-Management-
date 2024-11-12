part of 'posts_bloc.dart';

@immutable
sealed class PostsState {}

abstract class PostsActionState extends PostsState{}

final class PostsInitial extends PostsState {}

final class PostsfetchingLoadingState extends PostsState{}

final class PostsfetchingErrorState extends PostsState{}

final class PostFetchingSuccessfulState extends PostsState {
  final List<CountryDataModel> posts;
  PostFetchingSuccessfulState({required this.posts});
}
