// ignore: duplicate_ignore
// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'dart:io';
import 'package:favorite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

// ignore: camel_case_types
Future<Database> _getDatabase() async {
  final dbpath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbpath, 'place.db'),
    onCreate: (db, version) {
      //return db.execute('Create TABLE user_places(id TEXT PRIMARY KEY, title TEXT ,image TEXT,lat REAL,lng REAL,address TEXT)');
      return db.execute(
          'Create TABLE user_places(id TEXT PRIMARY KEY ,title TEXT, image TEXT)');
    },
    version: 1,
  );
  return db;
}

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  Future<void> lodplaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');
    final places = data
        .map((row) => Place(
              id: row['id'] as String,
              title: row['title'] as String,
              image: File(row['image'] as String),
              // location: PlaceLocation(latitude:row['latitude'] as double,
              // longtitude:row['longtitude'] as double,
              // address: row['address'] as String),
            ))
        .toList();
    state = places;
  }

  void addPlace(String title, File? image) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final filename = path.basename(image!.path);
    final copiedImage = await image.copy('${appDir.path}/$filename');

    final newPlace = Place(title: title, image: copiedImage);

    final db = await _getDatabase();
    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      // 'lat' : newPlace.location.latitude,
      // 'lng' : newPlace.location.longtitude,
      // 'lat' : newPlace.location.address,
    });

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
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
        (ref) => UserPlacesNotifier());
