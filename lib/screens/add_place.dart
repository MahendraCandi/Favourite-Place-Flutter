import 'dart:io';

import 'package:favourite_place/models/place_model.dart';
import 'package:favourite_place/widgets/image_input.dart';
import 'package:favourite_place/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../providers/place_provider.dart';

const uuid = Uuid();

class AddPlace extends ConsumerStatefulWidget {
  const AddPlace({super.key});

  @override
  ConsumerState<AddPlace> createState() {
    return _AddPlaceState();
  }

}

class _AddPlaceState extends ConsumerState<AddPlace> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Place"),),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(label: Text("Title")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Invalid value";
                  }
                },
                onSaved: (value) => _title = value,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.onBackground),
              ),
              const SizedBox(height: 16),
              ImageInput(onPickImage: _onPickImage),
              const SizedBox(height: 16),
              const LocationInput(),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: Text("Add Place",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground)),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    var newPlace = Place(id: uuid.v1(), title: _title!, image: _image!);

                    // ref.read -> to read provider once
                    // use this instead of watch, because we only need to call the function
                    // not require to consume the data
                    ref.read(placeProvider.notifier).addNewPlace(newPlace);
                    _showInfoMessage(context, "Added new place!");
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPickImage(File image) {
    _image = image;
  }

  void _showInfoMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
