part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistState {}

class WishListedActionState extends WishlistState {}

final class WishlistInitial extends WishlistState {}

class WishListedSuccessState extends WishlistState {
  //if the wishlist is success then load the stadiums

  final List<StadiumDataModel> wishlistStadiums;
  WishListedSuccessState({required this.wishlistStadiums});
}
