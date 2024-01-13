// ignore: duplicate_ignore
// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'dart:io';
import 'package:favorite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: camel_case_types
class userPlacesNotifier extends StateNotifier<List<Place>> {
  userPlacesNotifier() : super(const []);
  void addPlace(String title, File? image) {
    final newPlace = Place(title: title, image: image!);
    state = [newPlace, ...state];
  }
}

//********************* */
//  void addPlace(String title, File image) {
//     final newPlace = Place(title: title, image: image);
//     state = [newPlace, ...state];
//   }
// }
//*************************** */
final userPlacesProvider =
    StateNotifierProvider<userPlacesNotifier, List<Place>>(
        (ref) => userPlacesNotifier());
