import 'package:bloc/bloc.dart';
import 'package:hero_animation/features/home/bloc/home_bloc.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {

    // on<HomeStadiumWishlistButtonClickedEvent>
  }
}
