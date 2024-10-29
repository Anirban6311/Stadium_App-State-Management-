import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hero_animation/features/home/models/home_stadium_data_model.dart';
import 'package:meta/meta.dart';

import '../../../data/wishlist_items.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishListInitialEvent>(wishListInitialEvent);
    on<WishlistRemoveFromWishlist>(removeFromWishListEvent);
  }

  FutureOr<void> wishListInitialEvent(
      WishListInitialEvent event, Emitter<WishlistState> emit) {
    emit(WishListedSuccessState(wishlistStadiums: wishlistStadiums));
  }

  FutureOr<void> removeFromWishListEvent(
      WishlistRemoveFromWishlist event, Emitter<WishlistState> emit) {
    wishlistStadiums.remove(event.stadiumDataModel);
    emit(WishListedSuccessState(wishlistStadiums: wishlistStadiums));
  }
}
