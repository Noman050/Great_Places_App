import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './add_place_screen.dart';
import '../provider/great_places.dart';
import './place_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatePlacesClass>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapShot) => snapShot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatePlacesClass>(
                child: const Center(
                  child: Text('Got no places yet, Start adding some!'),
                ),
                builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemCount: greatPlaces.items.length,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(greatPlaces.items[i].image),
                          ),
                          title: Text(greatPlaces.items[i].title),
                          subtitle: Text(greatPlaces.items[i].location.adress),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              PlaceDetailScreen.routeName,
                              arguments: greatPlaces.items[i].id,
                            );
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}
