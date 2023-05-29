import 'dart:io';
import 'package:flutter/foundation.dart';
import '../models/place.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class GreatePlacesClass with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation pickedLocation) async {
    final adress = LocationHelper.getPlacesAdress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        adress: adress.toString());
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: image,
        title: title,
        location: updatedLocation);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'adress': newPlace.location.adress,
    });
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
              latitude: item['loc_lat'],
              longitude: item['loc_lng'],
              adress: item['adress'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
