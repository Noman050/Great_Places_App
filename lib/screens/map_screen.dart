import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;
  MapScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 37.422, longitude: -122.084),
      this.isSelecting = false});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _picedLocation;
  void _selectLocation(LatLng position) {
    setState(() {
      _picedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map!'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: _picedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_picedLocation);
                    },
              icon: Icon(Icons.check),
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: (_picedLocation == null && widget.isSelecting)
            ? null
            : {
                Marker(
                  markerId: MarkerId('m1'),
                  position: _picedLocation ??
                      LatLng(widget.initialLocation.latitude,
                          widget.initialLocation.longitude),
                ),
              },
      ),
    );
  }
}
