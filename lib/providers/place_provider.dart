import 'package:favourite_place/models/place_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceProviderNotifier extends StateNotifier<List<Place>> {
  PlaceProviderNotifier() : super(const []); // use const so this list couldn't be updated

  void addNewPlace(Place place) {
    state = [...state, place];
  }

  void removePlace(Place place) {
    state = state.where((availablePlace) => availablePlace.id != place.id).toList();
  }
}

final placeProvider = StateNotifierProvider<PlaceProviderNotifier, List<Place>>(
        (ref) => PlaceProviderNotifier()
);
