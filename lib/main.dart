import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider/great_places.dart';
import './screens/place_list_screen.dart';
import './screens/add_place_screen.dart';
import './screens/place_detail_screen.dart';

void main() => runApp(GreatPlaces());

class GreatPlaces extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatePlacesClass(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
