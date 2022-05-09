import 'package:flutter/material.dart';
import 'package:great_places/compenents/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);
  static const String routeName = "/addPlaceScreen";

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a New Place"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  const Text("User Input"),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: "Title",
                    ),
                    controller: _titleController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const ImageInput()
                ]),
              ),
            ),
          ),
          ElevatedButton.icon(
            style: ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: MaterialStateProperty.all(Colors.amber),
            ),
            onPressed: () {},
            icon: const Icon(
              Icons.add,
              color: Colors.black,
              size: 30,
            ),
            label: const Text(
              "Add place",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
