import 'package:favourite_place/models/place_model.dart';
import 'package:flutter/material.dart';

class PlaceScreen extends StatelessWidget {
  final Place place;

  const PlaceScreen({
    super.key,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.title),),
      body: Stack(
        children: [
          Image.file(place.image, height: double.infinity, width: double.infinity, fit: BoxFit.cover,)
        ],
      ),
    );
  }

}
