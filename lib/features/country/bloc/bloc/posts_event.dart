part of 'posts_bloc.dart';

@immutable
sealed class PostsEvent {}

class PostsInitialFetchEvent extends PostsEvent {
  final String country;
  PostsInitialFetchEvent({required this.country});
}
