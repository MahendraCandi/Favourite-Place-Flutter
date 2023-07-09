import 'package:favourite_place/providers/place_provider.dart';
import 'package:favourite_place/screens/add_place.dart';
import 'package:favourite_place/widgets/place_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var placeList = ref.watch(placeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Place"),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const AddPlace()));
          }, icon: const Icon(Icons.add))
        ],
      ),
      body: placeList.isEmpty ? showNoPlace(context) : PlaceList(placeList: placeList),
    );
  }

  Center showNoPlace(BuildContext context) {
    return Center(
      child: Text(
        "You don't have any place yet. Please add one by tap plus button.",
        style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
    );
  }

}
