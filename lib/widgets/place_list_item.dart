import 'package:favourite_place/models/place_model.dart';
import 'package:favourite_place/providers/place_provider.dart';
import 'package:favourite_place/screens/place_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceList extends ConsumerWidget {
  final List<Place> placeList;

  const PlaceList({
    super.key,
    required this.placeList,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
        itemCount: placeList.length,
        itemBuilder: (ctx, index) {
          var place = placeList[index];
          return Dismissible(
            key: Key(place.id),
            onDismissed: (direction) {
              ref.read(placeProvider.notifier).removePlace(place);
              _showInfoMessage(context, "Removed a place!");
            },
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.30),
              margin: const EdgeInsets.symmetric(horizontal: 5),
            ),
            child: InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => PlaceScreen(place: place))),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 26,
                  backgroundImage: FileImage(place.image),
                ),
                title: Text(place.title,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground)),
              ),
            ),
          );
        });
  }

  void _showInfoMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message), duration: const Duration(seconds: 1),),);
  }
}
