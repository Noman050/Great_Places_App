import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/great_places.dart';
import './map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectPlace =
        Provider.of<GreatePlacesClass>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectPlace.title),
      ),
      body: Column(children: [
        Container(
          height: 250,
          width: double.infinity,
          child: Image.file(
            selectPlace.image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          selectPlace.location.adress,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (ctx) => MapScreen(
                  initialLocation: selectPlace.location,
                  isSelecting: false,
                ),
              ),
            );
          },
          child: const Text('View on map!'),
          textColor: Theme.of(context).primaryColor,
        ),
      ]),
    );
  }
}
