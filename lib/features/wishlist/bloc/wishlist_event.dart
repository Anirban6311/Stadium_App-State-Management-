part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistEvent {}

class WishListInitialEvent extends WishlistEvent {}

class WishlistRemoveFromWishlist extends WishlistEvent {
  //fetch through the constructor
  final StadiumDataModel stadiumDataModel;
  WishlistRemoveFromWishlist({required this.stadiumDataModel});
}
