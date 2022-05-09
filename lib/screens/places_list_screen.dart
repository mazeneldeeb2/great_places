import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:great_places/screens/place_details.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Places"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                builder: (context, greatPlaces, child) {
                  // ignore: prefer_is_empty
                  return greatPlaces.places.length == 0
                      ? const Center(child: Text("No Places yet"))
                      : ListView.builder(
                          itemCount: greatPlaces.places.length,
                          itemBuilder: (context, index) => ListTile(
                            leading: CircleAvatar(
                              backgroundImage: FileImage(
                                greatPlaces.places[index].image,
                              ),
                            ),
                            title: Text(
                              greatPlaces.places[index].title,
                            ),
                            subtitle: Text(
                                greatPlaces.places[index].location!.address!),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, PlaceDetails.routeName,
                                  arguments: greatPlaces.places[index].id);
                            },
                          ),
                        );
                },
              ),
      ),
    );
  }
}
