import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/pviders/user_Places.dart';
import 'package:favorite_places/screens/add_place.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerWidget {
  PlacesScreen({super.key});
  final List<Place> places = [
    Place(title: 'Sydney'),
    Place(title: 'Berlin'),
    Place(title: 'Cairo'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPlaces = ref.watch(userPlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your placecs'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => AddPlaceScreen()));
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      // body: PlacesList(places: places),
      body: PlacesList(places: userPlaces),
    );
  }
}
