import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }

}

class _LocationInputState extends State<LocationInput> {
  var _isProcessingLocation = false;

  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Theme.of(context).colorScheme.onBackground),
          ),
          child: _isProcessingLocation ? const CircularProgressIndicator() : _showNoLocationChosen(context),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text("Get Current Location"),
              onPressed: _isProcessingLocation ? null : _getCurrentLocation,
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text("Select on Map"),
              onPressed: _isProcessingLocation ? null : () {},
            ),
          ],
        ),
      ],
    );
  }

  Text _showNoLocationChosen(BuildContext context) {
    return Text(
      "No location chosen",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    );
  }

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isProcessingLocation = true;
    });

    locationData = await location.getLocation();

    setState(() {
      _isProcessingLocation = false;
    });

    print("Latitude: ${locationData.latitude} longitude: ${locationData.longitude}");
  }

}
